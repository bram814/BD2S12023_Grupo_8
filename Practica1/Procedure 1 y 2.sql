-- =========================================================================================================================
-- Author    Fecha        Descripción
-- =======   ==========   ==================================================================================================
--           17/02/2023   PR1.
-- =========================================================================================================================
ALTER TABLE practica1.Usuarios ALTER COLUMN Email VARCHAR(100);

ALTER TABLE practica1.Usuarios ADD CONSTRAINT Unique_email UNIQUE (Email);

DROP PROCEDURE practica1.PR1;

CREATE PROCEDURE practica1.PR1
    @first_name nvarchar(max),
    @last_name nvarchar(max),
    @email nvarchar(max),
    @password nvarchar(max),
    @credits int
 AS BEGIN
    BEGIN TRANSACTION
        BEGIN TRY
            DECLARE @student_id uniqueidentifier;
            SET @student_id = NEWID();

			--PROCESO PARA VALIDACION DE DATOS
			DECLARE @validacionFirstName varchar(1);
			DECLARE @validacionLastName varchar(1);
			EXEC practica1.PR6 @first_name,  0,  @validacionFirstName OUTPUT ;
			EXEC practica1.PR6 @last_name, 0,  @validacionLastName OUTPUT;
			
			-- PRIMERO VERIFICO FIRSTNAME
			if @validacionFirstName = 'F' BEGIN
			    ROLLBACK TRANSACTION;
                --INSERT INTO practica1.HistoryLog (Date, Description) VALUES (GETDATE(), N'PR1: Transacción fallida');
                PRINT N'First name debe tener solo letras.';
            END ELSE BEGIN
				-- SI FIRSTNAME ESTA BIEN, VERIFICO LAST NAME
				if @validacionLastName = 'F' BEGIN
					ROLLBACK TRANSACTION;
					--INSERT INTO practica1.HistoryLog (Date, Description) VALUES (GETDATE(), N'PR1: Transacción fallida');
					PRINT N'Last name debe tener solo letras';
				END ELSE BEGIN
					--EMPIEZO A INSERTAR EN TABLA USUARIOS
					INSERT INTO
					practica1.Usuarios (Id, Firstname, Lastname, Email, DateOfBirth, Password, LastChanges, EmailConfirmed)
					VALUES
						(@student_id, @first_name, @last_name, @email, GETDATE(), @password, GETDATE(), 0);
					
					-- INSERTO EN TABLA USUARIOROLE
					INSERT INTO
						practica1.UsuarioRole (RoleId, UserId, IsLatestVersion)
					VALUES
						((SELECT Id FROM practica1.Roles WHERE RoleName = 'Student'), @student_id, 1);

					-- VERIFICO QUE LOS CREDITOS SEAN POSITIVOS
					IF @credits < 0 BEGIN
						ROLLBACK TRANSACTION;
						INSERT INTO practica1.HistoryLog (Date, Description) VALUES (GETDATE(), N'PR1: Transacción fallida');
						PRINT N'El número de creditos debe ser un numero positivo';
					END ELSE BEGIN
						-- INSERTO EN LA TABLA PROFILE STUDENT
						INSERT INTO
							practica1.ProfileStudent (UserId, Credits)
						VALUES
							(@student_id, @credits);

						-- INSERTO EN LA TABLA TFA
						INSERT INTO
							practica1.TFA (UserId, Status, LastUpdate)
						VALUES
							(@student_id, 1, GETDATE());

						-- INSERTO EN LA TABLA NOTIFICACION
						INSERT INTO
							practica1.Notification (UserId, Message, Date)
						VALUES
							(@student_id, N'Usuario registrado con exito, verifique su email', GETDATE());
                
						COMMIT TRANSACTION;
						PRINT N'Transacción realizada con exito';
					END
				
				END		
			END           
        END TRY
        BEGIN CATCH
            ROLLBACK TRANSACTION;
            INSERT INTO practica1.HistoryLog (Date, Description) VALUES (GETDATE(), N'PR1: Transacción fallida');
            PRINT N'Transacción fallida, oscurrió un error inesperado, puede que su email este repetido.';
        END CATCH
END;

-- =========================================================================================================================
-- Author    Fecha        Descripción
-- =======   ==========   ==================================================================================================
--           18/02/2023   PR2.
-- =========================================================================================================================

CREATE PROCEDURE practica1.PR2
    @email nvarchar(max),
    @cod_course int
AS BEGIN
    BEGIN TRANSACTION
        BEGIN TRY
            DECLARE @student_id uniqueidentifier;
           -- VERIFICO QUE EL EMAIL ESTE CONFIRMADO
            IF (SELECT EmailConfirmed FROM practica1.Usuarios WHERE Email = @email) = 1 BEGIN
                -- OBTENGO EL ID DEL ESTUDIANTE
	            SET @student_id = (SELECT Id FROM practica1.Usuarios WHERE Email = @email);
	           
	           -- INSERTO ROL DE TUTOR
                INSERT INTO
                    practica1.UsuarioRole (RoleId, UserId, IsLatestVersion)
                VALUES
                    ((SELECT Id FROM practica1.Roles WHERE RoleName = 'Tutor'), @student_id, 1);
                   
                --CREO PERFIL DE TUTOR
                INSERT INTO
                    practica1.TutorProfile (UserId, TutorCode)
                VALUES
                    (@student_id, 'CodigoTutor');
                   
                -- SE LE ASIGNA CODIGO DE CURSO AL TUTOR
                INSERT INTO
                    practica1.CourseTutor (TutorId, CourseCodCourse)
                VALUES
                    (@student_id, @cod_course);
                   
                -- CREO MI NOTIFICACION
                INSERT INTO
                    practica1.Notification (UserId, Message, Date)
                VALUES
                    (@student_id, N'Se le ha asignado como tutor del curso ' + (SELECT Name FROM practica1.Course WHERE CodCourse = @cod_course), GETDATE());
                --INSERT INTO HistoryLog (Date, Description) VALUES (GETDATE(), N'PR2: Transacción exitosa');
                COMMIT TRANSACTION;
                PRINT N'Transacción realizada con exito';
               
            -- EMAIL NO CONFIRMADO
            END ELSE BEGIN
                ROLLBACK TRANSACTION;
                INSERT INTO practica1.HistoryLog (Date, Description) VALUES (GETDATE(), N'PR2: Transacción fallida');
                PRINT N'El usuario no ha sido confirmado';
            END
        END TRY
        BEGIN CATCH
            ROLLBACK TRANSACTION;
            INSERT INTO practica1.HistoryLog (Date, Description) VALUES (GETDATE(), N'PR2: Transacción fallida');
            PRINT N'Transaccion fallida, ocurrió un error inesperado.';
        END CATCH
END;

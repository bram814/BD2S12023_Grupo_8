create table Course
(
    CodCourse       int           not null
        constraint PK_Course
            primary key,
    Name            nvarchar(max) not null,
    CreditsRequired int           not null
        constraint CHK_COURSE_CREDISREQUIRED
            check (NOT [CreditsRequired] like '%[a-zA-Z]%' AND [CreditsRequired] like '%[0-9]%')
        constraint CHK_PersonAge
            check (NOT [CreditsRequired] like '%[a-zA-Z]%' AND [CreditsRequired] like '%[0-9]%')
)
go

CREATE TRIGGER practica1.Delete_Course ON practica1.Course
AFTER DELETE
AS
    BEGIN
        BEGIN TRY
            BEGIN TRANSACTION
            -- DELETE
            INSERT INTO practica1.HistoryLog (practica1.HistoryLog.Date, practica1.HistoryLog.Description)
            VALUES(GETDATE(),'PR5: Se ha eliminado un curso');
            COMMIT TRANSACTION;
        END TRY
        BEGIN CATCH
            ROLLBACK TRANSACTION;
            PRINT 'Error al insertar en la tabla HistoryLog'
        END CATCH
    END
go

CREATE TRIGGER practica1.Insert_Course ON practica1.Course
AFTER INSERT
AS
    BEGIN
        BEGIN TRY
            BEGIN TRANSACTION
            -- INSERT
            INSERT INTO practica1.HistoryLog (practica1.HistoryLog.Date, practica1.HistoryLog.Description)
            VALUES(GETDATE(),'PR5: Se ha creado un nuevo curso');
            COMMIT TRANSACTION;
        END TRY
        BEGIN CATCH
            ROLLBACK TRANSACTION;
            PRINT 'Error al insertar en la tabla HistoryLog'
        END CATCH
    END
go

CREATE TRIGGER practica1.Update_Course ON practica1.Course
AFTER UPDATE
AS
    BEGIN
        BEGIN TRY
            BEGIN TRANSACTION
            -- UPDATE
            INSERT INTO practica1.HistoryLog (practica1.HistoryLog.Date, practica1.HistoryLog.Description)
            VALUES(GETDATE(),'PR5: Se ha actualizado un curso');
            COMMIT TRANSACTION;
        END TRY
        BEGIN CATCH
            ROLLBACK TRANSACTION;
            PRINT 'Error al insertar en la tabla HistoryLog'
        END CATCH
    END
go

create table HistoryLog
(
    Id          int identity
        constraint PK_HistoryLog
            primary key,
    Date        datetime2     not null,
    Description nvarchar(max) not null
)
go

create table Roles
(
    Id       uniqueidentifier not null
        constraint PK_Roles
            primary key,
    RoleName nvarchar(max)    not null
)
go

CREATE TRIGGER practica1.trigg_role_delete
on practica1.Roles
AFTER DELETE
as BEGIN
      BEGIN TRY
          BEGIN TRANSACTION
          INSERT INTO practica1.HistoryLog (Date, Description) VALUES (GETDATE(), N'PR4: Eliminación de rol exitosa.');
          COMMIT TRANSACTION;
      END TRY
      BEGIN CATCH
          ROLLBACK TRANSACTION;
          PRINT N'ERROR, OCURRIO UN ERROR INESPERADO';
      END CATCH
END;
go

CREATE TRIGGER practica1.trigg_role_insertar
on practica1.Roles
FOR insert
as BEGIN
      BEGIN TRY
          BEGIN TRANSACTION
          INSERT INTO practica1.HistoryLog (Date, Description) VALUES (GETDATE(), N'PR4: Transacción creacion de rol exitosa.');
          COMMIT TRANSACTION;
      END TRY
      BEGIN CATCH
          ROLLBACK TRANSACTION;
          PRINT N'ERROR, OCURRIO UN ERROR INESPERADO';
      END CATCH
END;
go

CREATE TRIGGER practica1.trigg_role_update
on practica1.Roles
AFTER UPDATE
as BEGIN
      BEGIN TRY
          BEGIN TRANSACTION
          INSERT INTO practica1.HistoryLog (Date, Description) VALUES (GETDATE(), N'PR4: Actualización de rol exitosa.');
          COMMIT TRANSACTION;
      END TRY
      BEGIN CATCH
          ROLLBACK TRANSACTION;
          PRINT N'ERROR, OCURRIO UN ERROR INESPERADO';
      END CATCH
END;
go

create table Usuarios
(
    Id             uniqueidentifier not null
        constraint PK_Usuarios
            primary key,
    Firstname      nvarchar(max)    not null
        constraint CHK_COURSE_NAME
            check ([Firstname] like '%[a-zA-Z]%' AND NOT [Firstname] like '%[0-9]%')
        constraint CHK_USUARIOS_Firstname
            check ([Firstname] like '%[a-zA-Z]%' AND NOT [Firstname] like '%[0-9]%'),
    Lastname       nvarchar(max)    not null
        constraint CHK_USUARIOS_Lastname
            check ([Lastname] like '%[a-zA-Z]%' AND NOT [Lastname] like '%[0-9]%'),
    Email          varchar(100)
        constraint Unique_email
            unique,
    DateOfBirth    datetime2        not null,
    Password       nvarchar(max)    not null,
    LastChanges    datetime2        not null,
    EmailConfirmed bit              not null
)
go

create table CourseAssignment
(
    Id              int identity
        constraint PK_CourseAssignment
            primary key,
    StudentId       uniqueidentifier not null
        constraint FK_CourseAssignment_Usuarios_StudentId
            references Usuarios
            on delete cascade,
    CourseCodCourse int              not null
        constraint FK_CourseAssignment_Course_CourseCodCourse
            references Course
            on delete cascade
)
go

create index IX_CourseAssignment_CourseCodCourse
    on CourseAssignment (CourseCodCourse)
go

create index IX_CourseAssignment_StudentId
    on CourseAssignment (StudentId)
go

CREATE TRIGGER practica1.Delete_CourseAssignment ON practica1.CourseAssignment
AFTER DELETE
AS
    BEGIN
        BEGIN TRY
            BEGIN TRANSACTION
            -- DELETE
            INSERT INTO practica1.HistoryLog (practica1.HistoryLog.Date, practica1.HistoryLog.Description)
            VALUES(GETDATE(),'PR3: Se ha eliminado una asignación de curso');
            COMMIT TRANSACTION;
        END TRY
        BEGIN CATCH
            ROLLBACK TRANSACTION;
            PRINT 'Error al insertar en la tabla HistoryLog'
        END CATCH
    END
go

CREATE TRIGGER practica1.Insert_CourseAssignment ON practica1.CourseAssignment
AFTER INSERT
AS
    BEGIN
        BEGIN TRY
            BEGIN TRANSACTION
            -- INSERT
            INSERT INTO practica1.HistoryLog (practica1.HistoryLog.Date, practica1.HistoryLog.Description)
            VALUES(GETDATE(),'PR3: Se ha asignado un curso');
            COMMIT TRANSACTION;
        END TRY
        BEGIN CATCH
            ROLLBACK TRANSACTION;
            PRINT 'Error al insertar en la tabla HistoryLog'
        END CATCH
    END
go

CREATE TRIGGER practica1.Update_CourseAssignment ON practica1.CourseAssignment
AFTER UPDATE
AS
    BEGIN
        BEGIN TRY
            BEGIN TRANSACTION
            -- UPDATE
            INSERT INTO practica1.HistoryLog (practica1.HistoryLog.Date, practica1.HistoryLog.Description)
            VALUES(GETDATE(),'PR3: Se ha actualizado una asignación de curso');
            COMMIT TRANSACTION;
        END TRY
        BEGIN CATCH
            ROLLBACK TRANSACTION;
            PRINT 'Error al insertar en la tabla HistoryLog'
        END CATCH
    END
go

create table CourseTutor
(
    Id              int identity
        constraint PK_CourseTutor
            primary key,
    TutorId         uniqueidentifier not null
        constraint FK_CourseTutor_Usuarios_TutorId
            references Usuarios
            on delete cascade,
    CourseCodCourse int              not null
        constraint FK_CourseTutor_Course_CourseCodCourse
            references Course
            on delete cascade
)
go

create index IX_CourseTutor_CourseCodCourse
    on CourseTutor (CourseCodCourse)
go

create index IX_CourseTutor_TutorId
    on CourseTutor (TutorId)
go

CREATE TRIGGER CourseTutor_Delete
on practica1.CourseTutor
FOR Delete
as BEGIN
	  begin try
	  	  BEGIN TRANSACTION
		  INSERT INTO practica1.HistoryLog (Date, Description) VALUES (GETDATE(), N'PR1: Eliminacion de CourseTutor exitosa');
	      COMMIT TRANSACTION;
	   end try
	   begin catch
		  ROLLBACK TRANSACTION;
		  PRINT N'ERROR, OCURRIO UN ERROR INESPERADO';
	   end catch
END;
go

CREATE TRIGGER CourseTutor_Insertar
on practica1.CourseTutor
FOR insert
as BEGIN
	  begin try
	  	  BEGIN TRANSACTION
		  INSERT INTO practica1.HistoryLog (Date, Description) VALUES (GETDATE(), N'PR1: Transacción creacion de CourseTutor exitosa');
	      COMMIT TRANSACTION;
	   end try
	   begin catch
		  ROLLBACK TRANSACTION;
		  PRINT N'ERROR, OCURRIO UN ERROR INESPERADO';
	   end catch
END;
go

CREATE TRIGGER CourseTutor_Update
on practica1.CourseTutor
FOR Update
as BEGIN
	  begin try
	  	  BEGIN TRANSACTION
		  INSERT INTO practica1.HistoryLog (Date, Description) VALUES (GETDATE(), N'PR1: Actualizacion de CourseTutor exitosa');
	      COMMIT TRANSACTION;
	   end try
	   begin catch
		  ROLLBACK TRANSACTION;
		  PRINT N'ERROR, OCURRIO UN ERROR INESPERADO';
	   end catch
END;
go

create table Notification
(
    Id      int identity
        constraint PK_Notification
            primary key,
    UserId  uniqueidentifier not null
        constraint FK_Notification_Usuarios_UserId
            references Usuarios
            on delete cascade,
    Message nvarchar(max)    not null,
    Date    datetime2        not null
)
go

create index IX_Notification_UserId
    on Notification (UserId)
go

CREATE TRIGGER Notification_Delete
on practica1.Notification
FOR Delete
as BEGIN
	  begin try
	  	  BEGIN TRANSACTION
		  INSERT INTO practica1.HistoryLog (Date, Description) VALUES (GETDATE(), N'PR1: Eliminacion de Notification exitosa');
	      COMMIT TRANSACTION;
	   end try
	   begin catch
		  ROLLBACK TRANSACTION;
		  PRINT N'ERROR, OCURRIO UN ERROR INESPERADO';
	   end catch
END;
go

CREATE TRIGGER Notification_Insertar
on practica1.Notification
FOR insert
as BEGIN
	  begin try
	  	  BEGIN TRANSACTION
		  INSERT INTO practica1.HistoryLog (Date, Description) VALUES (GETDATE(), N'PR1: Transacción creacion de Notification exitosa');
	      COMMIT TRANSACTION;
	   end try
	   begin catch
		  ROLLBACK TRANSACTION;
		  PRINT N'ERROR, OCURRIO UN ERROR INESPERADO';
	   end catch
END;
go

CREATE TRIGGER Notification_Update
on practica1.Notification
FOR Update
as BEGIN
	  begin try
	  	  BEGIN TRANSACTION
		  INSERT INTO practica1.HistoryLog (Date, Description) VALUES (GETDATE(), N'PR1: Actualizacion de Notification exitosa');
	      COMMIT TRANSACTION;
	   end try
	   begin catch
		  ROLLBACK TRANSACTION;
		  PRINT N'ERROR, OCURRIO UN ERROR INESPERADO';
	   end catch
END;
go

create table ProfileStudent
(
    Id      int identity
        constraint PK_ProfileStudent
            primary key,
    UserId  uniqueidentifier not null
        constraint FK_ProfileStudent_Usuarios_UserId
            references Usuarios
            on delete cascade,
    Credits int              not null
)
go

create index IX_ProfileStudent_UserId
    on ProfileStudent (UserId)
go

CREATE TRIGGER ProfileStudent_Delete
on practica1.ProfileStudent
FOR DELETE
as BEGIN
	  begin try
	  	  BEGIN TRANSACTION
		  INSERT INTO practica1.HistoryLog (Date, Description) VALUES (GETDATE(), N'PR1: Eliminacion ProfileStudent exitosa');
	      COMMIT TRANSACTION;
	   end try
	   begin catch
		  ROLLBACK TRANSACTION;
		  PRINT N'ERROR, OCURRIO UN ERROR INESPERADO';
	   end catch
END;
go

CREATE TRIGGER ProfileStudent_Insertar
on practica1.ProfileStudent
FOR insert
as BEGIN
	  begin try
	  	  BEGIN TRANSACTION
		  INSERT INTO practica1.HistoryLog (Date, Description) VALUES (GETDATE(), N'PR1: Transacción creacion de ProfileStudent exitosa');
	      COMMIT TRANSACTION;
	   end try
	   begin catch
		  ROLLBACK TRANSACTION;
		  PRINT N'ERROR, OCURRIO UN ERROR INESPERADO';
	   end catch
END;
go

CREATE TRIGGER ProfileStudent_Update
on practica1.ProfileStudent
FOR UPDATE 
as BEGIN
	  begin try
	  	  BEGIN TRANSACTION
		  INSERT INTO practica1.HistoryLog (Date, Description) VALUES (GETDATE(), N'PR1: Actualizacion ProfileStudent exitosa');
	      COMMIT TRANSACTION;
	   end try
	   begin catch
		  ROLLBACK TRANSACTION;
		  PRINT N'ERROR, OCURRIO UN ERROR INESPERADO';
	   end catch
END;
go

create table TFA
(
    Id         int identity
        constraint PK_TFA
            primary key,
    UserId     uniqueidentifier not null
        constraint FK_TFA_Usuarios_UserId
            references Usuarios
            on delete cascade,
    Status     bit              not null,
    LastUpdate datetime2        not null
)
go

create index IX_TFA_UserId
    on TFA (UserId)
go

CREATE TRIGGER TFA_Delete
on practica1.TFA
FOR Delete
as BEGIN
	  begin try
	  	  BEGIN TRANSACTION
		  INSERT INTO practica1.HistoryLog (Date, Description) VALUES (GETDATE(), N'PR1: Eleminacion de TFA exitosa');
	      COMMIT TRANSACTION;
	   end try
	   begin catch
		  ROLLBACK TRANSACTION;
		  PRINT N'ERROR, OCURRIO UN ERROR INESPERADO';
	   end catch
END;
go

CREATE TRIGGER TFA_Insertar
on practica1.TFA
FOR insert
as BEGIN
	  begin try
	  	  BEGIN TRANSACTION
		  INSERT INTO practica1.HistoryLog (Date, Description) VALUES (GETDATE(), N'PR1: Transacción creacion de TFA exitosa');
	      COMMIT TRANSACTION;
	   end try
	   begin catch
		  ROLLBACK TRANSACTION;
		  PRINT N'ERROR, OCURRIO UN ERROR INESPERADO';
	   end catch
END;
go

CREATE TRIGGER TFA_Update
on practica1.TFA
FOR Update
as BEGIN
	  begin try
	  	  BEGIN TRANSACTION
		  INSERT INTO practica1.HistoryLog (Date, Description) VALUES (GETDATE(), N'PR1: Actualizacion de TFA exitosa');
	      COMMIT TRANSACTION;
	   end try
	   begin catch
		  ROLLBACK TRANSACTION;
		  PRINT N'ERROR, OCURRIO UN ERROR INESPERADO';
	   end catch
END;
go

create table TutorProfile
(
    Id        int identity
        constraint PK_TutorProfile
            primary key,
    UserId    uniqueidentifier not null
        constraint FK_TutorProfile_Usuarios_UserId
            references Usuarios
            on delete cascade,
    TutorCode nvarchar(max)    not null
)
go

create index IX_TutorProfile_UserId
    on TutorProfile (UserId)
go

CREATE TRIGGER TutorProfile_Delete
on practica1.TutorProfile
FOR Delete
as BEGIN
	  begin try
	  	  BEGIN TRANSACTION
		  INSERT INTO practica1.HistoryLog (Date, Description) VALUES (GETDATE(), N'PR1: Eliminacion de TutorProfile exitosa');
	      COMMIT TRANSACTION;
	   end try
	   begin catch
		  ROLLBACK TRANSACTION;
		  PRINT N'ERROR, OCURRIO UN ERROR INESPERADO';
	   end catch
END;
go

CREATE TRIGGER TutorProfile_Insertar
on practica1.TutorProfile
FOR insert
as BEGIN
	  begin try
	  	  BEGIN TRANSACTION
		  INSERT INTO practica1.HistoryLog (Date, Description) VALUES (GETDATE(), N'PR1: Transacción creacion de TutorProfile exitosa');
	      COMMIT TRANSACTION;
	   end try
	   begin catch
		  ROLLBACK TRANSACTION;
		  PRINT N'ERROR, OCURRIO UN ERROR INESPERADO';
	   end catch
END;
go

CREATE TRIGGER TutorProfile_Update
on practica1.TutorProfile
FOR Update
as BEGIN
	  begin try
	  	  BEGIN TRANSACTION
		  INSERT INTO practica1.HistoryLog (Date, Description) VALUES (GETDATE(), N'PR1: Actualizacion de TutorProfile exitosa');
	      COMMIT TRANSACTION;
	   end try
	   begin catch
		  ROLLBACK TRANSACTION;
		  PRINT N'ERROR, OCURRIO UN ERROR INESPERADO';
	   end catch
END;
go

create table UsuarioRole
(
    Id              int identity
        constraint PK_UsuarioRole
            primary key,
    RoleId          uniqueidentifier not null
        constraint FK_UsuarioRole_Roles_RoleId
            references Roles
            on delete cascade,
    UserId          uniqueidentifier not null
        constraint FK_UsuarioRole_Usuarios_UserId
            references Usuarios
            on delete cascade,
    IsLatestVersion bit              not null
)
go

create index IX_UsuarioRole_RoleId
    on UsuarioRole (RoleId)
go

create index IX_UsuarioRole_UserId
    on UsuarioRole (UserId)
go

CREATE TRIGGER UsuarioRole_Delete
on practica1.UsuarioRole
AFTER DELETE
as BEGIN
	  begin try
	  	  BEGIN TRANSACTION
		  INSERT INTO practica1.HistoryLog (Date, Description) VALUES (GETDATE(), N'PR1: Eliminacion de UsuarioRole exitosa');
	      COMMIT TRANSACTION;
	   end try
	   begin catch
		  ROLLBACK TRANSACTION;
		  PRINT N'ERROR, OCURRIO UN ERROR INESPERADO';
	   end catch
END;
go

CREATE TRIGGER UsuarioRole_Insertar
on practica1.UsuarioRole
FOR insert
as BEGIN
	  begin try
	  	  BEGIN TRANSACTION
		  INSERT INTO practica1.HistoryLog (Date, Description) VALUES (GETDATE(), N'PR1: Transacción creacion de UsuarioRole exitosa');
	      COMMIT TRANSACTION;
	   end try
	   begin catch
		  ROLLBACK TRANSACTION;
		  PRINT N'ERROR, OCURRIO UN ERROR INESPERADO';
	   end catch
END;
go

CREATE TRIGGER UsuarioRole_Update
on practica1.UsuarioRole
AFTER Update
as BEGIN
	  begin try
	  	  BEGIN TRANSACTION
		  INSERT INTO practica1.HistoryLog (Date, Description) VALUES (GETDATE(), N'PR1: Actualizacion de UsuarioRole exitosa');
	      COMMIT TRANSACTION;
	   end try
	   begin catch
		  ROLLBACK TRANSACTION;
		  PRINT N'ERROR, OCURRIO UN ERROR INESPERADO';
	   end catch
END;
go

CREATE TRIGGER Usuario_Delete
on practica1.Usuarios
AFTER DELETE
as BEGIN
	  begin try
	  	  BEGIN TRANSACTION
		  INSERT INTO practica1.HistoryLog (Date, Description) VALUES (GETDATE(), N'PR1: Eliminacion de usuario exitosa');
	      COMMIT TRANSACTION;
	   end try
	   begin catch
		  ROLLBACK TRANSACTION;
		  PRINT N'ERROR, OCURRIO UN ERROR INESPERADO';
	   end catch
END;
go

CREATE TRIGGER Usuario_Insertar
on practica1.Usuarios
FOR insert
as BEGIN
	  begin try
	  	  BEGIN TRANSACTION
		  INSERT INTO practica1.HistoryLog (Date, Description) VALUES (GETDATE(), N'PR1: Transacción creacion de usuario exitosa');
	      COMMIT TRANSACTION;
	   end try
	   begin catch
		  ROLLBACK TRANSACTION;
		  PRINT N'ERROR, OCURRIO UN ERROR INESPERADO';
	   end catch
END;
go

CREATE TRIGGER Usuario_Update
on practica1.Usuarios
AFTER Update
as BEGIN
	  begin try
	  	  BEGIN TRANSACTION
		  INSERT INTO practica1.HistoryLog (Date, Description) VALUES (GETDATE(), N'PR1: Actualizacion de usuario exitosa');
	      COMMIT TRANSACTION;
	   end try
	   begin catch
		  ROLLBACK TRANSACTION;
		  PRINT N'ERROR, OCURRIO UN ERROR INESPERADO';
	   end catch
END;
go

CREATE FUNCTION practica1.F1
(
 @CodCourse int
)
RETURNS TABLE
AS
RETURN
(

    SELECT
         c.Id                   ID_COURSE
        ,co.Name
        ,Co.CreditsRequired
        ,u.Firstname
        ,u.Lastname
        ,u.Email
        ,s.Credits              CREDITS
    FROM practica1.CourseAssignment c
    INNER JOIN practica1.Course co on co.CodCourse = c.CourseCodCourse
    INNER JOIN practica1.ProfileStudent s on s.UserId = c.StudentId
    INNER JOIN practica1.Usuarios U on s.UserId = U.Id
    WHERE c.CourseCodCourse = @CodCourse
)
go

CREATE FUNCTION practica1.F2
(
    @TutorCode uniqueidentifier
)
RETURNS TABLE
AS
RETURN
(
    select
         co.CodCourse
        ,co.Name
        ,u.Firstname
        ,u.Lastname
        ,u.Email
    from practica1.CourseTutor ct
    inner join practica1.Course co on co.CodCourse = ct.CourseCodCourse
    inner join practica1.TutorProfile t on t.UserId = ct.TutorId
    inner join practica1.Usuarios u on u.Id = t.UserId
    where u.Id = @TutorCode
)
go

CREATE FUNCTION practica1.F3
(
    @Id uniqueidentifier
)
RETURNS TABLE
AS
RETURN
(

    select

         n.Id       as  'ID_Notificacion'
        ,n.Message
        ,n.Date
        ,p.Id
        ,p.UserId
        ,p.Credits
        ,u.Lastname
        ,u.Firstname
    from
        practica1.Notification n
    inner join practica1.ProfileStudent p on n.UserId = p.UserId
    inner join practica1.Usuarios u on u.Id = p.UserId
    where u.id = @Id
)
go

CREATE FUNCTION practica1.F4()
RETURNS @resultado TABLE
(
     Id  INT
    ,Date  datetime2
    ,Description  nvarchar(max)
)
AS
BEGIN


    INSERT INTO @resultado
    select
         Id
        ,Date
        ,Description
    from practica1.HistoryLog

   /*** IF @@ROWCOUNT > 0
    BEGIN
       -- COMMIT;
    END
    ELSE
    BEGIN
       -- ROLLBACK ;
    END***/

    RETURN
END
go

CREATE FUNCTION practica1.F5
(
    @Id uniqueidentifier
)
RETURNS TABLE
AS
RETURN
(

    select
    u.Id        AS 'ID_USUARIO'
    ,u.Firstname
    ,u.Lastname
    ,u.Email
    ,u.EmailConfirmed
    ,u.DateOfBirth
    ,ps.Credits
    ,r.Id       as 'ID_ROL'
    ,r.RoleName

from practica1.Usuarios u
inner join practica1.UsuarioRole ur on ur.UserId = u.Id
inner join practica1.Roles r on r.Id = ur.RoleId
inner join practica1.ProfileStudent ps on ps.UserId = ur.UserId
WHERE u.id = @Id

)
go

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
go

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
go

CREATE PROCEDURE practica1.PR3(@Email As nvarchar(100),@CodCourse AS INT)
AS
    BEGIN
        BEGIN TRANSACTION

            -- VARIABLES
            DECLARE @Creditos INT;
            DECLARE @CreditosReq INT;
            DECLARE @UserStudent uniqueidentifier;
            DECLARE @UserTutor uniqueidentifier;
            DECLARE @CodCurso nvarchar(10);

            -- OBTENER CREDITOS DEL USUARIO
            SELECT @Creditos = p.Credits
            FROM practica1.ProfileStudent p
            INNER JOIN practica1.Usuarios u  on u.Id = p.UserId
            WHERE u.Email = @Email;

            -- OBTENER CREDITOS REQUERIDOS
            SELECT @CreditosReq = c.CreditsRequired
            FROM practica1.Course c
            WHERE c.CodCourse = @CodCourse;

            -- VALIDAR ASIGNACIÓN
            IF @Creditos >= @CreditosReq
                BEGIN
                    IF (SELECT EmailConfirmed FROM practica1.Usuarios WHERE Email = @Email) = 1
                        BEGIN
                        -- OBTENER ID STUDENT
                        SELECT @UserStudent = e.Id
                        FROM practica1.Usuarios e
                        WHERE e.Email = @Email;

                        -- OBTENER ID TUTOR
                        SELECT @UserTutor = t.Id
                        FROM practica1.Usuarios t
                        INNER JOIN practica1.CourseTutor ct ON t.Id = ct.TutorId
                        INNER JOIN practica1.Course c ON ct.CourseCodCourse = c.CodCourse
                        WHERE c.CodCourse = @CodCourse;

                        -- ASIGNAR
                        INSERT INTO practica1.CourseAssignment (StudentId, CourseCodCourse)
                        VALUES (@UserStudent,@CodCourse);
                        COMMIT TRANSACTION;
                        PRINT 'Se ha asignado el curso correctamente'

                        -- NOTIFICAR A ESTUDIANTE
                        SET @CodCurso = CAST(@CodCourse AS nvarchar(10));
                        INSERT INTO practica1.Notification (practica1.Notification.UserId, practica1.Notification.Message, practica1.Notification.Date)
                        VALUES(@UserStudent,'Se le ha asignado el curso',GETDATE());
                        PRINT 'Se le ha asignado el curso'

                        -- NOTIFICAR A TUTOR
                        INSERT INTO practica1.Notification (practica1.Notification.UserId, practica1.Notification.Message, practica1.Notification.Date)
                        VALUES(@UserTutor,'Se le ha asignado 1 estudiante mas en el curso',GETDATE());
                        PRINT 'Se le ha asignado 1 estudiante mas en el curso'
                    END
                    ELSE
                        BEGIN
                            ROLLBACK TRANSACTION;
                            INSERT INTO practica1.HistoryLog (practica1.HistoryLog.Date, practica1.HistoryLog.Description)
                            VALUES (GETDATE(), N'PR3: El usuario no ha sido confirmado');
                            PRINT N'El usuario no ha sido confirmado';
                        END

                END
            ELSE
                BEGIN
                    ROLLBACK TRANSACTION;
                    INSERT INTO practica1.HistoryLog (practica1.HistoryLog.Date, practica1.HistoryLog.Description)
                    VALUES (GETDATE(),'PR3: No tiene los créditos suficientes para asignar el curso');
                    PRINT 'No tiene los créditos suficientes para asignar el curso'
                END

    END
go

CREATE PROCEDURE practica1.PR4
    @RoleName nvarchar(max)
AS BEGIN
    BEGIN TRANSACTION
        BEGIN TRY

            INSERT INTO practica1.Roles(Id, RoleName) values (newid(), @RoleName);
            COMMIT TRANSACTION;
            PRINT N'Se ah Creo el Nuevo Rol';
        END TRY
        BEGIN CATCH
            ROLLBACK TRANSACTION;
            INSERT INTO practica1.HistoryLog (Date, Description) VALUES (GETDATE(), N'PR4: Transacción fallida');
            PRINT N'Transaccion fallida, ocurrió un error inesperado.';
        END CATCH
END;
go

CREATE PROCEDURE practica1.PR5(@Name AS nvarchar(100),@CreditsRequired AS INT)
AS
    BEGIN
        BEGIN TRANSACTION
            DECLARE @valor INT;
            DECLARE @ValidacionName varchar(1);
            DECLARE @ValidacionCredits varchar(1);

            SET @valor = (SELECT ISNULL(MAX(practica1.Course.CodCourse),0)+1 FROM practica1.Course);
            EXEC practica1.PR6 @Name, -1, @ValidacionName OUTPUT;
            EXEC practica1.PR6 @CreditsRequired, 1, @ValidacionCredits OUTPUT;
                -- se valida el nombre del curso
            IF @ValidacionName = 'V'
            BEGIN
                    -- se valida los créditos
                IF @ValidacionCredits = 'V'
                BEGIN
                    -- se inserta el curso
                    INSERT INTO practica1.Course (practica1.Course.CodCourse, practica1.Course.Name, practica1.Course.CreditsRequired)
                    VALUES(@valor,@Name,@CreditsRequired);
                    COMMIT TRANSACTION;
                    PRINT 'El curso se ha creado correctamente'
                END
                ELSE
                BEGIN
                    ROLLBACK TRANSACTION;
                    INSERT INTO practica1.HistoryLog (practica1.HistoryLog.Date, practica1.HistoryLog.Description)
                    VALUES (GETDATE(),'PR5: No se ha creado el curso, los créditos no son válidos, solo debe contener números');
                    PRINT 'Los créditos no son válidos, solo debe contener números'
                END
            END
            ELSE
            BEGIN
                ROLLBACK TRANSACTION;
                INSERT INTO practica1.HistoryLog (practica1.HistoryLog.Date, practica1.HistoryLog.Description)
                VALUES (GETDATE(),'PR5: No se ha creado el curso, el nombre no es válido, solo debe contener letras');
                PRINT 'El nombre no es válido, solo debe contener letras'
            END
    END
go

CREATE PROCEDURE practica1.PR6
    (
        @pValidacion nvarchar(max)
        ,@pCondicion int
        ,@vValidacion varchar(1) output
    )
AS
BEGIN

        set nocount on;
        -- ================ LETRA ================
        if @pCondicion = 0
            BEGIN


                Set @vValidacion =
                    CASE
                        WHEN @pValidacion NOT LIKE '%[0-9]%' THEN 'V'
                        ELSE 'F'
                    END
            END
        ELSE
            BEGIN
               INSERT INTO practica1.HistoryLog(Date, Description) values (getdate(), 'EXCEPTION: PR6 -> Letra Invalido');
            END
        -- ================ NÚMERO ================
        if @pCondicion <> 0
            BEGIN

                Set @vValidacion =
                    CASE
                        WHEN @pCondicion LIKE '%[0-9]%' THEN 'V'
                        ELSE 'F'
                    END
            END
        ELSE
            BEGIN
                INSERT INTO practica1.HistoryLog(Date, Description) values (getdate(), 'EXCEPTION: PR6 -> Número Invalido');
            END

        SELECT @vValidacion
end
go


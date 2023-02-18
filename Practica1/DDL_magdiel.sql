-- CREACIÓN DE CURSOS
-- PARAMETROS: NAME, CREDITSREQUIRED
--------------------------------------------------------------------------------
GO
DROP PROCEDURE IF EXISTS practica1.PR5;
GO
CREATE PROCEDURE practica1.PR5(@Name AS nvarchar(100),@CreditsRequired AS INT)
AS
    BEGIN
        DECLARE @valor INT;
        DECLARE @ValidacionName varchar(1);
        DECLARE @ValidacionCredits varchar(1);

        SET @valor = (SELECT ISNULL(MAX(practica1.Course.CodCourse),0)+1 FROM practica1.Course);
        EXEC practica1.PR6 @Name, 0, @ValidacionName OUTPUT;
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
                PRINT 'El curso se ha creado correctamente'
            END
            ELSE
            BEGIN
                PRINT 'Los créditos no son válidos, solo debe contener números'
            END
        END
        ELSE
        BEGIN
            PRINT 'El nombre no es válido, solo debe contener letras'
        END
    END

EXEC practica1.PR5 'Filosofia', 10;

    SELECT * FROM practica1.Course;
    DELETE FROM practica1.Course;
--------------------------------------------------------------------------------

-- ASIGNACIÓN DE CURSOS
-- PARAMETROS: EMAIL, CODCOURSE
--------------------------------------------------------------------------------
GO
DROP PROCEDURE IF EXISTS practica1.PR3;
GO
CREATE PROCEDURE practica1.PR3(@Email As nvarchar(100),@CodCourse AS INT)
AS
    BEGIN
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
            PRINT 'No tiene los créditos suficientes para asignar el curso'
            END

    END

EXEC practica1.PR3 'lopez@gmail.com',3;


--------------------------------------------------------------------------------

-- TRIGGERS
--------------------------------------------------------------------------------
-- TABLA COURSE
--------------------------------------------------------------------------------
GO
DROP TRIGGER IF EXISTS practica1.Insert_Course;
GO
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


GO
DROP TRIGGER IF EXISTS practica1.Update_Course;
GO
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


GO
DROP TRIGGER IF EXISTS practica1.Delete_Course;
GO
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

--------------------------------------------------------------------------------
-- TABLA COURSEASSIGNMENT
--------------------------------------------------------------------------------
GO
DROP TRIGGER IF EXISTS practica1.Insert_CourseAssignment;
GO
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

GO
DROP TRIGGER IF EXISTS practica1.Delete_CourseAssignment;
GO
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

GO
DROP TRIGGER IF EXISTS practica1.Update_CourseAssignment;
GO
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
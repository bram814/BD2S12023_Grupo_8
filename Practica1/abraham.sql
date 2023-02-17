GO
-- =========================================================================================================================
-- Author    Fecha        Descripción
-- =======   ==========   ==================================================================================================
-- bram814   09/02/2023   Validar Datos.
-- =========================================================================================================================
GO
DROP PROCEDURE IF EXISTS practica1.PR6;
GO
CREATE PROCEDURE practica1.PR6
AS
BEGIN
    SET NOCOUNT ON;

    -- ===================== Usuarios: Firstanme =====================
    BEGIN TRY
         BEGIN TRANSACTION
            ALTER TABLE practica1.Usuarios ADD CONSTRAINT CHK_COURSE_NAME CHECK (practica1.Usuarios.Firstname LIKE '%[a-zA-Z]%' AND practica1.Usuarios.Firstname NOT like '%[0-9]%');
         COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
         ROLLBACK TRANSACTION;
         INSERT INTO practica1.HistoryLog(Date, Description) values (getdate(), 'EXCEPTION: PR6 --> practica1.Usuarios.Firstname Invalido.');
    END CATCH

    -- ===================== Usuarios: Lastname =====================
    BEGIN TRY
         BEGIN TRANSACTION
            ALTER TABLE practica1.Usuarios ADD CONSTRAINT CHK_COURSE_NAME CHECK (practica1.Usuarios.Lastname LIKE '%[a-zA-Z]%' AND practica1.Usuarios.Lastname NOT like '%[0-9]%');
         COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
         ROLLBACK TRANSACTION;
         INSERT INTO practica1.HistoryLog(Date, Description) values (getdate(), 'EXCEPTION: PR6 --> practica1.Usuarios.Lastname Invalido.');
    END CATCH


    -- ===================== COURSE: Name =====================
    BEGIN TRY
         BEGIN TRANSACTION
            ALTER TABLE practica1.Course ADD CONSTRAINT CHK_COURSE_NAME CHECK (practica1.Course.Name LIKE '%[a-zA-Z]%' AND practica1.Course.Name NOT LIKE '%[0-9]%');
         COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
         ROLLBACK TRANSACTION;
         INSERT INTO practica1.HistoryLog(Date, Description) values (getdate(), 'EXCEPTION: PR6 --> practica1.Course.Name Invalido.');
    END CATCH
    -- ===================== COURSE: CreditsRequired =====================
     BEGIN TRY
         BEGIN TRANSACTION
            ALTER TABLE practica1.Course ADD CONSTRAINT CHK_PersonAge CHECK (practica1.Course.CreditsRequired NOT LIKE '%[a-zA-Z]%' AND practica1.Course.CreditsRequired LIKE '%[0-9]%');
         COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
         ROLLBACK TRANSACTION;
         INSERT INTO practica1.HistoryLog(Date, Description) values (getdate(), 'EXCEPTION: PR6 --> practica1.Course.CreditsRequired Invalido.');
    END CATCH
END
GO

-- =========================================================================================================================
-- Author    Fecha        Descripción
-- =======   ==========   ==================================================================================================
-- bram814   09/02/2023   Función que retornará el listado completo de alumnos que están asignados a un determinado curso.
-- =========================================================================================================================
GO
DROP FUNCTION IF EXISTS practica1.Func_course_usuarios;
GO
CREATE FUNCTION practica1.Func_course_usuarios
(
 @CodCourse int
)
RETURNS TABLE
AS
RETURN
(

    SELECT
         c.Id                   ID_COURSE
        ,c.CourseCodCourse      COURSE_COD_COURSE
        ,c.StudentId            STUDEND_ID
        ,s.Id                   ID_USER
        ,s.UserId               USER_ID
        ,s.Credits              CREDITS
    FROM practica1.CourseAssignment c
    LEFT JOIN practica1.ProfileStudent s on s.UserId = c.StudentId
    WHERE c.CourseCodCourse = @CodCourse
)
GO
--SELECT * FROM practica1.Func_course_usuarios(1);



GO
-- =========================================================================================================================
-- Author    Fecha        Descripción
-- =======   ==========   ==================================================================================================
-- bram814   09/02/2023   Función que retornará la lista de cursos a los cuales los tutores estén designados para dar clase.
-- =========================================================================================================================
GO
DROP FUNCTION IF EXISTS practica1.Func_tutor_course;
GO
CREATE FUNCTION practica1.Func_tutor_course
(

)
RETURNS TABLE
AS
RETURN
(
    SELECT
        s.Id
       ,s.UserId
       ,s.Credits
    FROM practica1.ProfileStudent s
)
GO
-- SELECT * FROM practica1.Func_tutor_course();




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

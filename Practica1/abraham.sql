-- =========================================================================================================================
-- Author    Fecha        Descripción
-- =======   ==========   ==================================================================================================
-- bram814   17/02/2023   Validar Datos.
-- =========================================================================================================================
GO
DROP PROCEDURE IF EXISTS practica1.PR6;
GO
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

-- =========================================================================================================================
-- Author    Fecha        Descripción
-- =======   ==========   ==================================================================================================
-- bram814   17/02/2023   Función que retornará la lista de cursos a los cuales los tutores estén designados para dar clase.
-- =========================================================================================================================
GO
DROP FUNCTION IF EXISTS practica1.Func_tutor_course;
GO
CREATE FUNCTION practica1.Func_tutor_course
(
    @TutorCode uniqueidentifier
)
RETURNS TABLE
AS
RETURN
(
    select
         c.CodCourse
        ,c.Name
        ,c.CreditsRequired
        ,t.Id
        ,u.Firstname
        ,u.Lastname
        ,t.UserId
        ,t.TutorCode
    from practica1.CourseAssignment ca
    inner join practica1.Course c on c.CodCourse = ca.CourseCodCourse
    inner join practica1.CourseTutor ct on ct.CourseCodCourse = c.CodCourse
    inner join practica1.Usuarios u on ca.StudentId = u.Id
    inner join practica1.TutorProfile t on t.UserId = u.Id
    where t.UserId = @TutorCode
)
GO

-- SELECT * FROM practica1.Func_tutor_course();


-- =========================================================================================================================
-- Author    Fecha        Descripción
-- =======   ==========   ==================================================================================================
-- bram814   17/02/2023   Función que retornará la lista de notificaciones que hayan sido enviadas a un usuario.
-- =========================================================================================================================

GO
DROP FUNCTION IF EXISTS practica1.Func_notification_usuarios;
GO
CREATE FUNCTION practica1.Func_notification_usuarios
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
--

-- =========================================================================================================================
-- Author    Fecha        Descripción
-- =======   ==========   ==================================================================================================
-- bram814   17/02/2023   Función que retornará la información almacenada en la tabla HistoryLog.
-- =========================================================================================================================
GO
DROP FUNCTION IF EXISTS practica1.Func_logger;
GO
CREATE FUNCTION practica1.Func_logger()
RETURNS TABLE
AS
RETURN
(

    select

         log.Id
        ,log.Date
        ,log.Description

    from practica1.HistoryLog log

)
-- select * from practica1.Func_logger()

-- =========================================================================================================================
-- Author    Fecha        Descripción
-- =======   ==========   ==================================================================================================
-- bram814   17/02/2023   Función que retornará el expediente de cada alumno, que incluye los siguientes campos.
-- =========================================================================================================================
GO
DROP FUNCTION IF EXISTS practica1.Func_usuarios;
GO
CREATE FUNCTION practica1.Func_usuarios
(
    @Id uniqueidentifier
)
RETURNS TABLE
AS
RETURN
(

    select
     u.Firstname
    ,u.Lastname
    ,u.Email
    ,u.DateOfBirth
    ,ps.Credits
    ,r.RoleName

from practica1.Usuarios u
inner join practica1.UsuarioRole ur on ur.UserId = u.Id
inner join practica1.Roles r on r.Id = ur.RoleId
inner join practica1.ProfileStudent ps on ps.UserId = ur.UserId
WHERE u.id = @Id

)

-- select * from practica1.Func_usuarios('7B13E1FB-5822-4C42-9194-91C0DD6BF19A')



    
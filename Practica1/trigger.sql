-- =========================================================================================================================
-- Author    Fecha        Descripción
-- =======   ==========   ==================================================================================================
--           18/02/2023   TRIGGER USUARIO.
-- =========================================================================================================================
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
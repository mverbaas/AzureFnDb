CREATE PROCEDURE [dbo].[InstanceAdd]
  @Name VARCHAR(128)
AS
BEGIN
  SET NOCOUNT ON;
  
  BEGIN TRY
    BEGIN TRAN
      INSERT [dbo].[Instance] ([Name], [CreateDate])
      VALUES (@Name, DEFAULT)
    COMMIT TRAN
  END TRY
  BEGIN CATCH
    DECLARE @ObjectName SYSNAME = OBJECT_NAME(@@PROCID)
      , @ErrorMessage NVARCHAR(MAX) = ERROR_MESSAGE()

    IF @@TRANCOUNT > 0
    BEGIN
      ROLLBACK TRAN
    END

    EXECUTE [log].[LogError] @Source = @ObjectName
      , @Error = @ErrorMessage;

    THROW
  END CATCH
END
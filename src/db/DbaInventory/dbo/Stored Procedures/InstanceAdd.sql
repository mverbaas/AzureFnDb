CREATE PROCEDURE [dbo].[InstanceAdd]
  @Name VARCHAR(128)
AS
BEGIN
  SET NOCOUNT ON;

  DECLARE @ObjectName SYSNAME = OBJECT_NAME(@@PROCID)
  
  BEGIN TRY
    BEGIN TRAN
      INSERT [dbo].[Instance] ([Name], [CreateDate])
      VALUES (@Name, DEFAULT)

      DECLARE @EventMessage NVARCHAR(128) = FORMATMESSAGE('Added ServerInstance %s to [dbo].[Instances]', @Name)
      
      EXECUTE [Utils].[LogEvent] @Source = @ObjectName
        , @EventMessage = @EventMessage

    COMMIT TRAN
  END TRY
  BEGIN CATCH
    DECLARE @ErrorMessage NVARCHAR(MAX) = ERROR_MESSAGE()

    IF @@TRANCOUNT > 0
    BEGIN
      ROLLBACK TRAN
    END

    EXECUTE [Utils].[LogError] @Source = @ObjectName
      , @Error = @ErrorMessage;

    THROW
  END CATCH
END
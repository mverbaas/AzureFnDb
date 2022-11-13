CREATE PROCEDURE [dbo].[DatabaseAdd]
  @ServerInstance VARCHAR(128)
  , @Name VARCHAR(128)
AS
BEGIN
  SET NOCOUNT ON;

  DECLARE @InstanceId INT
  
  BEGIN TRY
    -- Check if instance exists or create if not exists
    IF NOT EXISTS (
      SELECT [Name] FROM [dbo].[Instance] WHERE [Name] = @ServerInstance
    )
    BEGIN
      PRINT 'Add Instance'
      EXECUTE [dbo].[InstanceAdd] @Name = @ServerInstance
    END
    
    -- Get the Id of the ServerInstance
    SET @InstanceId = (SELECT [Id] FROM [dbo].[Instance] WHERE [Name] = @ServerInstance)

    --Insert the databases
    INSERT [dbo].[Database] ([InstanceId], [Name], [CreateDate])
    VALUES (@InstanceId, @Name, DEFAULT)
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
  RETURN 0
END
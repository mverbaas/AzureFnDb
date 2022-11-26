CREATE PROCEDURE [Utils].[LogEvent]
  @Source NVARCHAR(128),
  @EventMessage NVARCHAR(128)
AS
BEGIN
  BEGIN TRY
    BEGIN TRAN
      INSERT [Utils].[Event] ([EventDateTime], [Source], [EventMessage])
      VALUES (DEFAULT, @Source, @EventMessage)
    COMMIT TRAN
  END TRY
  BEGIN CATCH
    DECLARE @ObjectName SYSNAME = OBJECT_NAME(@@PROCID)
      , @ErrorMessage NVARCHAR(MAX) = ERROR_MESSAGE()

    IF @@TRANCOUNT > 0
    BEGIN
      ROLLBACK TRAN
    END

    EXECUTE [Utils].[LogError] @Source = @ObjectName
      , @Error = @ErrorMessage;

    THROW
  END CATCH
  RETURN 0
END
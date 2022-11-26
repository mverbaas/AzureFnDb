CREATE PROCEDURE [Utils].[LogError]
  @Source SYSNAME,
  @Error NVARCHAR(MAX)
AS
BEGIN
  INSERT [Utils].[Error] ([EventDateTime], [Source], [Error])
  VALUES (DEFAULT, @Source, @Error)
  RETURN 0
END
CREATE TABLE [Utils].[Event]
(
  [Id] INT NOT NULL IDENTITY(1,1)
  , [EventDateTime] DATETIME2 NOT NULL CONSTRAINT [DF_Event_EventDateTime] DEFAULT GETDATE()
  , [Source] NVARCHAR(128) NOT NULL
  , [EventMessage] NVARCHAR(128) NOT NULL
  , CONSTRAINT [PK_Event_Id] PRIMARY KEY CLUSTERED ([Id])
)

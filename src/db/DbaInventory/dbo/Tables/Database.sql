CREATE TABLE [dbo].[Database]
(
  [Id] INT NOT NULL IDENTITY(1,1)
  , [InstanceId] INT NOT NULL
  , [Name] NVARCHAR(128) NOT NULL
  , [CreateDate] DATETIME2 NOT NULL CONSTRAINT [DF_Database_CreateDate] DEFAULT GETDATE()
  , CONSTRAINT [PK_Database_Id] PRIMARY KEY CLUSTERED ([Id])
  , CONSTRAINT [FK_Instance_Id] FOREIGN KEY ([InstanceId]) REFERENCES [dbo].[Instance] (Id)
  , CONSTRAINT [UQ_Database_InstanceId-Name] UNIQUE ([InstanceId], [Name])
)

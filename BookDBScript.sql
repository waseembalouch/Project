USE [BookDB]
ALTER DATABASE [BookDB] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BookDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BookDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BookDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BookDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BookDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BookDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [BookDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BookDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BookDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BookDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BookDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BookDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BookDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BookDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BookDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BookDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [BookDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BookDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BookDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BookDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BookDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BookDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BookDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BookDB] SET RECOVERY FULL 
GO
ALTER DATABASE [BookDB] SET  MULTI_USER 
GO
ALTER DATABASE [BookDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BookDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BookDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BookDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [BookDB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'BookDB', N'ON'
GO
USE [BookDB]
GO
/****** Object:  Table [dbo].[BookDetails]    Script Date: 4/16/2019 2:07:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BookDetails](
	[BookID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](500) NOT NULL,
	[ISBN] [nvarchar](25) NOT NULL,
	[PublishYear] [char](4) NOT NULL,
	[CoverPrice] [decimal](12, 6) NOT NULL,
	[CheckOutStatusID] [int] NOT NULL,
	[Image] [image] NULL,
	[CurrentBorrowerID] [int] NULL,
 CONSTRAINT [PK_BookDetails] PRIMARY KEY CLUSTERED 
(
	[BookID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BorrowerDetails]    Script Date: 4/16/2019 2:07:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BorrowerDetails](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Mobile] [nvarchar](11) NOT NULL,
	[NationalID] [nvarchar](11) NOT NULL,
	[CheckOutDate] [datetime] NOT NULL,
	[ReturnDate] [datetime] NOT NULL,
	[BookID] [int] NOT NULL,
 CONSTRAINT [PK_BorrowerDetails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CheckOutStatusDescription]    Script Date: 4/16/2019 2:07:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CheckOutStatusDescription](
	[CheckOutStatusID] [int] NOT NULL,
	[CheckOutStatusDescription] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_CheckOutStatusDescription] PRIMARY KEY CLUSTERED 
(
	[CheckOutStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ErrorLog]    Script Date: 4/16/2019 2:07:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ErrorLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ExceptionMessage] [varchar](250) NULL,
	[PageURL] [varchar](150) NULL,
 CONSTRAINT [PK_ErrorLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GazetteHoliday]    Script Date: 4/16/2019 2:07:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GazetteHoliday](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[HolidayDate] [datetime] NULL,
	[Description] [varchar](50) NULL,
 CONSTRAINT [PK_GazetteHoliday] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[BookDetails] ON 

INSERT [dbo].[BookDetails] ([BookID], [Title], [ISBN], [PublishYear], [CoverPrice], [CheckOutStatusID], [Image], [CurrentBorrowerID]) VALUES (5, N'Title 1 ', N'Title 1 ISBN', N'2016', CAST(10.000000 AS Decimal(12, 6)), 2, NULL, 4)
INSERT [dbo].[BookDetails] ([BookID], [Title], [ISBN], [PublishYear], [CoverPrice], [CheckOutStatusID], [Image], [CurrentBorrowerID]) VALUES (6, N'Title 2 ', N'Title 2 ISBN', N'2018', CAST(13.000000 AS Decimal(12, 6)), 1, NULL, NULL)
SET IDENTITY_INSERT [dbo].[BookDetails] OFF
SET IDENTITY_INSERT [dbo].[BorrowerDetails] ON 

INSERT [dbo].[BorrowerDetails] ([ID], [Name], [Mobile], [NationalID], [CheckOutDate], [ReturnDate], [BookID]) VALUES (1, N'Borrow Detail 1', N'03362345859', N'1', CAST(N'2018-02-26 00:00:00.000' AS DateTime), CAST(N'2019-03-02 00:04:45.923' AS DateTime), 1)
INSERT [dbo].[BorrowerDetails] ([ID], [Name], [Mobile], [NationalID], [CheckOutDate], [ReturnDate], [BookID]) VALUES (2, N'Borrow Detail 2', N'03472381455', N'1', CAST(N'2018-02-28 00:00:00.000' AS DateTime), CAST(N'2019-03-02 02:57:07.240' AS DateTime), 2)
INSERT [dbo].[BorrowerDetails] ([ID], [Name], [Mobile], [NationalID], [CheckOutDate], [ReturnDate], [BookID]) VALUES (3, N'Muhammad Saleem', N'33-444-5555', N'42101111111', CAST(N'2019-03-02 02:15:59.000' AS DateTime), CAST(N'2019-03-02 02:56:30.360' AS DateTime), 5)
INSERT [dbo].[BorrowerDetails] ([ID], [Name], [Mobile], [NationalID], [CheckOutDate], [ReturnDate], [BookID]) VALUES (4, N'Muhammad Saleem', N'33-444-5555', N'42101111111', CAST(N'2019-03-02 02:56:49.000' AS DateTime), CAST(N'2019-03-23 02:56:49.000' AS DateTime), 5)
SET IDENTITY_INSERT [dbo].[BorrowerDetails] OFF
INSERT [dbo].[CheckOutStatusDescription] ([CheckOutStatusID], [CheckOutStatusDescription]) VALUES (1, N'No')
INSERT [dbo].[CheckOutStatusDescription] ([CheckOutStatusID], [CheckOutStatusDescription]) VALUES (2, N'Yes')
ALTER TABLE [dbo].[BookDetails]  WITH CHECK ADD  CONSTRAINT [FK_BookDetails_CheckOutStatusDescription] FOREIGN KEY([CheckOutStatusID])
REFERENCES [dbo].[CheckOutStatusDescription] ([CheckOutStatusID])
GO
ALTER TABLE [dbo].[BookDetails] CHECK CONSTRAINT [FK_BookDetails_CheckOutStatusDescription]
GO
/****** Object:  StoredProcedure [dbo].[usp_CheckInBook]    Script Date: 4/16/2019 2:07:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_CheckInBook]
@BookID int
as

Begin

Declare @ID int 

select @ID = CurrentBorrowerID from BookDetails where BookID = @BookID

Update BorrowerDetails set ReturnDate = getDate() where ID = @ID

Update BookDetails set CheckOutStatusID = '1', CurrentBorrowerID = NULL where BookID = @BookID

End


GO
/****** Object:  StoredProcedure [dbo].[usp_CheckOutBook]    Script Date: 4/16/2019 2:07:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_CheckOutBook]
@BookID int,
@Name nvarchar(250),
@MobileNo nvarchar(11),
@NationalID nvarchar(11),
@CheckOutDate datetime,
@ReturnDate datetime
as

Begin

Declare @ID int

Insert into BorrowerDetails (Name, Mobile, NationalID, CheckOutDate, ReturnDate, BookID) 
values (@Name, @MobileNo, @NationalID, @CheckOutDate, @ReturnDate, @BookID)

select @ID = Scope_identity()

Update BookDetails set CheckOutStatusID = '2', CurrentBorrowerID = @ID where BookID = @BookID



End


GO
/****** Object:  StoredProcedure [dbo].[usp_ErrorLog]    Script Date: 4/16/2019 2:07:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_ErrorLog] 
@ExceptionMessage varchar(500),
@PageURL varchar(150)
as

INSERT INTO ErrorLog(ExceptionMessage,PageURL) VALUES(@ExceptionMessage,@PageURL)


GO
/****** Object:  StoredProcedure [dbo].[usp_getBookBorrowingHistory]    Script Date: 4/16/2019 2:07:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_getBookBorrowingHistory]
@BookID int

as

select Name, CheckOutDate, ReturnDate from BorrowerDetails where BookID = @BookID

order by CheckOutDate desc


GO
/****** Object:  StoredProcedure [dbo].[usp_getBorrowerDetails]    Script Date: 4/16/2019 2:07:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_getBorrowerDetails]
@BookID int
as

select Name, Mobile, ReturnDate from BorrowerDetails inner join 
BookDetails on BookDetails.CurrentBorrowerID = BorrowerDetails.ID where
BookDetails.BookID = @BookID


GO
/****** Object:  StoredProcedure [dbo].[usp_RetrieveBookDetails]    Script Date: 4/16/2019 2:07:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[usp_RetrieveBookDetails] 
@BookID int
as

select 
B.BookID,
B.Title,
B.ISBN,
B.PublishYear,
B.CoverPrice,
B.Image,
D.CheckOutStatusDescription

from BookDetails B inner join CheckOutStatusDescription D 
on 
B.CheckOutStatusID = D.CheckOutStatusID

where B.BookID = @BookID


GO
/****** Object:  StoredProcedure [dbo].[usp_RetrieveBooksList]    Script Date: 4/16/2019 2:07:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[usp_RetrieveBooksList]
as

select 
B.BookID,
B.Title,
B.ISBN,
B.PublishYear,
B.CoverPrice,
B.CheckOutStatusID,
D.CheckOutStatusDescription

from BookDetails B inner join CheckOutStatusDescription D 
on 
B.CheckOutStatusID = D.CheckOutStatusID


GO
/****** Object:  StoredProcedure [dbo].[usp_RetriveGazetteHoliday]    Script Date: 4/16/2019 2:07:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_RetriveGazetteHoliday]
	
AS
BEGIN
	
	SET NOCOUNT ON;

   select * from GazetteHoliday
END


GO
USE [master]
GO
ALTER DATABASE [BookDB] SET  READ_WRITE 
GO

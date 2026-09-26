SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Bronze].[CRM_Cust_Info](
	[cst_id] [int] NULL,
	[cst_key] [nvarchar](50) NULL,
	[cst_firsname] [nvarchar](50) NULL,
	[cst_lastsname] [nvarchar](50) NULL,
	[cst_gndr] [nvarchar](50) NULL,
	[cst_create_date] [date] NULL
) ON [PRIMARY]
GO

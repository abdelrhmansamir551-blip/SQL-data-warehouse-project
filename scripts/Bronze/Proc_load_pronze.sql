USE [Datawarehouse]
GO
/****** Object:  StoredProcedure [Bronze].[load_bronze]    Script Date: 9/26/2026 2:38:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [Bronze].[load_bronze]
AS
BEGIN
DECLARE @START_TIME DATETIME,
            @END_TIME DATETIME,
            @BATCH_START_TIME DATETIME,
            @BATCH_END_TIME DATETIME;

    SET @BATCH_START_TIME = GETDATE();
;

    BEGIN TRY

        PRINT '==========================';
        PRINT 'Loading Bronze Layer';
        PRINT '==========================';

        PRINT '-------------------';
        PRINT 'Loading CRM Tables';

        -- CRM_Cust_Info
        SET @START_TIME = GETDATE();

        BULK INSERT Bronze.CRM_Cust_Info
        FROM 'C:\Users\Lenovo\Desktop\SQL\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @END_TIME = GETDATE();

        PRINT '>> LOAD DURATION: '
            + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS NVARCHAR)
            + ' SECONDS';

        PRINT '>------------';


        -- CRM_PRD_Info
        SET @START_TIME = GETDATE();

        BULK INSERT Bronze.CRM_PRD_Info
        FROM 'C:\Users\Lenovo\Desktop\SQL\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @END_TIME = GETDATE();

        PRINT '>> LOAD DURATION: '
            + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS NVARCHAR)
            + ' SECONDS';

        PRINT '>------------';


        -- CRM_SLS_details
        SET @START_TIME = GETDATE();

        BULK INSERT Bronze.CRM_SLS_details
        FROM 'C:\Users\Lenovo\Desktop\SQL\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @END_TIME = GETDATE();

        PRINT '>> LOAD DURATION: '
            + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS NVARCHAR)
            + ' SECONDS';


        PRINT '==========================';
        PRINT 'Loading ERP Tables';
        PRINT '==========================';
        PRINT '-------------------';


        -- erp_cust_az12
        SET @START_TIME = GETDATE();

        BULK INSERT Bronze.erp_cust_az12
        FROM 'C:\Users\Lenovo\Desktop\SQL\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @END_TIME = GETDATE();

        PRINT '>> LOAD DURATION: '
            + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS NVARCHAR)
            + ' SECONDS';

        PRINT '>------------';


        -- erp_loc_a101
        SET @START_TIME = GETDATE();

        BULK INSERT Bronze.erp_loc_a101
        FROM 'C:\Users\Lenovo\Desktop\SQL\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @END_TIME = GETDATE();

        PRINT '>> LOAD DURATION: '
            + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS NVARCHAR)
            + ' SECONDS';

        PRINT '>------------';


        -- erp_px_cat_g1v2
        SET @START_TIME = GETDATE();

        BULK INSERT Bronze.erp_px_cat_g1v2
        FROM 'C:\Users\Lenovo\Desktop\SQL\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @END_TIME = GETDATE();

        PRINT '>> LOAD DURATION: '
            + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS NVARCHAR)
            + ' SECONDS';


        PRINT '==========================';
        PRINT 'Bronze Layer Loaded Successfully';
        PRINT '==========================';

		SET @BATCH_END_TIME = GETDATE();

PRINT '>> BATCH LOAD DURATION: '
    + CAST(DATEDIFF(SECOND, @BATCH_START_TIME, @BATCH_END_TIME) AS NVARCHAR)
    + ' SECONDS';
    END TRY

    BEGIN CATCH

        PRINT '=====================';
        PRINT 'ERROR OCCURRED DURING LOADING BRONZE LAYER';

        PRINT 'ERROR MESSAGE: ' + ERROR_MESSAGE();

        PRINT 'ERROR NUMBER: '
            + CAST(ERROR_NUMBER() AS NVARCHAR);

        PRINT 'ERROR STATE: '
            + CAST(ERROR_STATE() AS NVARCHAR);

        PRINT '=====================';

    END CATCH

END;

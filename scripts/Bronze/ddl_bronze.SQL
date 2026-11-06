/*-------------------------------------------
DDL script create bronze table 
------------------------------------------
script purpose 
this script creates tables in bronze , shceme, dropping exsiting tables if they already exsists 
run this script to re difine the ddl structure of bronze tables
---------------------------------------------------------/*
		

			create or alter procedure bronze.load_bronze as 
			begin  
			declare @start_time datetime ,@end_time datetime, @batch_start_time datetime,@batch_end_time datetime;
			set @batch_start_time=getdate();
			begin try 

			print'===============================';
			print 'loading bronze layer';
			print'===============================';
			print'-----------------------------';
			set @start_time=getdate();
			print 'loading crm tables';
				print '>truncation the bronze.crm_cus_info'
			truncate table bronze.crm_cus_info;
			bulk insert bronze.crm_cus_info
			from 'D:\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
			with (
			firstrow =2,
			fieldterminator =',',
			tablock);
			set @end_time=getdate();
			print 'duration'+ cast (datediff (second, @start_time,@end_time)as nvarchar) +'seconds';
			--
				print'-----------------------------';
				set @start_time=getdate();
					print '>truncation bronze.crm_prd_info'
			truncate table bronze.crm_prd_info;
			bulk insert bronze.crm_prd_info
			from 'D:\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
			with (
			firstrow=2,
			fieldterminator =',',
			tablock);
			set @end_time=getdate();
			print 'duration'+ cast (datediff (second, @start_time,@end_time)as nvarchar) +'seconds';
			--
			print '>truncation bronze.crm_sales_details'
			set @start_time=getdate();
			truncate table bronze.crm_sales_details;
			bulk insert bronze.crm_sales_details
			from 'D:\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
			with (
			firstrow=2,
			fieldterminator =',',
			tablock);
			set @end_time=getdate();
			print 'duration'+ cast (datediff (second, @start_time,@end_time)as nvarchar) +'seconds';
			--
				print'===============================';
			print 'loading ERP  tables';
			print'===============================';
			print'-----------------------------';
			set @start_time=getdate();
				print '>truncation bronze.erp_cust_az12'
			truncate table bronze.erp_cust_az12;
			bulk insert bronze.erp_cust_az12
			from 'D:\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
			with (
			firstrow =2,
			fieldterminator =',',
			tablock);
			set @end_time=getdate();
			print 'duration'+ cast (datediff (second, @start_time,@end_time)as nvarchar) +'seconds';
			--
				print'-----------------------------';
				set @start_time=getdate();
						print '>truncation bronze.erp_loc_a101'
			truncate table bronze.erp_loc_a101;
			bulk insert bronze.erp_loc_a101
			from 'D:\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
			with (
			firstrow =2,
			fieldterminator =',',
			tablock);
			set @end_time=getdate();
			print 'duration'+ cast (datediff (second, @start_time,@end_time)as nvarchar) +'seconds';
			--
				print'-----------------------------';
				set @start_time=getdate();
				print '>truncation bronze.erp_px_cat_G1v2'
			truncate table bronze.erp_px_cat_G1v2;
					print '>insertion data into  bronze.erp_px_cat_G1v2'

			bulk insert bronze.erp_px_cat_G1v2
			from 'D:\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
			with (
			firstrow =2,
			fieldterminator =',',
			tablock);
			set @end_time=getdate();
			print 'duration'+ cast (datediff (second, @start_time,@end_time)as nvarchar) +'seconds';
			set @batch_end_time=GETDATE();
			print'======================='
			print'loading bronze layer completed'
			print 'total load duration'+cast(datediff(second ,@batch_start_time,@batch_end_time) as nvarchar) +'seconds';
			print '====================='
			end try 
			begin catch 
			print '========================'
			print 'error occured during loading bronze layer'
			print 'error message' + error_message ();
			print 'error message' + cast (error_number() as nvarchar);
			print 'error message' + cast (error_state() as nvarchar);
			print '========================'

			end catch 
		end 
		execute bronze.load_bronze

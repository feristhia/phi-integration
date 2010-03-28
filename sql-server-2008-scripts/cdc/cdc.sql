use PHI;

declare @operation as int
declare @role_cdc as varchar(100)

declare @nama_schema as varchar(100)
declare @nama_role as varchar(100)
declare @nama_database as varchar(100)

declare @nama_table_sumber as varchar(100)
declare @nama_table_cdc as varchar(100)

set @operation = 6
-- Keterangan
-- ==========
-- 1 = melihat informasi apakah database sudah dienable atau tidak
-- 2 = mengaktifkan CDC pada database aktif
-- 3 = menonaktifkan CDC pada database aktif
-- 4 = mengaktifkan CDC pada level table, sebelumnya CDC sudah harus diaktikfan pada level database
-- 5 = menonaktifkan CDC pada level table
-- 6 = query CDC

set @nama_database = N'PHI'
set @nama_schema = N'dbo'
set @nama_role = N'cdc_admin'

set @nama_table_sumber = N'tr_penjualan'
set @nama_table_cdc = N'tr_penjualan_change_table'

if @operation=1 
	begin
		-- Melihat info apakah database sudah diaktifkan untuk fitur CDC
		select name, is_cdc_enabled from sys.databases 
		where name = @nama_database
	end
else if @operation=2
	begin
		-- Mengaktifkan fitur CDC pada database aktif, harus dilakukan sebelum mengaktifkan CDC pada level table
		EXEC sys.sp_cdc_enable_db
	end 
else if @operation=3
	begin
		-- Menonaktifkan fitur CDC pada database aktif
		EXEC sys.sp_cdc_disable_db
	end 
else if @operation=4
	begin
		-- Mengaktifkan fitur CDC untuk table - dalam hal ini namanya tr_penjualan
		EXEC sys.sp_cdc_enable_table
			@source_schema = @nama_schema,
			@source_name   = @nama_table_sumber,
			@role_name     = @nama_role,
			@capture_instance = @nama_table_cdc,
			@supports_net_changes = 0
	end
else if @operation=5
	begin
		-- Menonaktifkan fitur CDC pada table
		EXEC sys.sp_cdc_disable_table
			@source_schema = @nama_schema,
			@source_name   = @nama_table_sumber,
			@capture_instance = @nama_table_cdc
	end
else if @operation=6
	begin
		declare @begin_time datetime, @end_time datetime
		declare @begin_lsn binary(10), @end_lsn binary(10)

		SET @begin_time = '2010-03-28 10:00:00.000';
		SET @end_time   = '2010-03-28 10:50:00.000';

		SET @begin_lsn = sys.fn_cdc_map_time_to_lsn('smallest greater than', @begin_time); 

		SET @end_lsn = sys.fn_cdc_map_time_to_lsn('largest less than or equal', @end_time); 

		-- Query menggunakan function cdc 
		select * from cdc.fn_cdc_get_all_changes_tr_penjualan_historis(@begin_lsn, @end_lsn, 'all');
	end
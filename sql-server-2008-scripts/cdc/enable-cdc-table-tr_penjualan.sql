USE PHI;

-- Mengaktifkan CDC pada level database
EXEC sys.sp_cdc_enable_db

-- Mengaktifkan CDC pada table yang akan dipantau
EXEC sys.sp_cdc_enable_table
	@source_schema = 'dbo',
	@source_name   = 'tr_penjualan',
	@role_name     = 'role_untuk_cdc',
	@capture_instance = 'tr_penjualan_historis',
	@supports_net_changes = 0

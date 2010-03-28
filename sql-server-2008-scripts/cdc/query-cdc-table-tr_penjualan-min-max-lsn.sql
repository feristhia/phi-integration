declare @begin_lsn binary(10), @end_lsn binary(10)

set @begin_lsn = sys.fn_cdc_get_min_lsn('tr_penjualan_historis');

set @end_lsn = sys.fn_cdc_get_max_lsn();

-- Query menggunakan function cdc 
select * from cdc.fn_cdc_get_all_changes_tr_penjualan_historis(@begin_lsn, @end_lsn, 'all');
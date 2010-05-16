declare @begin_time datetime, @end_time datetime
declare @begin_lsn binary(10), @end_lsn binary(10)

SET @begin_time = '2010-04-20 08:00:00.000';
SET @end_time   = '2010-04-20 10:40:00.000';

SET @begin_lsn = sys.fn_cdc_map_time_to_lsn('smallest greater than', @begin_time); 

SET @end_lsn = sys.fn_cdc_map_time_to_lsn('largest less than or equal', @end_time); 

-- Query menggunakan function cdc 
select * from cdc.fn_cdc_get_all_changes_tr_penjualan_historis(@begin_lsn, @end_lsn, 'all');
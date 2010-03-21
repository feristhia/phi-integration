select sobj.object_id
, sobj.name as table_name
, scol.name as column_name 
, stypes.name as data_type
, scol.max_length
from sys.all_objects sobj join sys.all_columns scol
on sobj.object_id = scol.object_id join sys.types stypes
on scol.system_type_id = stypes.system_type_id
where 
sobj.is_ms_shipped = 0 and sobj.type_desc = 'USER_TABLE'
order by sobj.name;
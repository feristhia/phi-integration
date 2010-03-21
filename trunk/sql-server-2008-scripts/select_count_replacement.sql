SELECT so.name as table_name, si.rowcnt as count_of_rows
FROM 
 sysindexes AS si
INNER JOIN 
 sysobjects AS so ON si.id = so.id
WHERE si.indid < 2 AND OBJECTPROPERTY(so.id, 'IsMSShipped') = 0 and so.NAME='your-table-name';
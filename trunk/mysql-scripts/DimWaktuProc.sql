-- File              : DimWaktuProc.sql
-- Description       : Script Stored Procedure untuk menghasilkan data kalender waktu 
--                     tabular yang bisa digunakan sebagai table dimensi waktu 
--                     pada data warehouse Anda.
-- Nama Procedure    : DimWaktuProc(tahun, jumlah_hari)
--                     Keterangan :
--                     tahun = adalah awal tahun kalender dimulai.
--                     jumlah_hari = jumlah hari yang diinginkan dimulai dari spesifikasi
--                                tahun dari argumen pertama.
-- Contoh Penggunaan : call DimWaktuProc(2008,1000);
-- Tanggal           : 16 Januari 2011
-- Author            : PHI-Integration
-- Email             : feris@phi-integration.com
-- Website           : http://www.kampusbi.com
-- Version           : 1.0
-- ===============================================================================

-- Blok Stored Procedure untuk menghasilkan table kalender atau dimensi waktu.
DELIMITER //

CREATE PROCEDURE DimWaktuProc(IN tahun INT, IN jumlah_hari INT)
BEGIN
  SET @loopvar := 1;
  SET @endloopvar := jumlah_hari;
  SET @tglawal = CONCAT(tahun,'-01-01');
  
  DROP TABLE IF EXISTS dim_waktu_temp;
  
  CREATE TABLE dim_waktu_temp(SK_Waktu INT, Tanggal DATETIME);
  
  read_loop: LOOP 
    IF @loopvar > @endloopvar THEN
	LEAVE read_loop;
    ELSE
	INSERT INTO dim_waktu_temp(SK_Waktu, Tanggal) VALUES (@loopvar, @tglawal + INTERVAL (@loopvar-1) DAY);
	SET  @loopvar := @loopvar + 1;
    END IF;
  END LOOP;
  
  SELECT * 
	, DAYOFYEAR(tanggal) AS `Hari_Dalam_Tahun` 
	, DAYOFMONTH(tanggal) AS `Hari_Dalam_Bulan` 
	, DAYOFWEEK(tanggal) AS `Hari_Dalam_Minggu` 
	, DATE_FORMAT(tanggal, "%W") AS `Nama_Hari_En` 
	, CASE DAYOFWEEK(tanggal) 
		WHEN 1 THEN 'Minggu' 
		WHEN 2 THEN 'Senin' 
		WHEN 3 THEN 'Selasa' 
		WHEN 4 THEN 'Rabu' 
		WHEN 5 THEN 'Kamis' 
		WHEN 6 THEN 'Jumat' 
		WHEN 7 THEN 'Sabtu' 
	  END AS `Nama_Hari_ID`
	, MONTH(tanggal) AS `Bulan` 
	, DATE_FORMAT(tanggal, "%M") AS `Nama_Bulan_En`
	, CASE MONTH(tanggal) 
		WHEN 1 THEN 'Januari' 
		WHEN 2 THEN 'Februari' 
		WHEN 3 THEN 'Maret' 
		WHEN 4 THEN 'April' 
		WHEN 5 THEN 'Mei' 
		WHEN 6 THEN 'Juni' 
		WHEN 7 THEN 'Juli' 	
		WHEN 8 THEN 'Agustus' 	
		WHEN 9 THEN 'September' 	
		WHEN 10 THEN 'Oktober' 	
		WHEN 11 THEN 'November' 	
		WHEN 12 THEN 'Desember' 	
	  END AS `Nama_Bulan_Id`
	, QUARTER(tanggal) AS `Kuartal`
	, DATE_FORMAT(tanggal, "%Y") AS `Tahun` 
	FROM dim_waktu_temp;
  DROP TABLE IF EXISTS dim_waktu_temp;
END //

DELIMITER ;
-- Akhir dari blok CREATE PROCEDURE



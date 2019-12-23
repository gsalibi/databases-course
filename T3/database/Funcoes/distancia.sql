DELIMITER //
CREATE FUNCTION  `dist_geo` 
(lat1  FLOAT ,  lon1  FLOAT,  lat2 FLOAT ,  lon2 FLOAT) 
RETURNS  FLOAT
BEGIN
 DECLARE pi, q1, q2, q3 FLOAT;
 DECLARE rads FLOAT DEFAULT 0;
 SET pi = PI();
 SET lat1 = lat1 * pi / 180;
 SET lon1 = lon1 * pi / 180;
 SET lat2 = lat2 * pi / 180;
 SET lon2 = lon2 * pi / 180;
 SET q1 = POW(SIN((lat1 - lat2) / 2),2);
 SET q2 = POW(SIN((lon1 - lon2) / 2),2);
 SET q3 = COS(lat1) * COS(lat2);
 SET rads = ASIN(SQRT(q1 + q3 * q2));
 RETURN 6378.388 * rads;
 END //
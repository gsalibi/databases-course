SELECT 
    id1, id2, CAST(distancia AS DECIMAL (2)) AS dist
FROM
    (SELECT 
        id1,
            id2,
            (2 * 6378.1 * ASIN(SQRT(POW(SIN((p2_lat - p1_lat) / 2), 2) + COS(p1_lat) * COS(p2_lat) * POW(SIN((p2_long - p1_long) / 2), 2)))) AS distancia
    FROM
        (SELECT 
        p1.id_pessoa AS id1,
            RADIANS(p1.latitude) AS p1_lat,
            RADIANS(p1.longitude) AS p1_long,
            p2.id_pessoa AS id2,
            RADIANS(p2.latitude) AS p2_lat,
            RADIANS(p2.longitude) AS p2_long
    FROM
        Pessoa p1, Pessoa p2
    WHERE
        p1.id_pessoa <> p2.id_pessoa
            AND p1.sexo <> p2.sexo) AS temp) AS temp2
WHERE
    distancia <= 30 AND id1 < id2
ORDER BY distancia;
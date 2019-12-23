USE GetLove;
SELECT arquivo, categoria, preco, ROUND(distancia, 2) as raio
FROM
	(SELECT arquivo, categoria, preco, (2 * 6378.1 * ASIN(SQRT(POW(SIN((serv_lat - p1_lat) / 2), 2) + COS(p1_lat) * COS(serv_lat) * POW(SIN((serv_long - p1_long) / 2), 2)))) AS distancia
	FROM
		(SELECT RADIANS(p1.latitude) AS p1_lat, RADIANS(p1.longitude) AS p1_long, RADIANS(serv.latitude) AS serv_lat, RADIANS(serv.longitude) AS serv_long, serv.ref_arquivo_descricao as arquivo, serv.categoria, preco
		FROM
		Pessoa p1, Servico serv
		WHERE p1.id_pessoa = 145
		) as temp_Table
	) as temp_Table2
WHERE categoria='restaurante' AND preco <= 100 AND ROUND(distancia,2) < 60
ORDER BY raio ASC

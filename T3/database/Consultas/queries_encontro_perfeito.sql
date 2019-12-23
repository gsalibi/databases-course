-- selecionando servicos baseado no cliente com id = 206
-- categoria: restaurantes
-- keywords: japones
-- preco < 1000
-- distancia < 10.000km

SELECT id_empresa, numero_servico, preco, categoria, descricao, 
dist_geo(lat1, long1, lat2, long2) as distancia
FROM
	(SELECT latitude as lat1, longitude as long1
	 FROM Pessoa
	 WHERE id_pessoa = 206) as pessoa,
	(SELECT id_empresa, numero_servico, preco, categoria, descricao, latitude as lat2, longitude as long2
	FROM Servico
	WHERE categoria LIKE 'restaurantes' and preco < 1000 and descricao LIKE '%japones%') as serv
HAVING distancia < 10000
ORDER BY distancia, preco;

-- cliente com id = 55 quer encontrar
-- categoria: hospedagem
-- descricao: hotel
-- preco: entre 400 e 900
-- distancia: < 2000 km
-- com ao menos 2 fotos

SELECT id_empresa, numero_servico, preco, categoria, descricao, 
dist_geo(pessoa.latitude, pessoa.longitude, serv.latitude, serv.longitude) as distancia,
numero_de_fotos
FROM
	(SELECT latitude, longitude
    FROM Pessoa
    WHERE id_pessoa = 55) as pessoa,
(SELECT id_empresa, numero_servico,  preco, categoria, descricao, latitude, longitude
    FROM Servico
    WHERE categoria LIKE 'hospedagem' and preco between 400 and 900 and descricao LIKE 'hotel') as serv
NATURAL JOIN
(SELECT id_empresa, numero_servico, count(numero_imagem) as numero_de_fotos
FROM Imagem_servico
GROUP BY id_empresa, numero_servico
HAVING numero_de_fotos >= 2) as conta_fotos  
HAVING distancia < 2000
ORDER BY distancia, preco;

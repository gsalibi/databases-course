-- listando as pessoas mais compativeis com o usuario id = 206, limitado em 50, ordenado por afinidade e por distancia
-- CRITÉRIOS UTILIZADOS PELO USUÁRIO:
-- distância <= 3km
-- sexo = 'F'
-- numero_filhos < 5
-- tabaco <= 1 (tanto faz)
-- alcool <= 1 (tanto faz)
-- outras drogas <= 1 (tanto faz)
-- religiao <= 10 (qualquer uma)

SELECT p2.id_pessoa, email, nome, data_nascimento, sexo, cidade, uf, numero_filhos, tabaco, alcool, outras_drogas, religiao, 
	abs(p1.tipo_de_personalidade - p2.tipo_de_personalidade) as afinidade, dist_geo(p1.latitude, p1.longitude, p2.latitude, p2.longitude) as distancia
FROM
	(SELECT tipo_de_personalidade, latitude, longitude
	 FROM Pessoa
	 WHERE id_pessoa = 206) as p1,
	(SELECT *
	 FROM Pessoa
	 WHERE id_pessoa <> 206 and sexo = 'F' and numero_filhos < 5 and tabaco < 2 and alcool < 2 and outras_drogas < 2 and religiao < 11 ) as p2
HAVING distancia < 1000
ORDER BY afinidade, distancia
LIMIT 200;
    
-- listando quem aprovou o usuário id = 149, ordenado pelas mais recentes
SELECT *
FROM Aprova
WHERE id_aprovado = 149
ORDER BY data_aprovacao DESC;

-- listando combinacoes do usuário id = 206, ordenado pelas mais recentes
SELECT *
FROM Combina_com
WHERE id_pessoa1 = 206 OR id_pessoa2 = 206
ORDER BY data_combinacao DESC;

-- recuperando conversa do usuário id = 206 com o usuário id = 27
SELECT ref_arquivo_conversa
FROM Combina_com
WHERE (id_pessoa1 = 27 AND id_pessoa2 = 206);

-- ranking de aprovacoes
SELECT Pessoa.nome, ranking.aprovacoes
FROM Pessoa,
(SELECT id_aprovado, count(*) as aprovacoes
FROM Aprova
GROUP BY id_aprovado
ORDER BY aprovacoes DESC) as ranking
WHERE Pessoa.id_pessoa = ranking.id_aprovado;

-- ------------------- QUERIES BONUS -------------------
-- ranking de combinacoes
SELECT nome, matches FROM
Pessoa NATURAL JOIN (
SELECT id_pessoa, matches1 + matches2 as matches
FROM 
	(SELECT id_pessoa1 as id_pessoa, count(*) as matches1
	FROM Combina_com
	GROUP BY id_pessoa1) as p1
    NATURAL JOIN
	(SELECT id_pessoa2 as id_pessoa, count(*) as matches2
	FROM Combina_com
	GROUP BY id_pessoa2) as p2) as temp
ORDER BY matches DESC;

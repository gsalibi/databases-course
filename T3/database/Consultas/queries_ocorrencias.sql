-- listar ocorrências não resolvidas
SELECT id_ocorrencia
FROM Ocorrencia
WHERE id_ocorrencia NOT IN (SELECT id_ocorrencia
							FROM Avalia NATURAL JOIN Ocorrencia);

-- ocorrências abertas pelo cliente id = 361
SELECT *
FROM Abre NATURAL JOIN Ocorrencia
WHERE Abre.id_pessoa = 361;

-- ocorrências sobre o cliente id = 345
SELECT *
FROM Ocorrencia
WHERE tipo LIKE "usuario" AND id_implicado = 345;

-- ocorrências sobre a empresa id = 36
SELECT *
FROM Ocorrencia
WHERE tipo LIKE "empresa" AND id_implicado = 36;

-- ocorrências sobre a GetLove
SELECT *
FROM Ocorrencia
WHERE id_implicado IS NULL;


-- ---------------------- QUERIES BONUS ----------------------
-- ranking de quem abriu mais ocorrências
SELECT id_pessoa, count(*) as reports
FROM Abre
GROUP BY id_pessoa
ORDER BY reports DESC;

-- ranking de usuários reportados
SELECT id_implicado, count(*) as reports
FROM Ocorrencia
WHERE tipo LIKE "usuario"
GROUP BY id_implicado
ORDER BY reports DESC;

-- ranking de empresas reportadas
SELECT id_implicado, count(*) as reports
FROM Ocorrencia
WHERE tipo LIKE "empresa"
GROUP BY id_implicado
ORDER BY reports DESC;

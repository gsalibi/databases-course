in_file = open("empresas.csv", "r", encoding="utf8")
out_file = open("insere_empresas.sql", "w", encoding="utf8")
out_file.write("use GetLove;\n")

tuplas = []
while True:
	linha = in_file.readline()
	if not linha:
		break
	tuplas.append(linha.split(","))

tuplas = list(filter(lambda v: len(v) == 7, tuplas))

del tuplas[0]

for tupla in tuplas:
	for i in range(len(tupla)):
		tupla[i] = tupla[i].replace("\n", "")
	nova_linha = "insert into Empresa values (" + ", ".join(["\'" + v + "\'" for v in tupla]) + ");\n"
	out_file.write(nova_linha)

in_file.close()
out_file.close()

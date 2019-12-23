in_file = open("pessoas.csv", "r", encoding="utf8")
out_file = open("insere_pessoas.sql", "w", encoding="utf8")

tuplas = []

while True:
	linha = in_file.readline()
	if not linha:
		break
	tuplas.append(linha)

for i in range(len(tuplas)):
	tuplas[i] = tuplas[i].split(",")
	for j in range(len(tuplas[i])):
		tuplas[i][j] = tuplas[i][j].replace("\n", "")

tuplas = list(filter(lambda v : len(v) == 16, tuplas))
del tuplas[0]

for tupla in tuplas:
	data = tupla[4].split("/")
	#print(tupla)
	data = [int(v) for v in data]
	data = "%4d-%02d-%02d" % (data[2], data[1], data[0])
	tupla[4] = data

out_file.write("use GetLove\n")

for tupla in tuplas:
	nova_linha = "insert into Pessoa values ("
	nova_linha += ",".join(["\'" + v + "\'" for v in tupla])
	nova_linha += ");\n"
	out_file.write(nova_linha)

in_file.close()
out_file.close()
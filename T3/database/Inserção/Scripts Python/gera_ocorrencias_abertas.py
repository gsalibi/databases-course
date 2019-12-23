from random import randint, choice

out_file = open("insere_ocorrencias.sql", "w", encoding="utf8")
out_file.write("use GetLove;\n")

ID_USUARIO_MAX = 499
ID_EMPRESA_MAX = 49
ID_MODERADOR_MAX = 9
N = 50
tipos = ["getlove", "empresa", "usuario"]

for i in range(N):
	tipo = choice(tipos)
	id_pessoa = randint(0,ID_USUARIO_MAX)
	id_moderador = randint(0, ID_MODERADOR_MAX)
	if tipo == "getlove":
		id_implicado = "NULL"
	elif tipo == "empresa":
		id_implicado = randint(0, ID_EMPRESA_MAX)
	else:
		while True:
			id_implicado = randint(0, ID_USUARIO_MAX)
			if id_implicado != id_pessoa:
				break
	ref_arquivo_mensagem = "msg" + str(i + 200 + 3871) + ".txt"
	data_ocorrencia = "%d-%02d-%02d" % (randint(2018,2028), randint(1,12), randint(1,28))

	tupla_ocorrencia = [str(i+200), tipo, str(id_implicado), ref_arquivo_mensagem, data_ocorrencia]
	tupla_ocorrencia = "(" + ",".join(["\'%s\'" % v for v in tupla_ocorrencia]) + ")"
	tupla_ocorrencia = tupla_ocorrencia.replace("\'NULL\'", "NULL")
	out_file.write("insert into Ocorrencia values " + tupla_ocorrencia + ";\n")
	#tupla_avalia = [str(i), str(id_moderador)]
	#tupla_avalia = "(" + ",".join(["\'%s\'" % v for v in tupla_avalia]) + ")"
	#out_file.write("insert into Avalia values " + tupla_avalia + ";\n")
	tupla_abre = [str(i), str(id_pessoa)]
	tupla_abre = "(" + ",".join(["\'%s\'" % v for v in tupla_abre]) + ")"
	out_file.write("insert into Abre values " + tupla_abre + ";\n")

out_file.close()

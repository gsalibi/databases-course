from random import random

out_file = open("categoriza_empresas.sql", "w", encoding="utf8")
out_file.write("use GetLove;\n")

for i in range(50):
	categoria = "Empresa_de_dados" if random() < 0.1 else "Empresa_de_servicos"
	out_file.write("insert into %s values (\'%d\');\n" % (categoria, i))

out_file.close()
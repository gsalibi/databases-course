import random

f = open("insere_imagem_servico.sql","r")

f.readline()
f.readline()

linhas = f.readlines()
f.close()

categorias=['restaurante', 'cinema', 'balada', 'motel']
MAX = len(categorias) - 1

saida = open("insere_servicos.sql","w")

saida.write("USE GetLove;\n")

for i in linhas:
    id_empresa = int(i.split(',')[0].split("'")[1])
    num_servico = int(i.split(',')[1].split("'")[1])
    categoria = categorias[random.randint(0, MAX)]

    arquivo = 'folder_serv_{}_{}.pdf'.format(id_empresa, num_servico)
    latitude = random.uniform(-90,90)
    longitude = random.uniform(-180,180)

    preco = random.uniform(0,2500)

    sql = "INSERT INTO Servico VALUES({},{},{},'{}','{}',{},{});\n".format(id_empresa, num_servico, preco, categoria, arquivo, latitude, longitude)

    saida.write(sql)

saida.close()

import random

saida = open("insere_servicos.sql","w")

categorias=['restaurante', 'cinema', 'balada', 'motel']
MAX = len(categorias) - 1

empresas = []
for i in range(0, 50):
    empresas.append(0)

saida.write("USE GetLove;\n")

for i in range(0, 1000):
    
    id_empresa = random.randint(0,49)
    while id_empresa == 4 or id_empresa == 21 or id_empresa ==38:
        id_empresa = random.randint(0,49)
    
    num_servico = empresas[id_empresa]
    empresas[id_empresa] += 1
    
    categoria = categorias[random.randint(0, MAX)]

    arquivo = 'folder_serv_{}_{}.pdf'.format(id_empresa, num_servico)
    latitude = random.uniform(-90,90)
    longitude = random.uniform(-180,180)

    preco = random.uniform(0,2500)

    sql = "INSERT INTO Servico VALUES({},{},{},'{}','{}',{},{});\n".format(id_empresa, num_servico, preco, categoria, arquivo, latitude, longitude)

    saida.write(sql)

saida.close()

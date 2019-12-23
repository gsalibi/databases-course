import random

LAT_MAX = 40.0; LAT_MIN = 10.0; LON_MAX = 60.0; LON_MIN = 30.0

saida = open("insere_servicos.sql","w")

descricoes = {'restaurantes':['frances', 'italiano', 'delicatessen', 'pizzaria', 'japones'],
    'entretenimento':['cinema', 'teatro', 'show', 'boliche', 'bar', 'balada'],
    'hospedagem':['hotel', 'motel', 'albergue', 'pousada']}


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

    categoria = random.choice(list(descricoes.keys()))
    descricao = random.choice(descricoes[categoria])

    #arquivo = 'folder_serv_{}_{}.pdf'.format(id_empresa, num_servico)
    latitude = random.uniform(LAT_MIN, LAT_MAX)
    longitude = random.uniform(LON_MIN, LON_MAX)

    preco = round(random.uniform(0,2500),2)

    sql = "INSERT INTO Servico VALUES({},{},{},'{}','{}',{},{});\n".format(id_empresa, num_servico, preco, categoria, descricao, latitude, longitude)

    saida.write(sql)

saida.close()

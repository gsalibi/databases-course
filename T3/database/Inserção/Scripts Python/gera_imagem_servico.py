import random

saida = open("imagens2.sql","w")
saida.write("USE GetLove;\n")
saida.write("INSERT INTO Imagem_servico VALUES\n")


f = open("insere_servicos.sql","r")

f.readline()

linhas = f.readlines()
f.close()

sql = []

for i in linhas:
    #print ("{}, {}".format(i.split(',')[0].split("(")[1], i.split(',')[1]))
    id_empresa = int(i.split(',')[0].split("(")[1])
    num_servico = int(i.split(',')[1])
    for j in range(0, 3):
        imagem = 'img_serv_{}_{}_{}.jpg'.format(id_empresa, num_servico, j)
        sql.append("({},{},{},\'{}\')".format(id_empresa, num_servico, j, imagem))

sql = ",\n".join(sql) + ";\n"
saida.write(sql)
saida.close()

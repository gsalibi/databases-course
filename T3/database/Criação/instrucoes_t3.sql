create database GetLove;
use GetLove;

CREATE TABLE Pessoa (
    id_pessoa INT PRIMARY KEY,
    cpf CHAR(11) NOT NULL UNIQUE,
    email VARCHAR(50) NOT NULL UNIQUE,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    sexo CHAR NOT NULL,
    cidade VARCHAR(30) NOT NULL,
    uf CHAR(2) NOT NULL,
    numero_filhos INT,
    tabaco INT,
    alcool INT,
    outras_drogas INT,
    religiao INT,
    tipo_de_personalidade INT,
    latitude FLOAT(10 , 6 ),
    longitude FLOAT(10 , 6 ),
    CHECK (latitude <= 90 AND latitude >= - 90),
    CHECK (longitude <= 180 AND longitude >= - 180)
);

CREATE TABLE Moderador (
    id_moderador INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE Ocorrencia (
    id_ocorrencia INT PRIMARY KEY,
    tipo CHAR(7) NOT NULL,
    id_implicado INT,
    ref_arquivo_mensagem VARCHAR(50) NOT NULL,
    data_ocorrencia DATE NOT NULL,
    CHECK (tipo LIKE 'getlove'
        OR tipo LIKE 'usuario'
        OR tipo LIKE 'empresa')
);

CREATE TABLE Empresa (
    id_empresa INT PRIMARY KEY,
    cnpj CHAR(14) NOT NULL UNIQUE,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    telefone VARCHAR(11) NOT NULL UNIQUE,
    cidade VARCHAR(30) NOT NULL,
    uf CHAR(2) NOT NULL
);

CREATE TABLE Empresa_de_dados (
    id_empresa INT NOT NULL,
    FOREIGN KEY (id_empresa)
        REFERENCES Empresa (id_empresa)
);

CREATE TABLE Empresa_de_servicos (
    id_empresa INT NOT NULL,
    FOREIGN KEY (id_empresa)
        REFERENCES Empresa (id_empresa)
);

CREATE TABLE Combina_com (
    id_pessoa1 INT,
    id_pessoa2 INT,
    ref_arquivo_conversa VARCHAR(50) NOT NULL,
    data_combinacao DATE NOT NULL,
    PRIMARY KEY (id_pessoa1 , id_pessoa2)
);

CREATE TABLE Aprova (
    id_pessoa INT,
    id_aprovado INT,
    data_aprovacao DATE NOT NULL,
    PRIMARY KEY (id_pessoa , id_aprovado)
);

CREATE TABLE Tem_dados_vendidos_a (
    id_pessoa INT,
    id_empresa INT,
    PRIMARY KEY (id_pessoa , id_empresa),
    FOREIGN KEY (id_pessoa)
        REFERENCES Pessoa (id_pessoa),
    FOREIGN KEY (id_empresa)
        REFERENCES Empresa_de_dados (id_empresa)
);

CREATE TABLE Abre (
    id_ocorrencia INT,
    id_pessoa INT,
    FOREIGN KEY (id_ocorrencia)
        REFERENCES Ocorrencia (id_ocorrencia)
);

CREATE TABLE Avalia (
    id_ocorrencia INT,
    id_moderador INT,
    FOREIGN KEY (id_ocorrencia)
        REFERENCES Ocorrencia (id_ocorrencia)
);

CREATE TABLE Plano_premium (
    id_pessoa INT NOT NULL,
    data_expiracao DATE NOT NULL,
    FOREIGN KEY (id_pessoa)
        REFERENCES Pessoa (id_pessoa)
);

CREATE TABLE Servico (
    id_empresa INT NOT NULL,
    numero_servico INT NOT NULL,
    preco FLOAT(10 , 2 ),
    categoria VARCHAR(15),
    descricao VARCHAR(50),
    latitude FLOAT(10 , 6 ),
    longitude FLOAT(10 , 6 ),
    FOREIGN KEY (id_empresa)
        REFERENCES Empresa_de_servicos (id_empresa),
    PRIMARY KEY (id_empresa , numero_servico)
);

CREATE TABLE Foto (
    id_pessoa INT NOT NULL,
    numero_foto INT NOT NULL,
    ref_arquivo_imagem VARCHAR(50) NOT NULL UNIQUE,
    FOREIGN KEY (id_pessoa)
        REFERENCES Pessoa (id_pessoa),
    PRIMARY KEY (id_pessoa , numero_foto)
);

CREATE TABLE Imagem_servico (
    id_empresa INT NOT NULL,
    numero_servico INT NOT NULL,
    numero_imagem INT NOT NULL,
    ref_arquivo_imagem VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_empresa , numero_servico)
        REFERENCES Servico (id_empresa , numero_servico),
    PRIMARY KEY (id_empresa , numero_servico , numero_imagem)
);

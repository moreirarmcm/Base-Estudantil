--create database backupTemple
--use backupTemple
--drop database UJLBase

create database UJLBase
GO
use UJLBase

--============ Criação das tabelas =============================

CREATE TABLE Membro (
	Codigo INT PRIMARY KEY IDENTITY,
	Nome VARCHAR(50) NOT NULL,
	NomeSocial VARCHAR(50),
	Data_Nascimento DATE,
	Genero VARCHAR (30) CHECK (Genero IN('Homem Cisgênero','Homem Transgênero','Mulher Cisgênero','Mulher Transgênero','Não Binário', 'Prefiro não responder')) NOT NULL,
	Orientacao_Sexual VARCHAR(30) CHECK(Orientacao_Sexual IN('Heterossexual','Homossexual','Bissexual','Assexual','Pansexual','Prefiro não responder')) NOT NULL,
	Data_Ingresso DATE,
	CodigoInstituicao INT,
	PosicaoPolitica VARCHAR (50) NOT NULL
)
GO

CREATE TABLE Contato(
	Codigo INT PRIMARY KEY IDENTITY,
	CodigoMembro INT NOT NULL UNIQUE,
	Email VARCHAR(50) NOT NULL,
	Telefone VARCHAR (15),
	Facebook VARCHAR(50),
	Twitter VARCHAR(50),
	Instagram VARCHAR(50),
	LinkedIn VARCHAR(50) 
)
GO

CREATE TABLE Endereco (
	Codigo INT PRIMARY KEY IDENTITY,
	CodigoMembro INT NOT NULL UNIQUE,
	Bairro VARCHAR(30) NOT NULL,
	Cidade VARCHAR(30) NOT NULL,
	UF CHAR(2) NOT NULL,
	RegiaoCidade VARCHAR(6) NOT NULL CHECK (RegiaoCidade IN('Norte','Sul','Leste','Oeste','Centro'))
)
GO

CREATE TABLE Instituicao(
	Codigo INT PRIMARY KEY IDENTITY,
	Nome VARCHAR(60) NOT NULL,
	GrauAcademico VARCHAR(30) NOT NULL CHECK (GrauAcademico IN('Médio','Superior')),
	Polo VARCHAR(50),
	Curso VARCHAR(50),
)
GO

CREATE TABLE Resposta(
	Codigo INT PRIMARY KEY IDENTITY,
	CodigoMembro INT NOT NULL,
	R1 VARCHAR(1000),
	R2 VARCHAR(1000),
	R3 VARCHAR(1000),
	R4 VARCHAR(1000),
	R5 VARCHAR(1000),
	R6 VARCHAR(1000),
)
GO

CREATE TABLE Diretoria(
	Codigo INT PRIMARY KEY IDENTITY,
	Nome VARCHAR(30),
	CodigoCoordenador INT,
	Coordenador VARCHAR(50),
	Criacao DATE
)
GO

CREATE TABLE MembroDiretoria(
	CodigoDiretoria INT,
	CodigoMembro INT,
	Data_Inicio DATE,
	Data_Final DATE
)
GO

CREATE TABLE Ilha(
	Codigo INT PRIMARY KEY IDENTITY,
	CodigoInstituicao INT,
	CodigoMentor INT,
	CodigoMonitor INT,
	CodigoMembro INT,
	Criacao DATE,
	Ativo INT
)

CREATE TABLE Naufrago(
	CodigoMembro INT,
	Nome VARCHAR(50),
	CodigoContato INT,
	CodigoInstituicao INT,
	CodigoMonitor INT,
	CodigoIlha INT
)

--============= Chaves estrangeiras ==================================

ALTER TABLE Membro
ADD CONSTRAINT FK_INSTITUICAO_MEMBRO
FOREIGN KEY (CodigoInstituicao) REFERENCES Instituicao (Codigo)
GO

ALTER TABLE Contato
ADD CONSTRAINT FK_MEMBRO_CONTATO
FOREIGN KEY (CodigoMembro) REFERENCES Membro (Codigo)
GO

ALTER TABLE Endereco
ADD CONSTRAINT FK_MEMBRO_ENDERECO
FOREIGN KEY (CodigoMembro) REFERENCES MEMBRO (Codigo)

ALTER TABLE Resposta
ADD CONSTRAINT FK_MEMBRO_RESPOSTA
FOREIGN KEY (CodigoMembro) REFERENCES MEMBRO (Codigo)
GO

ALTER TABLE Diretoria
	ADD CONSTRAINT FK_MEMBRO_DIRETORIA
FOREIGN KEY (CodigoCoordenador) REFERENCES MEMBRO (Codigo)
GO

ALTER TABLE MembroDiretoria
	ADD CONSTRAINT FK_Diretoria_MembroDiretoria
FOREIGN KEY (CodigoDiretoria) REFERENCES Diretoria (Codigo)
GO

ALTER TABLE MembroDiretoria
ADD CONSTRAINT FK_Membro_MembroDiretoria
FOREIGN KEY (CodigoMembro) REFERENCES MEMBRO (Codigo)
GO

ALTER TABLE Naufrago
ADD CONSTRAINT FK_Membro_Naufrago
FOREIGN KEY (CodigoMembro) REFERENCES Membro (Codigo)

ALTER TABLE Naufrago
ADD CONSTRAINT FK_Contato_Naufrago
FOREIGN KEY (CodigoContato) REFERENCES Contato (Codigo)

ALTER TABLE Naufrago
ADD CONSTRAINT FK_Instituicao_Naufrago
FOREIGN KEY (CodigoInstituicao) REFERENCES Instituicao (Codigo)

ALTER TABLE Naufrago
ADD CONSTRAINT FK_MembroMonitor_Naufrago
FOREIGN KEY (CodigoMonitor) REFERENCES Membro (Codigo)

ALTER TABLE Ilha
ADD CONSTRAINT FK_Instituicao_Ilha
FOREIGN KEY (CodigoInstituicao) REFERENCES Instituicao (Codigo)

ALTER TABLE Ilha
ADD CONSTRAINT FK_MembroMentor_Ilha
FOREIGN KEY (CodigoMentor) REFERENCES Membro (Codigo)

ALTER TABLE Ilha
ADD CONSTRAINT FK_MembroMonitor_Ilha
FOREIGN KEY (CodigoMonitor) REFERENCES Membro (Codigo)

ALTER TABLE Ilha
ADD CONSTRAINT FK_MembroMembro_Ilha
FOREIGN KEY (CodigoMembro) REFERENCES Membro (Codigo)

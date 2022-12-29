
/* ******| Banco de dados UJL |******
*
*Base criada com o objetivo de armazenar e estruturar as informações referente aos membros da União no São Paulo.
*
*
* Idealizado por Renan Moreira; Projetado por Renan Moreira e Lazzarini; Revisado e aprovado por Caio, Carol e Lazzarini;
* 
*/

create database UJLBase
GO
use UJLBase

/*
DROP database UJLBase2
create database UJLBase2
GO
use UJLBase2
*/
--================================================================================================================
--=======================================| Criação das tabelas |==================================================
--================================================================================================================

CREATE TABLE Membro (
	Codigo INT PRIMARY KEY IDENTITY,
	Nome VARCHAR(50) NOT NULL,
	NomeSocial VARCHAR(50),
	Data_Nascimento DATE,
	Genero VARCHAR (50) CHECK (Genero IN('Homem Cisgênero','Homem Transgênero','Mulher Cisgênero','Mulher Transgênero','Não Binário', 'Prefiro não responder')) NOT NULL,
	Etnia VARCHAR(30) CHECK(Etnia IN('Amarelo (a)','Branco (a)','Pardo (a)','Negro (a)','Indígena','Prefiro não responder')) NOT NULL,
	Data_Ingresso DATE,
	CodigoInstituicao INT,
	PosicaoPolitica VARCHAR (255) NOT NULL,
	CodigoBancada INT
)
GO

CREATE TABLE Contato(
	Codigo INT PRIMARY KEY IDENTITY,
	CodigoMembro INT NOT NULL UNIQUE,
	Email VARCHAR(1000) NOT NULL,
	Telefone VARCHAR (20),
	Facebook VARCHAR(1000),
	Twitter VARCHAR(1000),
	Instagram VARCHAR(1000),
	LinkedIn VARCHAR(1000)
)
GO

CREATE TABLE Endereco (
	Codigo INT PRIMARY KEY IDENTITY,
	CodigoMembro INT NOT NULL UNIQUE,
	Bairro VARCHAR(30) NOT NULL,
	Cidade VARCHAR(30) NOT NULL,
	UF CHAR(2) NOT NULL,
	RegiaoCidade VARCHAR(6) NOT NULL CHECK (RegiaoCidade IN('Norte','Sul','Leste','Oeste','Centro','Nenhuma das opções anteriores'))
)
GO

CREATE TABLE Instituicao(
	Codigo INT PRIMARY KEY IDENTITY,
	Nome VARCHAR(100) NOT NULL,
	GrauAcademico VARCHAR(50) NOT NULL CHECK (GrauAcademico IN('Ensino Fundamental','Ensino Médio','Ensino Superior','Nenhuma das alternativas anteriores','Sou educador')),
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
	R7 VARCHAR(1000),
	R8 VARCHAR(1000),
	R9 VARCHAR(1000)
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

CREATE TABLE MembroTemporaria(
	Nome VARCHAR(50),
	Idade INT,
	Faculdade VARCHAR(50),
	Celular VARCHAR(50)	
)
go

CREATE TABLE Bancada(
	Codigo INT PRIMARY KEY IDENTITY,
	Nome VARCHAR (1000),
	Descricao VARCHAR (255),
	CodigoLider INT
)
GO

CREATE TABLE TemporariaDois(
	EMAIL VARCHAR(1000),
	ComoSeDefine VARCHAR(1000),
	PorqueEntrarUJL VARCHAR(1000),
	qUAISoBJETIVOS VARCHAR(1000),
	DefineBolsonaro VARCHAR(1000),
	Personalidades VARCHAR(1000),
	RejeitaMovimentoLiberal VARCHAR(1000),
	ConsideraLula VARCHAR(1000),
	AvaliaExGovernos VARCHAR(1000),
	FazParteMovimentos VARCHAR(1000),
	TrabalhaGabinete VARCHAR(1000)
)
GO 

--================================================================================================================
--====================================| Criando Chaves Estrangeiras |=============================================
--================================================================================================================
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

--ALTER TABLE ENDERECO
--DROP CONSTRAINT FK_MEMBRO_ENDERECO

ALTER TABLE Resposta
ADD CONSTRAINT FK_MEMBRO_RESPOSTA
FOREIGN KEY (CodigoMembro) REFERENCES MEMBRO (Codigo)
GO

--ALTER TABLE Resposta
--DROP CONSTRAINT FK_MEMBRO_RESPOSTA

--ALTER TABLE Ilha
--DROP CONSTRAINT FK_MEMBRO_RESPOSTA


ALTER TABLE Diretoria
	ADD CONSTRAINT FK_MEMBRO_DIRETORIA
FOREIGN KEY (CodigoCoordenador) REFERENCES MEMBRO (Codigo)
GO

ALTER TABLE Diretoria
DROP CONSTRAINT FK_MEMBRO_DIRETORIA


ALTER TABLE MembroDiretoria
	ADD CONSTRAINT FK_Diretoria_MembroDiretoria
FOREIGN KEY (CodigoDiretoria) REFERENCES Diretoria (Codigo)
GO

ALTER TABLE MembroDiretoria
DROP CONSTRAINT FK_Diretoria_MembroDiretoria


ALTER TABLE MembroDiretoria
ADD CONSTRAINT FK_Membro_MembroDiretoria
FOREIGN KEY (CodigoMembro) REFERENCES MEMBRO (Codigo)
GO

ALTER TABLE MembroDiretoria
DROP CONSTRAINT FK_Membro_MembroDiretoria


ALTER TABLE Naufrago
ADD CONSTRAINT FK_Membro_Naufrago
FOREIGN KEY (CodigoMembro) REFERENCES Membro (Codigo)

ALTER TABLE Naufrago
DROP CONSTRAINT FK_Membro_Naufrago


ALTER TABLE Naufrago
ADD CONSTRAINT FK_Contato_Naufrago
FOREIGN KEY (CodigoContato) REFERENCES Contato (Codigo)

ALTER TABLE Naufrago
DROP CONSTRAINT FK_Contato_Naufrago


ALTER TABLE Naufrago
ADD CONSTRAINT FK_Instituicao_Naufrago
FOREIGN KEY (CodigoInstituicao) REFERENCES Instituicao (Codigo)

ALTER TABLE Naufrago
ADD CONSTRAINT FK_MembroMonitor_Naufrago
FOREIGN KEY (CodigoMonitor) REFERENCES Membro (Codigo)

ALTER TABLE Naufrago
DROP CONSTRAINT FK_MembroMonitor_Naufrago

ALTER TABLE Ilha
ADD CONSTRAINT FK_Instituicao_Ilha
FOREIGN KEY (CodigoInstituicao) REFERENCES Instituicao (Codigo)

ALTER TABLE Ilha
ADD CONSTRAINT FK_MembroMentor_Ilha
FOREIGN KEY (CodigoMentor) REFERENCES Membro (Codigo)

ALTER TABLE Ilha
DROP CONSTRAINT FK_MembroMentor_Ilha

ALTER TABLE Ilha
ADD CONSTRAINT FK_MembroMonitor_Ilha
FOREIGN KEY (CodigoMonitor) REFERENCES Membro (Codigo)

ALTER TABLE Ilha
DROP CONSTRAINT FK_MembroMonitor_Ilha

ALTER TABLE Ilha
ADD CONSTRAINT FK_MembroMembro_Ilha
FOREIGN KEY (CodigoMembro) REFERENCES Membro (Codigo)

ALTER TABLE Ilha
DROP CONSTRAINT FK_MembroMembro_Ilha

ALTER TABLE Bancada
ADD CONSTRAINT FK_Membro_Bancada
FOREIGN KEY (CodigoLider) REFERENCES Membro (Codigo)

ALTER TABLE Bancada
DROP CONSTRAINT FK_Membro_Bancada

ALTER TABLE Membro
ADD CONSTRAINT FK_Bancada_MEMBRO
FOREIGN KEY (CodigoBancada) REFERENCES Bancada (Codigo)


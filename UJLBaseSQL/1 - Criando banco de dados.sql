
/* ******| Banco de dados UJL |******
*
*Base criada com o objetivo de armazenar e estruturar as informa��es referente aos membros da Uni�o no S�o Paulo.
*
*
* Idealizado por Renan Moreira; Projetado por Renan Moreira e Lazzarini; Revisado e aprovado por Caio, Carol e Lazzarini;
* 
*/

create database UJLBase
GO
use UJLBase
--================================================================================================================
--=======================================| Cria��o das tabelas |==================================================
--================================================================================================================

CREATE TABLE Membro (
	Codigo INT PRIMARY KEY IDENTITY,
	Nome VARCHAR(50) NOT NULL,
	NomeSocial VARCHAR(50),
	Data_Nascimento DATE,
	Genero VARCHAR (50) CHECK (Genero IN('Homem Cisg�nero','Homem Transg�nero','Mulher Cisg�nero','Mulher Transg�nero','N�o Bin�rio', 'Prefiro n�o responder')) NOT NULL,
	Etnia VARCHAR(30) CHECK(Etnia IN('Amarelo (a)','Branco (a)','Pardo (a)','Negro (a)','Ind�gena','Prefiro n�o responder')) NOT NULL,
	Data_Ingresso DATE,
	CodigoInstituicao INT,
	PosicaoPolitica VARCHAR (255) NOT NULL,
	AreaEstudo VARCHAR(255)
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
	CodigoMembro INT NOT NULL,
	Bairro VARCHAR(255) NOT NULL,
	Cidade VARCHAR(50) NOT NULL,
	UF CHAR(2) NOT NULL,
	RegiaoCidade VARCHAR(255) NOT NULL CHECK (RegiaoCidade IN('Norte','Sul','Leste','Oeste','Centro','Nenhuma das op��es anteriores'))
)
GO

CREATE TABLE Instituicao(
	Codigo INT PRIMARY KEY IDENTITY,
	Nome VARCHAR(100) NOT NULL,
	GrauAcademico VARCHAR(50) NOT NULL CHECK (GrauAcademico IN('Ensino Fundamental','Ensino M�dio','Ensino Superior','Nenhuma das alternativas anteriores','Sou educador')),
	Polo VARCHAR(50)
)
GO

CREATE TABLE Bancada(
	Codigo INT PRIMARY KEY IDENTITY,
	Nome VARCHAR (255)
)
GO

CREATE TABLE MembroTemporaria(
	Nome VARCHAR(50),
	Idade INT,
	Faculdade VARCHAR(50),
	Celular VARCHAR(50)	
)
go

CREATE TABLE EscolhaBancada(
	CodigoMembro INT,
	Escolha VARCHAR(1000)
)
GO

CREATE TABLE MembroBancada(
	CodigoBancada INT,
	CodigoMembro INT,
	InicioSituacao DATE
)

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





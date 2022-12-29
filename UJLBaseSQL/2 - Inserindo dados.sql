USE UJLBase

BEGIN TRAN
DECLARE @ApenasTeste INT = 1
/* 
*
* Para coletar os dados usamos dois formulários. 
* Para a inserção utilizamos dois grupos de inserts e, logo após, 
* é realizada a integração dos dados coletados - nas tabelas Membro e Resposta.
*
*/

USE UJLBase

DECLARE
	@CodigoInstituicao INT,
	@CodigoEndereco INT,
	@CodigoContato INT,
	@CodigoMembro INT,
	@CodigoResposta INT,
	@NomeBancada VARCHAR (1000),
	@CodigoBancada INT

--==========================================================================================================================
--==================================| Inserindo Novos Membros |=============================================================
--==========================================================================================================================

	--Aqui entram os inserts (dados confidenciais*)
	
insert into instituicao(nome,grauacademico,polo,curso) values ('****************') 
	set @CodigoInstituicao = (select top 1(codigo) from instituicao order by codigo desc)	
	set @NomeBancada ='***************' if (select count(nome) from bancada b where nome like @NomeBancada) = 0
INSERT INTO Bancada (Nome) values (@NomeBancada); 
	SET @CodigoBancada = (SELECT Codigo FROM Bancada where nome = @NomeBancada)	
insert into membro (nome,nomesocial,data_nascimento,etnia,genero,data_ingresso,codigoinstituicao,posicaopolitica,CodigoBancada) values ('****************')
	set @CodigoMembro = (select TOP 1(codigo) from membro order by codigo desc)	
insert into endereco (codigomembro,uf,cidade,bairro,regiaocidade) values ('****************') 
	set @CodigoEndereco = (select top 1(codigo) from endereco order by codigo desc)	
insert into contato(codigomembro,email,telefone,facebook,twitter,instagram,linkedin) values 
('****************') 
	set @CodigoContato = (select top 1(codigo) from Contato order by codigo desc)		
insert into Naufrago (CodigoMembro,Nome,CodigoContato,CodigoInstituicao,CodigoMonitor) values ('****************')

--==========================================================================================================================
--=====================================| Atualizando as respostas dos membros |=============================================
--==========================================================================================================================
	
update r set R1 = td.porqueentrarujl, 
		R2 = td.quaisobjetivos, 
		R3 = td.definebolsonaro, 
		R4 = td.personalidades, 
		R5 = td.rejeitamovimentoliberal, 
		R6 = td.consideralula,
		R7 = td.AvaliaExGovernos,
		R8 = td.FazParteMovimentos,
		R9 = td.TrabalhaGabinete
		from Membro m
	join Contato c on c.CodigoMembro = m.Codigo
	join Resposta r on r.CodigoMembro = m.Codigo
	join TemporariaDois td on td.EMAIL = c.Email
	
-- Depois de realizada a atualização (update acima), os valores são deletados da TemporariaDois. 
delete from TemporariaDois where email in ( 
	select td.Email	
		from Membro m
		join Contato c on c.CodigoMembro = m.Codigo
		join Resposta r on r.CodigoMembro = m.Codigo
		join TemporariaDois td on td.EMAIL = c.Email
	)


IF @ApenasTeste = 1 BEGIN ROLLBACK; print 'Rollback'; END ELSE BEGIN COMMIT; print 'Commit' END
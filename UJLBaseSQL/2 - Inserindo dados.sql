USE UJLBase

BEGIN TRAN
DECLARE @ApenasTeste INT = 0

/* 
*
* Para coletar os dados usamos dois formulários. 
* Para a inserção utilizamos dois grupos de inserts e, logo após, 
* é realizada a integração dos dados coletados - nas tabelas Membro e Resposta.
*
*/

DECLARE
	@CodigoInstituicao INT,
	@CodigoEndereco INT,
	@CodigoContato INT,
	@CodigoMembro INT,
	@CodigoResposta INT,
	@NomeBancada VARCHAR (1000),
	@CodigoBancada INT

--======================================================================================================
--==================================| Inserindo Novos Membros |=========================================
--======================================================================================================

insert into instituicao(nome,grauacademico,polo) 
	values ('&') 
		set @CodigoInstituicao = (select top 1(codigo) from instituicao order by codigo desc)	
insert into membro (nome,nomesocial,data_nascimento,etnia,genero,data_ingresso,codigoinstituicao,posicaopolitica,areaestudo) 
	values ('&') set @CodigoMembro = (select TOP 1(codigo) from membro order by codigo desc)	
		set @NomeBancada ='&' 
insert into  EscolhaBancada (Escolha,CodigoMembro) values (@NomeBancada,@CodigoMembro)	
insert into endereco (codigomembro,uf,cidade,bairro,regiaocidade) 
	values ('&') 
		set @CodigoEndereco = (select top 1(codigo) from endereco order by codigo desc)	
insert into contato(codigomembro,email,telefone,facebook,twitter,instagram,linkedin) 
	values ('&') 
		set @CodigoContato = (select top 1(codigo) from Contato order by codigo desc)


IF @ApenasTeste = 1 BEGIN ROLLBACK; print 'Rollback'; END ELSE BEGIN COMMIT; print 'Commit' END
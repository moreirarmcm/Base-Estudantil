use UJLBase

--=========================================================================
----===============| Tabela 1: Geral Membros |=============================

select  
		mem.Codigo,
		mem.Nome, 
		CAST(DATEDIFF(DD,mem.Data_Nascimento,getdate()) / 365.25 as INT) as "Idade",
		mem.Genero,
		mem.Etnia,
		mem.PosicaoPolitica,
		ins.Nome as "Instituição de Ensino",
		mem.AreaEstudo,
		en.Cidade,
		en.UF as "Estado",
		con.Email,
		con.Telefone
		from Membro mem
		join Instituicao ins on ins.Codigo = mem.CodigoInstituicao
		join Endereco en on en.CodigoMembro = mem.Codigo 
		join Contato con on con.CodigoMembro = mem.Codigo
	
--=========================================================================
----=====| Tabela 2: Aniversariantes do próximo mês |======================

SELECT
	CAST(DATEDIFF(dd,mem.Data_Nascimento,getdate())/365.25 + 1 as INT)
	--Convert(Varchar,DATEDIFF(dd,mem.Data_Nascimento,getdate())/365.25 + 1) + ' anos'
	 FROM Membro mem


select 
	mem.Codigo,
	mem.NomeSocial,
	Convert(varchar,DAY(Data_Nascimento)) + ' de ' + DATENAME(MONTH, Data_Nascimento),
	--Convert(varchar,DAY(Data_Nascimento)) + '/' + Convert(varchar,MONTH(Data_Nascimento)) + '/' + Convert(varchar,YEAR(Data_Nascimento)),
	CAST(DATEDIFF(dd,mem.Data_Nascimento,getdate())/365.25 + 1 as INT),
	con.Email,
	con.Telefone
	from Membro mem
	join Contato con on con.CodigoMembro = mem.Codigo
		AND ( MONTH(Data_Nascimento) = MONTH(GETDATE()) OR MONTH(Data_Nascimento) = MONTH(GETDATE() + 30) )

--=========================================================================
----=====| Tabela 3: Quantidade de alunos por faculdade |==================
select 
	ins.Nome, 
	COUNT(mem.Nome) as 'Quantidade de Alunos'
	from Membro mem
	join Instituicao ins on ins.Codigo = mem.CodigoInstituicao
		group by ins.Nome
		order by 'Quantidade de Alunos' desc

--=========================================================================
----=====| Tabela 4: Quantidade de membros por cidade |==================

select en.Cidade, COUNT(mem.Nome)
	from Membro mem
	join Endereco en on mem.Codigo = en.CodigoMembro
	GROUP BY en.Cidade


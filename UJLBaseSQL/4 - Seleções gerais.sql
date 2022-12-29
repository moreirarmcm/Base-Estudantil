USE UJLBase

BEGIN TRAN
DECLARE @ApenasTeste INT = 1

--============ Selecionando todas as tabelas ================
/*
select* from Membro
select* from Instituicao
select* from Endereco
select* from Contato
select* from Resposta
select* from Diretoria
select* from MembroDiretoria
select* from Ilha
select* from Naufrago
*/

--==============| Selecionando Membros que estudam em um determinada faculdade |==================

DECLARE @NomeInstituicao VARCHAR(30) = 'Nome da Universidade'

SELECT m.Codigo as 'Identificação', m.Nome as 'Nome do Membro', i.Nome as 'Faculdade', i.Polo, i.Curso
	FROM Membro m
		join Instituicao i on m.CodigoInstituicao = i.Codigo
		AND i.Nome like @NomeInstituicao
		ORDER BY i.Polo,i.Curso

--============ Seleciona todas as intituições duplicadas na tabela Instituicao ================
-- *Retorna as intituições que possuem 2 ou mais linhas com o mesmo nome e polo.
SELECT *
	FROM Instituicao i
		WHERE EXISTS (SELECT *
						FROM Instituicao ii
							WHERE i.Nome = ii.Nome
						--AND i.GrauAcademico = ii.GrauAcademico
						AND i.Polo = ii.Polo
						--AND i.Curso = ii.Curso
						GROUP BY Nome 
							HAVING COUNT(*) > 1)
		ORDER BY i.Nome,i.Codigo ASC


IF @ApenasTeste = 1 BEGIN ROLLBACK; print 'Rollback'; END ELSE BEGIN COMMIT; print 'Commit' END
	





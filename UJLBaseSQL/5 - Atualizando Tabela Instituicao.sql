USE UJLBase

BEGIN TRAN
DECLARE @ApenasTeste INT = 1

--== Execute esse script até o retorno ser "0 linhas afetadas" ==

-- Buscando o código das instituições duplicadas
DECLARE @CodInstituicao INT = (
			SELECT top 1(i.Codigo)
				FROM Instituicao i
					WHERE exists (SELECT *
									FROM Instituicao ii
										WHERE i.Nome = ii.Nome
										AND i.GrauAcademico = ii.GrauAcademico
										AND i.Polo = ii.Polo
										AND i.Curso = ii.Curso
											GROUP BY GrauAcademico, Nome,Polo 
										HAVING COUNT(*) > 1
										--ORDER BY ii.Nome
									)
							)

-- Obtendo o nome dessa instituição
DECLARE @NomeInstituicao VARCHAR(200) = (SELECT Nome FROM Instituicao WHERE Codigo = @CodInstituicao)

--Atualizando a tabela Membro
UPDATE me SET CodigoInstituicao = @CodInstituicao
	FROM Membro me
		WHERE me.CodigoInstituicao IN (SELECT codigo
										FROM Instituicao i
											WHERE i.Nome = @NomeInstituicao
									)
UPDATE il SET CodigoInstituicao = @CodInstituicao
	FROM Ilha il
		WHERE il.CodigoInstituicao IN (SELECT codigo
										FROM Instituicao i
											WHERE i.Nome = @NomeInstituicao
									)
UPDATE na SET CodigoInstituicao = @CodInstituicao
	FROM Naufrago na
		WHERE na.CodigoInstituicao IN (SELECT codigo
										FROM Instituicao i
											WHERE i.Nome = @NomeInstituicao
									)

-- Deletando as intituições duplicadas na tabela Instituicao
DELETE Instituicao
	WHERE codigo in ( SELECT Codigo FROM Instituicao
						WHERE Nome = @NomeInstituicao
						AND Codigo <> @CodInstituicao
					)

IF @ApenasTeste = 1 BEGIN ROLLBACK; print 'Rollback'; END ELSE BEGIN COMMIT; print 'Commit' END
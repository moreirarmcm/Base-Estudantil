USE UJLBase


BEGIN TRAN
DECLARE @ApenasTeste INT = 0

		
DECLARE @CodigoMembro INT = (SELECT top 1 m1.codigo
	FROM Membro m1
		join contato c1 on c1.CodigoMembro = m1.Codigo
		and EXISTS (SELECT *
						FROM Membro m2
							join Contato c2 on c2.CodigoMembro = m2.Codigo
									and m1.Nome = m2.Nome
									and c1.Email = c2.Email 
						--AND i.GrauAcademico = ii.GrauAcademico
							GROUP BY Nome 
							HAVING COUNT(*) > 1)
		ORDER BY m1.Nome,m1.Codigo ASC)

DECLARE @CodigoMembroApagar INT = (SELECT top 1 m1.codigo
	FROM Membro m1
		WHERE EXISTS (SELECT *
						FROM Membro m2
							WHERE m1.Nome = m2.Nome
							AND m1.Codigo <> @CodigoMembro
						--AND i.GrauAcademico = ii.GrauAcademico
							GROUP BY Nome 
							HAVING COUNT(*) > 1)
		ORDER BY m1.Nome,m1.Codigo ASC)


DECLARE @NomeMembro VARCHAR (255) = (SELECT Nome FROM Membro WHERE Codigo = @CodigoMembro)
DECLARE @EmailMembro VARCHAR (255) = (SELECT Email FROM Contato WHERE CodigoMembro = @CodigoMembro)
--select @CodigoMembroApagar,@EmailMembro

DELETE FROM Contato WHERE CodigoMembro = @CodigoMembroApagar /*in (
	SELECT m.Codigo FROM Membro m
								join Contato c on c.CodigoMembro = m.Codigo
								AND m.Nome = @NomeMembro
								AND c.Email = @EmailMembro 
								AND m.Codigo <> @CodigoMembro
										) */


DELETE FROM Endereco WHERE CodigoMembro = @CodigoMembroApagar /*in (
								SELECT top 1(m.Codigo) FROM Membro m
								join Contato c on c.CodigoMembro = m.Codigo
								AND m.Nome = @NomeMembro
								AND c.Email = @EmailMembro 
								AND m.Codigo <> @CodigoMembro)
								*/

DELETE FROM Membro WHERE Codigo = @CodigoMembroApagar /*in (
SELECT m.Codigo FROM Membro m
								join Contato c on c.CodigoMembro = m.Codigo
								AND m.Nome = @NomeMembro
								AND c.Email = @EmailMembro 
								AND m.Codigo <> @CodigoMembro)
								*/


IF @ApenasTeste = 1 BEGIN ROLLBACK; print 'Rollback'; END ELSE BEGIN COMMIT; print 'Commit' END


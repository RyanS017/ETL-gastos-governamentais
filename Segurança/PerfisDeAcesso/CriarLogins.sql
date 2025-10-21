USE master;
GO

CREATE LOGIN Login_Visualizador 
WITH PASSWORD = 'SenhaForte1!', CHECK_POLICY = ON;
GO

CREATE LOGIN Login_Analista 
WITH PASSWORD = 'SenhaForte2!', CHECK_POLICY = ON;
GO

CREATE LOGIN Login_Desenvolvedor 
WITH PASSWORD = 'SenhaForte3!', CHECK_POLICY = ON;
GO


-- Obs: Senhas e Logins criados apenas como exemplo, pois não é seguro deixar senhas explícitas diretamente em uma query --
USE master;
GO

CREATE LOGIN Login_Visualizador 
WITH PASSWORD = 'Vizualidor123!', CHECK_POLICY = ON;
GO

CREATE LOGIN Login_Analista 
WITH PASSWORD = 'Analista123!', CHECK_POLICY = ON;
GO

CREATE LOGIN Login_Desenvolvedor 
WITH PASSWORD = 'Desenvolvedor123!!', CHECK_POLICY = ON;
GO


-- Obs: Senhas e Logins criados apenas como exemplo, pois não é seguro deixar senhas explícitas diretamente em uma query --
USE ProjetoGastosGovernamentais;
GO


DROP PROCEDURE IF EXISTS SP_ETL_CARTAO;
DROP PROCEDURE IF EXISTS SP_CARREGA_CSV_CARTAO;
DROP PROCEDURE IF EXISTS SP_TRATA_CSV_CARTAO;
DROP PROCEDURE IF EXISTS SP_EXTRAI_CSV_CARTAO;
GO





CREATE PROCEDURE SP_EXTRAI_CSV_CARTAO
    @CAMINHO_DO_ARQUIVO VARCHAR(255)
AS
BEGIN

    CREATE TABLE ##temp_cartao_bruto (
        CODIGOORGAOSUPERIOR VARCHAR(MAX), 
		NOMEORGAOSUPERIOR VARCHAR(MAX), 
		CODIGOORGAO VARCHAR(MAX),
        NOMEORGAO VARCHAR(MAX), 
		CODIGOUNIDADEGESTORA VARCHAR(MAX),
		NOMEUNIDADEGESTORA VARCHAR(MAX),
        ANOEXTRATO VARCHAR(MAX), 
		MÊSEXTRATO VARCHAR(MAX), 
		CPFPORTADOR VARCHAR(MAX), 
		NOMEPORTADOR VARCHAR(MAX),
        CNPJOUCPFFAVORECIDO VARCHAR(MAX), 
		NOMEFAVORECIDO VARCHAR(MAX), 
		TRANSAÇAO VARCHAR(MAX),
        DATATRANSAÇAO VARCHAR(MAX), 
		VALORTRANSAÇAO VARCHAR(MAX)
    );
    
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BULK INSERT ##temp_cartao_bruto FROM ''' + @CAMINHO_DO_ARQUIVO + N''' WITH (FIRSTROW = 2, FIELDTERMINATOR = '';'', ROWTERMINATOR = ''0x0A'', CODEPAGE = ''RAW'')';
    EXEC sp_executesql @sql;
END;
GO


CREATE PROCEDURE SP_TRATA_CSV_CARTAO
AS
BEGIN
  
    UPDATE ##temp_cartao_bruto 
	SET
		CODIGOORGAOSUPERIOR = REPLACE(CODIGOORGAOSUPERIOR, '"', ''), 
		NOMEORGAOSUPERIOR = REPLACE(NOMEORGAOSUPERIOR, '"', ''), 
		CODIGOORGAO = REPLACE(CODIGOORGAO, '"', ''),
		NOMEORGAO = REPLACE(NOMEORGAO, '"', ''),
		CODIGOUNIDADEGESTORA = REPLACE(CODIGOUNIDADEGESTORA, '"', ''),
		NOMEUNIDADEGESTORA = REPLACE(NOMEUNIDADEGESTORA, '"', ''), 
		ANOEXTRATO = REPLACE(ANOEXTRATO, '"', ''),
		MÊSEXTRATO = REPLACE(MÊSEXTRATO, '"', ''), 
		CPFPORTADOR = REPLACE(CPFPORTADOR, '"', ''), 
		NOMEPORTADOR = REPLACE(NOMEPORTADOR, '"', ''),
		CNPJOUCPFFAVORECIDO = REPLACE(CNPJOUCPFFAVORECIDO, '"', ''), 
		NOMEFAVORECIDO = REPLACE(NOMEFAVORECIDO, '"', ''), 
		TRANSAÇAO = REPLACE(TRANSAÇAO, '"', ''), 
		DATATRANSAÇAO = REPLACE(DATATRANSAÇAO, '"', ''), 
		VALORTRANSAÇAO = REPLACE(VALORTRANSAÇAO, '"', '');

  
    IF OBJECT_ID('tempdb..##temp_cartao_convertido') IS NOT NULL DROP TABLE ##temp_cartao_convertido;
    CREATE TABLE ##temp_cartao_convertido (
        DataTransacao DATE,
		ValorTransacao DECIMAL(18,2),
		DataExtrato DATE,
        IdOrgaoSuperior INT, 
		NomeOrgaoSuperior VARCHAR(150),
        IdOrgaoSubordinado INT, 
		NomeOrgaoSubordinado VARCHAR(150),
        IdUnidadeGestora INT, 
		NomeUnidadeGestora VARCHAR(150)
    );

  
    INSERT INTO ##temp_cartao_convertido
    SELECT
		CONVERT(DATE, CONCAT('01', '-', MÊSEXTRATO, '-', ANOEXTRATO), 103),
        TRY_CAST(REPLACE(VALORTRANSAÇAO, ',', '.') AS DECIMAL(18, 2)),
        DATEFROMPARTS(TRY_CAST(ANOEXTRATO AS INT), TRY_CAST(MÊSEXTRATO AS INT), 1),
        TRY_CAST(CODIGOORGAOSUPERIOR AS INT), NOMEORGAOSUPERIOR,
        TRY_CAST(CODIGOORGAO AS INT), NOMEORGAO,
        TRY_CAST(CODIGOUNIDADEGESTORA AS INT), NOMEUNIDADEGESTORA
    FROM ##temp_cartao_bruto;
END;
GO


CREATE PROCEDURE SP_CARREGA_CSV_CARTAO
AS
BEGIN

	WITH CTE AS (				--Criação de uma CTE para selecionar os dados necessários, e principalmente para a criação de um ROW_NUMBER que será usado para diferenciar os dados iguais dentro da tabela temporaria
	    SELECT 
	        IdOrgaoSuperior,
	        NomeOrgaoSuperior,
	        ROW_NUMBER() OVER(PARTITION BY IdOrgaoSuperior ORDER BY IdOrgaoSuperior) AS rn  --Aqui estamos criando uma sequência contendo os valores repitidos da tabela. Para que em seu preenchimento não haja duplicatas de uma PK
	    FROM ##temp_cartao_convertido
	    WHERE IdOrgaoSuperior <> 0 AND	IdOrgaoSuperior IS NOT NULL															--Estamos excluindo os que contém '0' da consulta, porque são valores invalidos
	)
	INSERT INTO OrgaoSuperior (IdOrgaoSuperior, NomeOrgaoSuperior)				--Preenchimento da tabela OrgaoSuperior
	SELECT IdOrgaoSuperior, NomeOrgaoSuperior
	FROM CTE
	WHERE rn = 1									--Pegando apenas os primeiros da sequencia criada anteriormente para evitar duplicadas
	  AND NOT EXISTS (								--Verificando se o valor já existe na tabela principal
	      SELECT 1 FROM OrgaoSuperior o
	      WHERE o.IdOrgaoSuperior = CTE.IdOrgaoSuperior
	  );

     WITH CTE AS (				--Criação de uma CTE para selecionar os dados necessários, e principalmente para a criação de um ROW_NUMBER que será usado para diferenciar os dados iguais dentro da tabela temporaria
		SELECT 
		    IdOrgaoSubordinado,
		    NomeOrgaoSubordinado,
			IdOrgaoSuperior,
		    ROW_NUMBER() OVER(PARTITION BY IdOrgaoSubordinado ORDER BY IdOrgaoSubordinado) AS rn  --Aqui estamos criando uma sequência contendo os valores repitidos da tabela. Para que em seu preenchimento não haja duplicatas de uma PK
		FROM ##temp_cartao_convertido
		WHERE IdOrgaoSubordinado <> 0 AND	IdOrgaoSubordinado IS NOT NULL															--Estamos excluindo os que contém '0' da consulta, porque são valores invalidos
)
		INSERT INTO OrgaoSubordinado (IdOrgaoSubordinado, NomeOrgaoSubordinado, IdOrgaoSuperior)				--Preenchimento da tabela OrgaoSuperior
		SELECT IdOrgaoSubordinado, NomeOrgaoSubordinado, IdOrgaoSuperior	
		FROM CTE
		WHERE rn = 1									--Pegando apenas os primeiros da sequencia criada anteriormente para evitar duplicadas
			AND NOT EXISTS (								--Verificando se o valor já existe na tabela principal
		SELECT 1 FROM OrgaoSubordinado o
		WHERE o.IdOrgaoSubordinado = CTE.IdOrgaoSubordinado
  );


	  WITH CTE AS (				--Criação de uma CTE para selecionar os dados necessários, e principalmente para a criação de um ROW_NUMBER que será usado para diferenciar os dados iguais dentro da tabela temporaria
	    SELECT 
	        IdUnidadeGestora,
	        NomeUnidadeGestora,
			IdOrgaoSuperior,
	        ROW_NUMBER() OVER(PARTITION BY IdUnidadeGestora ORDER BY IdUnidadeGestora) AS rn  --Aqui estamos criando uma sequência contendo os valores repitidos da tabela. Para que em seu preenchimento não haja duplicatas de uma PK
	    FROM ##temp_cartao_convertido
	    WHERE IdUnidadeGestora <> 0 AND	IdUnidadeGestora IS NOT NULL															--Estamos excluindo os que contém '0' da consulta, porque são valores invalidos
	)
	INSERT INTO UnidadeGestora (IdUnidadeGestora, NomeUnidadeGestora, IdOrgaoSuperior)				--Preenchimento da tabela OrgaoSuperior
	SELECT IdUnidadeGestora, NomeUnidadeGestora, IdOrgaoSuperior
	FROM CTE
	WHERE rn = 1									--Pegando apenas os primeiros da sequencia criada anteriormente para evitar duplicadas
	  AND NOT EXISTS (								--Verificando se o valor já existe na tabela principal
	      SELECT 1 FROM UnidadeGestora o
	      WHERE o.IdUnidadeGestora = CTE.IdUnidadeGestora
	  );

 
    
    INSERT INTO dbo.GastosCartao (DataTransacao, ValorTransacao, DataExtrato, IdOrgaoSuperior, IdOrgaoSubordinado, IdUnidadeGestora, IdMandato)
    SELECT
        temp.DataTransacao,
        temp.ValorTransacao, 
		temp.DataExtrato,
        temp.IdOrgaoSuperior, 
		temp.IdOrgaoSubordinado, 
		temp.IdUnidadeGestora,
        m.IdMandato
    FROM ##temp_cartao_convertido AS temp
    JOIN dbo.Mandato m ON temp.DataTransacao >= m.DataInicio  AND (temp.DataTransacao <= m.DataFim OR m.DataFim IS NULL);	
END;
GO


CREATE PROCEDURE SP_ETL_CARTAO
    @CAMINHO_CSV VARCHAR(255)
AS
BEGIN
 
    EXEC SP_EXTRAI_CSV_CARTAO @CAMINHO_DO_ARQUIVO = @CAMINHO_CSV;
    
    
    EXEC SP_TRATA_CSV_CARTAO;
    
    
    EXEC SP_CARREGA_CSV_CARTAO;
    
    
    IF OBJECT_ID('tempdb..##temp_cartao_bruto') IS NOT NULL DROP TABLE ##temp_cartao_bruto;
    IF OBJECT_ID('tempdb..##temp_cartao_convertido') IS NOT NULL DROP TABLE ##temp_cartao_convertido;
    
  
END;
GO


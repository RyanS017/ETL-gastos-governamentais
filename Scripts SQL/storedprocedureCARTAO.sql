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
    SET NOCOUNT ON;

    CREATE TABLE ##temp_cartao_bruto (
        CODIGOORGAOSUPERIOR NVARCHAR(MAX), NOMEORGAOSUPERIOR NVARCHAR(MAX), CODIGOORGAO NVARCHAR(MAX),
        NOMEORGAO NVARCHAR(MAX), CODIGOUNIDADEGESTORA NVARCHAR(MAX), NOMEUNIDADEGESTORA NVARCHAR(MAX),
        ANOEXTRATO NVARCHAR(MAX), MÊSEXTRATO NVARCHAR(MAX), CPFPORTADOR NVARCHAR(MAX), NOMEPORTADOR NVARCHAR(MAX),
        CNPJOUCPFFAVORECIDO NVARCHAR(MAX), NOMEFAVORECIDO NVARCHAR(MAX), TRANSAÇAO NVARCHAR(MAX),
        DATATRANSAÇAO NVARCHAR(MAX), VALORTRANSAÇAO NVARCHAR(MAX)
    );
    
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'BULK INSERT ##temp_cartao_bruto FROM ''' + @CAMINHO_DO_ARQUIVO + N''' WITH (FIRSTROW = 2, FIELDTERMINATOR = '';'', ROWTERMINATOR = ''\n'', CODEPAGE = ''1252'')';
    EXEC sp_executesql @sql;
END;
GO


CREATE PROCEDURE SP_TRATA_CSV_CARTAO
AS
BEGIN
    SET NOCOUNT ON;
  
    UPDATE ##temp_cartao_bruto SET CODIGOORGAOSUPERIOR = REPLACE(CODIGOORGAOSUPERIOR, '"', ''), NOMEORGAOSUPERIOR = REPLACE(NOMEORGAOSUPERIOR, '"', ''), CODIGOORGAO = REPLACE(CODIGOORGAO, '"', ''), NOMEORGAO = REPLACE(NOMEORGAO, '"', ''), CODIGOUNIDADEGESTORA = REPLACE(CODIGOUNIDADEGESTORA, '"', ''), NOMEUNIDADEGESTORA = REPLACE(NOMEUNIDADEGESTORA, '"', ''), ANOEXTRATO = REPLACE(ANOEXTRATO, '"', ''), MÊSEXTRATO = REPLACE(MÊSEXTRATO, '"', ''), CPFPORTADOR = REPLACE(CPFPORTADOR, '"', ''), NOMEPORTADOR = REPLACE(NOMEPORTADOR, '"', ''), CNPJOUCPFFAVORECIDO = REPLACE(CNPJOUCPFFAVORECIDO, '"', ''), NOMEFAVORECIDO = REPLACE(NOMEFAVORECIDO, '"', ''), TRANSAÇAO = REPLACE(TRANSAÇAO, '"', ''), DATATRANSAÇAO = REPLACE(DATATRANSAÇAO, '"', ''), VALORTRANSAÇAO = REPLACE(VALORTRANSAÇAO, '"', '');

  
    IF OBJECT_ID('tempdb..##temp_cartao_convertido') IS NOT NULL DROP TABLE ##temp_cartao_convertido;
    CREATE TABLE ##temp_cartao_convertido (
        DataTransacao DATE, ValorTransacao DECIMAL(18,2), DataExtrato DATE,
        IdOrgaoSuperior INT, NomeOrgaoSuperior VARCHAR(150),
        IdOrgaoSubordinado INT, NomeOrgaoSubordinado VARCHAR(150),
        IdUnidadeGestora INT, NomeUnidadeGestora VARCHAR(150)
    );

  
    INSERT INTO ##temp_cartao_convertido
    SELECT
        (CASE WHEN ISDATE(DATATRANSAÇAO) = 1 THEN CONVERT(DATE, DATATRANSAÇAO, 103) ELSE NULL END),
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
    SET NOCOUNT ON;


    INSERT INTO dbo.OrgaoSuperior (IdOrgaoSuperior, NomeOrgaoSuperior)
    SELECT DISTINCT IdOrgaoSuperior, NomeOrgaoSuperior FROM ##temp_cartao_convertido temp WHERE IdOrgaoSuperior IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dbo.OrgaoSuperior WHERE IdOrgaoSuperior = temp.IdOrgaoSuperior);

    INSERT INTO dbo.OrgaoSubordinado (IdOrgaoSubordinado, NomeOrgaoSubordinado, IdOrgaoSuperior)
    SELECT DISTINCT IdOrgaoSubordinado, NomeOrgaoSubordinado, IdOrgaoSuperior FROM ##temp_cartao_convertido temp WHERE IdOrgaoSubordinado IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dbo.OrgaoSubordinado WHERE IdOrgaoSubordinado = temp.IdOrgaoSubordinado);

    INSERT INTO dbo.UnidadeGestora (IdUnidadeGestora, NomeUnidadeGestora, IdOrgaoSuperior)
    SELECT DISTINCT IdUnidadeGestora, NomeUnidadeGestora, IdOrgaoSuperior FROM ##temp_cartao_convertido temp WHERE IdUnidadeGestora IS NOT NULL AND NOT EXISTS (SELECT 1 FROM dbo.UnidadeGestora WHERE IdUnidadeGestora = temp.IdUnidadeGestora);

    
    DECLARE @DataProvisoria DATE;
    SELECT TOP 1 @DataProvisoria = DataExtrato FROM ##temp_cartao_convertido;
    SET @DataProvisoria = ISNULL(@DataProvisoria, '1900-01-01');

    
    DECLARE @UltimoId BIGINT = (SELECT ISNULL(MAX(IdGastosCartao), 0) FROM dbo.GastosCartao);
    INSERT INTO dbo.GastosCartao (IdGastosCartao, DataTransacao, ValorTransacao, DataExtrato, IdOrgaoSuperior, IdOrgaoSubordinado, IdUnidadeGestora, IdMandato)
    SELECT
        @UltimoId + ROW_NUMBER() OVER(ORDER BY (SELECT NULL)),
        ISNULL(temp.DataTransacao, @DataProvisoria), 
        temp.ValorTransacao, temp.DataExtrato,
        temp.IdOrgaoSuperior, temp.IdOrgaoSubordinado, temp.IdUnidadeGestora,
        ISNULL(m.IdMandato, 1) 
    FROM ##temp_cartao_convertido AS temp
    LEFT JOIN dbo.Mandato AS m ON temp.DataTransacao BETWEEN m.DataInicio AND ISNULL(m.DataFim, '9999-12-31');
END;
GO


CREATE PROCEDURE SP_ETL_CARTAO
    @CAMINHO_CSV VARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;
   
    
    
  
    EXEC SP_EXTRAI_CSV_CARTAO @CAMINHO_DO_ARQUIVO = @CAMINHO_CSV;
    
    
    EXEC SP_TRATA_CSV_CARTAO;
    
    
    EXEC SP_CARREGA_CSV_CARTAO;
    
    
    IF OBJECT_ID('tempdb..##temp_cartao_bruto') IS NOT NULL DROP TABLE ##temp_cartao_bruto;
    IF OBJECT_ID('tempdb..##temp_cartao_convertido') IS NOT NULL DROP TABLE ##temp_cartao_convertido;
    
  
END;
GO


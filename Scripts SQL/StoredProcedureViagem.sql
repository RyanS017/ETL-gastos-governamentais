USE ProjetoGastosGovernamentais
GO

CREATE PROCEDURE SP_EXTRAI_VIAGEM
@CAMINHO VARCHAR(150)
AS
BEGIN
	IF OBJECT_ID('tempdb..##temp_viagem_csv_tb') IS NOT NULL
    DROP TABLE ##temp_viagem_csv_tb;

	CREATE TABLE ##temp_viagem_csv_tb (
	    IdentificadorDoprocessoDeViagem VARCHAR(MAX),
	    NumeroDaProposta_PCDP VARCHAR(MAX),
	    Situacao VARCHAR(MAX),
	    ViagemUrgente VARCHAR(MAX),
	    JustificativaUrgenciaViagem VARCHAR(MAX),
	    CodigoDoOrgaoSuperior VARCHAR(MAX),
	    NomeDoOrgaoSuperior VARCHAR(MAX),
	    CodigoOrgaoSolicitante VARCHAR(MAX),
	    NomeOrgaoSolicitante VARCHAR(MAX),
	    CPFviajante VARCHAR(MAX),
	    Nome VARCHAR(MAX),
	    Cargo VARCHAR(MAX),
	    Funcao VARCHAR(MAX),
	    DescricaoFuncao VARCHAR(MAX),
	    Periodo_DataDeInicio VARCHAR(MAX),
	    Periodo_DataDeFim VARCHAR(MAX),
	    Destinos VARCHAR(MAX),
	    Motivo VARCHAR(MAX),
	    ValorDiarias VARCHAR(MAX),
	    ValorPassagens VARCHAR(MAX),
	    ValorDevolucao VARCHAR(MAX),
	    ValorOutrosGastos VARCHAR(MAX)
	);
	
DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'
    BULK INSERT ##temp_viagem_csv_tb
    FROM ''' + @CAMINHO + N'''
    WITH (
        FIELDTERMINATOR = '';'' ,
        ROWTERMINATOR = ''\n'',
        FIRSTROW = 2,
        CODEPAGE = ''1252''
    );';

    EXEC sp_executesql @sql;

END;
GO


CREATE PROCEDURE SP_TRATA_VIAGEM
AS
BEGIN

	ALTER TABLE ##temp_viagem_csv_tb
	DROP COLUMN NumeroDaProposta_PCDP, Situacao, ViagemUrgente, JustificativaUrgenciaViagem, Nome, Funcao, DescricaoFuncao, CPFviajante, Cargo
	
	UPDATE ##temp_viagem_csv_tb
	SET 
	    IdentificadorDoprocessoDeViagem = REPLACE(IdentificadorDoprocessoDeViagem, '"', ''),
	    CodigoDoOrgaoSuperior           = REPLACE(CodigoDoOrgaoSuperior, '"', ''),
	    NomeDoOrgaoSuperior             = REPLACE(NomeDoOrgaoSuperior, '"', ''),
	    CodigoOrgaoSolicitante          = REPLACE(CodigoOrgaoSolicitante, '"', ''),
	    NomeOrgaoSolicitante            = REPLACE(NomeOrgaoSolicitante, '"', ''),
	    Periodo_DataDeInicio            = REPLACE(Periodo_DataDeInicio, '"', ''),
	    Periodo_DataDeFim               = REPLACE(Periodo_DataDeFim, '"', ''),
	    Destinos                        = REPLACE(Destinos, '"', ''),
	    Motivo                          = REPLACE(Motivo, '"', ''),
	    ValorDiarias                    = REPLACE(ValorDiarias, '"', ''),
	    ValorPassagens                  = REPLACE(ValorPassagens, '"', ''),
	    ValorDevolucao                  = REPLACE(ValorDevolucao, '"', ''),
	    ValorOutrosGastos               = REPLACE(ValorOutrosGastos, '"', '');
	
	DELETE
	FROM ##temp_viagem_csv_tb
	WHERE TRY_CAST(REPLACE(ValorDiarias, ',', '.') AS DECIMAL(18,2)) IS NULL 
	or TRY_CAST(REPLACE(ValorPassagens, ',', '.') AS DECIMAL(18,2)) IS NULL
	OR TRY_CAST(REPLACE(ValorOutrosGastos, ',', '.') AS DECIMAL(18,2)) IS NULL
	AND ValorDiarias NOT IN ('', '-1')
	and ValorPassagens NOT IN ('', '-1')
	AND ValorOutrosGastos NOT IN ('', '-1')
	
	
	DELETE 
	FROM ##temp_viagem_csv_tb
	WHERE IdentificadorDoprocessoDeViagem IN ('', '-1')

	IF OBJECT_ID('tempdb..##temp_viajens_convertido_tb') IS NOT NULL DROP TABLE ##temp_viajens_convertido_tb;

	CREATE TABLE ##temp_viajens_convertido_tb (
	    IdentificadorDoprocessoDeViagem INT,
	    CodigoDoOrgaoSuperior INT,
	    NomeDoOrgaoSuperior VARCHAR(150),
	    CodigoOrgaoSolicitante INT,
	    NomeOrgaoSolicitante VARCHAR(150),
	    Periodo_DataDeInicio DATE,
	    Periodo_DataDeFim DATE,
	    Destinos VARCHAR(255),
	    Motivo VARCHAR(255),
	    ValorDiarias DECIMAL(18,2),
	    ValorPassagens DECIMAL(18,2),
	    ValorDevolucao DECIMAL(18,2),
	    ValorOutrosGastos DECIMAL(18,2)
	);
	
	
	
	INSERT INTO ##temp_viajens_convertido_tb
	SELECT
		CAST(IdentificadorDoprocessoDeViagem AS INT),
		CASE WHEN CodigoDoOrgaoSuperior IN ('','-1') THEN 0 ELSE CAST(CodigoDoOrgaoSuperior AS INT) END, 
	    CAST(NomeDoOrgaoSuperior AS VARCHAR(150)),
		CASE WHEN CodigoOrgaoSolicitante IN ('','-1') THEN 0 ELSE CAST(CodigoOrgaoSolicitante AS INT) END,
		CAST(NomeOrgaoSolicitante AS VARCHAR(150)),
		CASE 
	    WHEN Periodo_DataDeInicio IS NULL OR Periodo_DataDeInicio = '' THEN NULL
	    ELSE CAST(REPLACE(Periodo_DataDeInicio,'/','-') AS DATE) END,
		CASE
		WHEN Periodo_DataDeFim IS NULL OR Periodo_DataDeFim = '' THEN NULL
	    ELSE CAST(REPLACE(Periodo_DataDeFim,'/','-') AS DATE) END,
		CAST(Destinos AS VARCHAR(150)),
		CAST(Motivo AS VARCHAR(150)),
		CASE WHEN ValorDiarias IN ('','-1') THEN 0 ELSE CAST(REPLACE(ValorDiarias,',','.') AS DECIMAL(18,2)) END,
		CASE WHEN ValorPassagens IN ('','-1') THEN 0 ELSE CAST(REPLACE(ValorPassagens,',','.') AS DECIMAL(18,2)) END,
		CASE WHEN ValorDevolucao IN ('','-1') THEN 0 ELSE CAST(REPLACE(ValorDevolucao,',','.') AS DECIMAL(18,2)) END,
		CASE WHEN ValorOutrosGastos IN ('','-1') THEN 0 ELSE CAST(REPLACE(ValorOutrosGastos,',','.') AS DECIMAL(18,2)) END
	
	FROM ##temp_viagem_csv_tb
END;
GO

CREATE PROCEDURE SP_CARREGA_VIAGEM
AS
BEGIN
	WITH CTE AS (
	    SELECT 
	        CodigoDoOrgaoSuperior,
	        NomeDoOrgaoSuperior,
	        ROW_NUMBER() OVER(PARTITION BY CodigoDoOrgaoSuperior ORDER BY CodigoDoOrgaoSuperior) AS rn
	    FROM ##temp_viajens_convertido_tb
	    WHERE CodigoDoOrgaoSuperior <> 0
	)
	INSERT INTO OrgaoSuperior (IdOrgaoSuperior, NomeOrgaoSuperior)
	SELECT CodigoDoOrgaoSuperior, NomeDoOrgaoSuperior
	FROM CTE
	WHERE rn = 1
	  AND NOT EXISTS (
	      SELECT 1 FROM OrgaoSuperior o
	      WHERE o.IdOrgaoSuperior = CTE.CodigoDoOrgaoSuperior
	  );
	
	
	WITH CTE AS (
		SELECT
			CodigoOrgaoSolicitante,
			NomeOrgaoSolicitante,
			ROW_NUMBER() OVER (PARTITION BY CodigoOrgaoSolicitante ORDER BY CodigoOrgaoSolicitante) AS rn
		FROM ##temp_viajens_convertido_tb
		WHERE CodigoOrgaoSolicitante <> 0
	)
	INSERT INTO OrgaoSolicitante (IdOrgaoSolicitante, NomeOrgaoSolicitante)
	SELECT CodigoOrgaoSolicitante, NomeOrgaoSolicitante
	FROM CTE
	WHERE rn = 1
		AND NOT EXISTS (
			SELECT 1 FROM OrgaoSolicitante o
			WHERE o.IdOrgaoSolicitante = CTE.CodigoOrgaoSolicitante
		);
	
	INSERT INTO Viagem (
		IdViagem,
		PeriodoFim,
		PeriodoInicio,
		Destinos,
		Motivo,
		Gastos,
		IdOrgaoSuperior,
		IdOrgaoSolicitante
	)
	SELECT 
		tp.IdentificadorDoprocessoDeViagem,
		tp.Periodo_DataDeFim,
		tp.Periodo_DataDeInicio,
		tp.Destinos,
		tp.Motivo,
		tp.ValorDiarias + tp.ValorPassagens + tp.ValorOutrosGastos,
		NULLIF(tp.CodigoDoOrgaoSuperior, 0),
		NULLIF(tp.CodigoOrgaoSolicitante, 0)
	
		FROM ##temp_viajens_convertido_tb tp
END;
GO

CREATE PROCEDURE SP_ETL_VIAGEM
@CAMINHO_CSV VARCHAR(150)
AS
BEGIN
EXEC SP_EXTRAI_VIAGEM @CAMINHO = @CAMINHO_CSV
EXEC SP_TRATA_VIAGEM
EXEC SP_CARREGA_VIAGEM
IF OBJECT_ID('tempdb..##temp_viajens_convertido_tb') IS NOT NULL
DROP TABLE ##temp_viajens_convertido_tb;
IF OBJECT_ID('tempdb..##temp_viagem_csv_tb') IS NOT NULL
DROP TABLE ##temp_viagem_csv_tb;
END;
GO

CREATE PROCEDURE SP_EXTRAI_PASSAGEM
@CAMINHO VARCHAR(150)
AS
BEGIN
	IF OBJECT_ID('tempdb..##tb_passagem_csv_tb') IS NOT NULL
	DROP TABLE ##tb_passagem_csv_tb

	CREATE TABLE ##tb_passagem_csv_tb(
	
		IdentificadorDoProcessoDeViagem VARCHAR(MAX),
		NúmeroDaPropostaPCDP VARCHAR(MAX),
		MeioDeTransporte VARCHAR(MAX),
		PaísOrigemIda VARCHAR(MAX),
		UFOrigemIda VARCHAR(MAX),
		CidadeOrigemIda VARCHAR(MAX),
		PaísDestinoIda VARCHAR(MAX),
		UFDestinoIda VARCHAR(MAX),
		CidadeDestinoIda VARCHAR(MAX),
		PaísOrigemVolta VARCHAR(MAX),
		UFOrigemVolta VARCHAR(MAX),
		CidadeOrigemVolta VARCHAR(MAX),
		PaisDestinoVolta VARCHAR(MAX),
		UFDestinoVolta VARCHAR(MAX),
		CidadeDestinoVolta VARCHAR(MAX),
		ValorDaPassagem VARCHAR(MAX),
		TaxaDeServiço VARCHAR(MAX),
		DatadaEmissão VARCHAR(MAX),
		HoradaEmissão VARCHAR(MAX),
	);
	
	DECLARE @sql NVARCHAR(MAX);
	    SET @sql = N'
	    BULK INSERT ##tb_passagem_csv_tb
	    FROM ''' + @CAMINHO + N'''
	    WITH (
	        FIELDTERMINATOR = '';'' ,
	        ROWTERMINATOR = ''\n'',
	        FIRSTROW = 2,
	        CODEPAGE = ''1252''
	    );';

    EXEC sp_executesql @sql;
END
GO

CREATE PROCEDURE SP_TRATA_PASSAGEM
AS
BEGIN
	ALTER TABLE ##tb_passagem_csv_tb
	DROP COLUMN NúmeroDaPropostaPCDP, CidadeOrigemIda, CidadeDestinoIda, PaísOrigemVolta, UFOrigemVolta,
				CidadeOrigemVolta, PaisDestinoVolta, UFDestinoVolta, CidadeDestinoVolta, DatadaEmissão, HoradaEmissão

	UPDATE ##tb_passagem_csv_tb
		SET 
	    IdentificadorDoProcessoDeViagem = REPLACE(IdentificadorDoprocessoDeViagem, '"', ''),
	    MeioDeTransporte				= REPLACE(MeioDeTransporte, '"', ''),
	    PaísOrigemIda					= REPLACE(PaísOrigemIda, '"', ''),
	    UFOrigemIda				        = REPLACE(UFOrigemIda, '"', ''),
	    PaísDestinoIda					= REPLACE(PaísDestinoIda, '"', ''),
	    UFDestinoIda					= REPLACE(UFDestinoIda, '"', ''),
		ValorDaPassagem					= REPLACE(ValorDaPassagem, '"', ''),
		TaxaDeServiço					= REPLACE(TaxaDeServiço, '"', '');

	IF OBJECT_ID('tempdb..##temp_passagem_convertido_tb') IS NOT NULL
	DROP TABLE ##temp_passagem_convertido_tb

	CREATE TABLE ##temp_passagem_convertido_tb (
		    IdentificadorDoprocessoDeViagem INT,
		    MeioDeTransporte VARCHAR(255),
		    Origem VARCHAR(150),
		    Destino VARCHAR(150),
		    ValorPassagem DECIMAL(18,2),
		    TaxaServico DECIMAL(18,2),
		   );
	
	INSERT INTO ##temp_passagem_convertido_tb 
	SELECT
		CAST(IdentificadorDoprocessoDeViagem AS INT),
		CAST(MeioDeTransporte AS VARCHAR(255)),
		CAST(CONCAT(PaísOrigemIda, '-', UFOrigemIda) AS VARCHAR(255)),
		CAST(CONCAT(PaísDestinoIda, '-', UFDestinoIda) AS VARCHAR(255)),
		CASE WHEN ValorDaPassagem IN ('', '-1') THEN 0 ELSE CAST(REPLACE(ValorDaPassagem, ',', '.') AS DECIMAL(18,2)) END,
		CASE WHEN TaxaDeServiço IN ('', '-1') THEN 0 ELSE CAST(REPLACE(TaxaDeServiço, ',', '.') AS DECIMAL(18,2)) END
	FROM ##tb_passagem_csv_tb
END
GO

CREATE PROCEDURE SP_CARREGA_PASSAGEM
AS
BEGIN
	INSERT INTO Passagem (
		MeioTransporte,
		Origem,
		Destino,
		ValorPassagem,
		TaxaServico,
		IdViagem
	)
	SELECT 
		MeioDeTransporte,
		Origem,
		Destino,
		ValorPassagem,
		TaxaServico,
		IdentificadorDoprocessoDeViagem
	FROM ##temp_passagem_convertido_tb tp
	INNER JOIN Viagem v
	on tp.IdentificadorDoprocessoDeViagem = v.IdViagem
END
GO

CREATE PROCEDURE SP_ETL_PASSAGEM
@CAMINHO_CSV VARCHAR(150)
AS
BEGIN
	EXEC SP_EXTRAI_PASSAGEM @CAMINHO = @CAMINHO_CSV
	EXEC SP_TRATA_PASSAGEM
	EXEC SP_CARREGA_PASSAGEM
	IF OBJECT_ID('tempdb..##temp_viagem_csv_tb') IS NOT NULL
    DROP TABLE ##temp_viagem_csv_tb;
	IF OBJECT_ID('tempdb..##temp_passagem_convertido_tb') IS NOT NULL
	DROP TABLE ##temp_passagem_convertido_tb
END
GO

CREATE PROCEDURE SP_EXTRAI_PAGAMENTO
@CAMINHO VARCHAR(150)
AS
BEGIN
	IF OBJECT_ID('tempdb..##temp_pagamneto_csv_tb') IS NOT NULL
	DROP TABLE ##temp_pagamneto_csv_tb
	CREATE TABLE ##temp_pagamneto_csv_tb (
		IdentificadorDoProcessoDeViagem VARCHAR(MAX),
		NumeroDaPropostaPCDP VARCHAR(MAX),
		CodigodoOrgaoSuperior VARCHAR(MAX),
		NomeDoOrgaoSuperior VARCHAR(MAX),
		CodigoDoOrgaoPagador VARCHAR(MAX),
		NomeDoOrgaoPagador VARCHAR(MAX),
		CodigoDaUnidadeGestoraPagadora VARCHAR(MAX),
		NomeDaUnidadeGestoraPagadora VARCHAR(MAX),
		TipoDePagamento VARCHAR(MAX),
		Valor VARCHAR(MAX)
	)
	
		DECLARE @sql NVARCHAR(MAX);
		    SET @sql = N'
		    BULK INSERT ##temp_pagamneto_csv_tb
		    FROM ''' + @CAMINHO + N'''
		    WITH (
		        FIELDTERMINATOR = '';'' ,
		        ROWTERMINATOR = ''\n'',
		        FIRSTROW = 2,
		        CODEPAGE = ''1252''
		    );';
	
	    EXEC sp_executesql @sql;
END;
GO

CREATE PROCEDURE SP_TRATA_PAGAMENTO
AS
BEGIN
	ALTER TABLE ##temp_pagamneto_csv_tb
	DROP COLUMN NumeroDaPropostaPCDP

	UPDATE ##temp_pagamneto_csv_tb
		SET 
	    IdentificadorDoProcessoDeViagem = REPLACE(IdentificadorDoProcessoDeViagem, '"', ''),
		CodigodoOrgaoSuperior			= REPLACE(CodigodoOrgaoSuperior, '"', ''),
		NomeDoOrgaoSuperior				= REPLACE(NomeDoOrgaoSuperior, '"', ''),
		CodigoDoOrgaoPagador			= REPLACE(CodigoDoOrgaoPagador, '"', ''),
		NomeDoOrgaoPagador				= REPLACE(NomeDoOrgaoPagador, '"', ''),
		CodigoDaUnidadeGestoraPagadora  = REPLACE(CodigoDaUnidadeGestoraPagadora, '"', ''),
		NomeDaUnidadeGestoraPagadora	= REPLACE(NomeDaUnidadeGestoraPagadora, '"', ''),
		TipoDePagamento					= REPLACE(TipoDePagamento, '"', ''),
		Valor							= REPLACE(Valor, '"', '')

	IF OBJECT_ID('tempdb..##temp_pagamento_convertido_tb') IS NOT NULL
	DROP TABLE ##temp_pagamento_convertido_tb

	CREATE TABLE ##temp_pagamento_convertido_tb (
		IdentificadorDoProcessoDeViagem INT,
		CodigodoOrgaoSuperior INT,
		NomeDoOrgaoSuperior VARCHAR(150),
		CodigoDoOrgaoPagador INT,
		NomeDoOrgaoPagador VARCHAR(150),
		CodigoDaUnidadeGestoraPagadora INT,
		NomeDaUnidadeGestoraPagadora VARCHAR(150),
		TipoDePagamento VARCHAR(150),
		Valor DECIMAL(18,2)
		   );

	INSERT INTO ##temp_pagamento_convertido_tb
	SELECT
		CAST(IdentificadorDoprocessoDeViagem AS INT),
		CASE WHEN CodigodoOrgaoSuperior IN ('', '-11', '-1', '-3') THEN 0 ELSE CAST(CodigodoOrgaoSuperior AS INT) END,
		CAST(NomeDoOrgaoSuperior AS VARCHAR(150)),
		CASE WHEN CodigoDoOrgaoPagador IN ('', '-11', '-3', '-1') THEN 0 ELSE CAST(CodigoDoOrgaoPagador AS INT) END,
		CAST(NomeDoOrgaoPagador AS VARCHAR(150)),
		CASE WHEN CodigoDaUnidadeGestoraPagadora IN ('', '-11', '-1', '-3') THEN 0 ELSE CAST(CodigoDaUnidadeGestoraPagadora AS INT) END,
		CAST(NomeDaUnidadeGestoraPagadora AS VARCHAR(150)),
		CAST(TipoDePagamento AS VARCHAR(150)),
		CASE WHEN Valor IN ('', '-1') THEN 0 ELSE CAST(REPLACE(Valor, ',', '.') AS DECIMAL(18,2)) END
	FROM ##temp_pagamneto_csv_tb
END;
GO


CREATE PROCEDURE SP_CARREGA_PAGAMENTO
AS
BEGIN

	WITH CTE AS (
		SELECT
			CodigodoOrgaoSuperior,
			NomeDoOrgaoSuperior,
			ROW_NUMBER() OVER(PARTITION BY CodigodoOrgaoSuperior ORDER BY CodigodoOrgaoSuperior) as rn
			FROM ##temp_pagamento_convertido_tb
			WHERE CodigodoOrgaoSuperior <> 0
		)
		INSERT INTO OrgaoSuperior (IdOrgaoSuperior, NomeOrgaoSuperior)
		SELECT
			CodigodoOrgaoSuperior,
			NomeDoOrgaoSuperior
		FROM CTE
		WHERE CTE.rn = 1 
		AND NOT EXISTS (
			SELECT 1 FROM OrgaoSuperior o
		    WHERE o.IdOrgaoSuperior = CTE.CodigodoOrgaoSuperior
			);
	
	WITH CTE AS (
		SELECT
			CodigoDoOrgaoPagador,
			NomeDoOrgaoPagador,
			ROW_NUMBER() OVER(PARTITION BY CodigoDoOrgaoPagador ORDER BY CodigoDoOrgaoPagador) as rn
			FROM ##temp_pagamento_convertido_tb
			WHERE CodigoDoOrgaoPagador <> 0
		)
		INSERT INTO OrgaoPagador(IdOrgaoPagador, NomeOrgaoPagador)
		SELECT
			CodigoDoOrgaoPagador,
			NomeDoOrgaoPagador
		FROM CTE
		WHERE CTE.rn = 1 
		AND NOT EXISTS (
			SELECT 1 FROM OrgaoPagador o
		    WHERE o.IdOrgaoPagador = CTE.CodigoDoOrgaoPagador
			);
	
	
	WITH CTE AS (
		SELECT
			CodigoDaUnidadeGestoraPagadora,
			NomeDaUnidadeGestoraPagadora,
			ROW_NUMBER() OVER(PARTITION BY CodigoDaUnidadeGestoraPagadora ORDER BY CodigoDaUnidadeGestoraPagadora) as rn
			FROM ##temp_pagamento_convertido_tb
			WHERE CodigoDaUnidadeGestoraPagadora <> 0
		)
		INSERT INTO UnidadeGestoraPagadora (IdUnidadeGestoraPagadora, NomeUnidadeGestoraPagadora)
		SELECT
			CodigoDaUnidadeGestoraPagadora,
			NomeDaUnidadeGestoraPagadora
		FROM CTE
		WHERE CTE.rn = 1 
		AND NOT EXISTS (
			SELECT 1 FROM UnidadeGestoraPagadora u
		    WHERE u.IdUnidadeGestoraPagadora = CTE.CodigoDaUnidadeGestoraPagadora
			);
	
	INSERT INTO Pagamento (
		TipodePagamento,
	    ValordaDespeza,
	    IdOrgaoSuperior,
	    IdUnidadeGestoraPagadora,
	    IdViagem,
	    IdOrgaoPagador)
		SELECT
			TipoDePagamento,
			Valor,
			NULLIF(CodigodoOrgaoSuperior,0),
			NULLIF(CodigoDaUnidadeGestoraPagadora,0),
			IdentificadorDoprocessoDeViagem,
			NULLIF(CodigoDoOrgaoPagador,0)
		FROM ##temp_pagamento_convertido_tb tp
		INNER JOIN Viagem v
		on tp.IdentificadorDoProcessoDeViagem = v.IdViagem
END;
GO


CREATE PROCEDURE SP_ETL_PAGAMENTO
@CAMINHO_CSV VARCHAR(150)
AS
BEGIN
	EXEC SP_EXTRAI_PAGAMENTO @CAMINHO = @CAMINHO_CSV
	EXEC SP_TRATA_PAGAMENTO
	EXEC SP_CARREGA_PAGAMENTO
	IF OBJECT_ID('tempdb..##temp_pagamneto_csv_tb') IS NOT NULL
	DROP TABLE ##temp_pagamneto_csv_tb
	IF OBJECT_ID('tempdb..##temp_pagamento_convertido_tb') IS NOT NULL
	DROP TABLE ##temp_pagamento_convertido_tb
END;
GO
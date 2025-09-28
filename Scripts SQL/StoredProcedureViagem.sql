USE ProjetoGastosGovernamentais
GO

CREATE PROCEDURE SP_EXTRAI_VIAGEM --Criação da Sored Procedure que extrai os dados do csv despesas
@CAMINHO VARCHAR(150)   --Caminho do csv que a SP irá receber para execultar o bulk insert
AS
BEGIN
	IF OBJECT_ID('tempdb..##temp_viagem_csv_tb') IS NOT NULL  --Verificação se a tabela temporaria já existe, caso exista ela é apagada
    DROP TABLE ##temp_viagem_csv_tb;

	CREATE TABLE ##temp_viagem_csv_tb (                 -- Criação da tabela temporaria que irá receber todos os dados do csv viagem, com os campos todos em VARCHAR(MAX), que serão tratados e convertidos para seu tipo ideal posteriormente
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
	
DECLARE @sql NVARCHAR(MAX);   --Criação de uma variavél temporaria para armazernar a instrução BULK INSERT (Isso está sendo utilizado para que essa intrução aceite o @CAMINHO)
    SET @sql = N'
    BULK INSERT ##temp_viagem_csv_tb
    FROM ''' + @CAMINHO + N'''
    WITH (
        FIELDTERMINATOR = '';'' ,
        ROWTERMINATOR = ''0x0A'',
        FIRSTROW = 2,
        CODEPAGE = ''1252''
    );';							--Instrução para realização do BULK INSERT

    EXEC sp_executesql @sql;     --Execução do que foi armazenado (sp_executesql é um procedimento de sistema para a execução de um comando SQL através de uma string de texto)

END;
GO


CREATE PROCEDURE SP_TRATA_VIAGEM     --Procedure responsável por tratar os valores extraidos
AS
BEGIN

	ALTER TABLE ##temp_viagem_csv_tb		--Deleta tabelas que são desnecessárias
	DROP COLUMN NumeroDaProposta_PCDP, Situacao, ViagemUrgente, JustificativaUrgenciaViagem, Nome, Funcao, DescricaoFuncao, CPFviajante, Cargo
	
	UPDATE ##temp_viagem_csv_tb						--Como todos os dados vem com '"' no inicio e no fim, essa parte é responsável por removê-los
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
	
	DELETE																		--Alguns de valor estavam vindo com informações de outras colunas, então aqui nós identificamos eles e apagamos
	FROM ##temp_viagem_csv_tb
	WHERE TRY_CAST(REPLACE(ValorDiarias, ',', '.') AS DECIMAL(18,2)) IS NULL 
	or TRY_CAST(REPLACE(ValorPassagens, ',', '.') AS DECIMAL(18,2)) IS NULL
	OR TRY_CAST(REPLACE(ValorOutrosGastos, ',', '.') AS DECIMAL(18,2)) IS NULL
	AND ValorDiarias NOT IN ('', '-1')
	and ValorPassagens NOT IN ('', '-1')
	AND ValorOutrosGastos NOT IN ('', '-1')
	
	
	DELETE												--Deleta dados que não possuem id
	FROM ##temp_viagem_csv_tb
	WHERE IdentificadorDoprocessoDeViagem IN ('', '-1')

	IF OBJECT_ID('tempdb..##temp_viajens_convertido_tb') IS NOT NULL DROP TABLE ##temp_viajens_convertido_tb;		--Verificação se a tabela temporaria já existe, caso exista ela é apagada

	CREATE TABLE ##temp_viajens_convertido_tb (		--Criação de uma tabela que irá receber os valores que serão convertidos para seu tipo ideal, para depois serem distribuidos para suas respectivas tabelas
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
	
	
	
	INSERT INTO ##temp_viajens_convertido_tb			--Casting dos dados
	SELECT
		CAST(IdentificadorDoprocessoDeViagem AS INT),
		CASE WHEN CodigoDoOrgaoSuperior IN ('','-1') THEN 0 ELSE CAST(CodigoDoOrgaoSuperior AS INT) END,  --A partir daqui todos os dados que forem inteiros ocorrerá uma verificação que caso esteja como '' ou '-1', sejam substituido para '0', antes de sua conversão
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
		CASE WHEN ValorDiarias IN ('','-1') THEN 0 ELSE CAST(REPLACE(ValorDiarias,',','.') AS DECIMAL(18,2)) END,	--Todos os decimal a partir daqui serão verificados o mesmo caso dos inteiros, e eles serão converter a ',' para '.', que é o padrão usado no SQL SERVER
		CASE WHEN ValorPassagens IN ('','-1') THEN 0 ELSE CAST(REPLACE(ValorPassagens,',','.') AS DECIMAL(18,2)) END,
		CASE WHEN ValorDevolucao IN ('','-1') THEN 0 ELSE CAST(REPLACE(ValorDevolucao,',','.') AS DECIMAL(18,2)) END,
		CASE WHEN ValorOutrosGastos IN ('','-1') THEN 0 ELSE CAST(REPLACE(ValorOutrosGastos,',','.') AS DECIMAL(18,2)) END
	
	FROM ##temp_viagem_csv_tb
END;
GO

CREATE PROCEDURE SP_CARREGA_VIAGEM		--Stored Procedure responsável por carregar os dados tratados para sua respectiva tabela
AS
BEGIN
	WITH CTE AS (				--Criação de uma CTE para selecionar os dados necessários, e principalmente para a criação de um ROW_NUMBER que será usado para diferenciar os dados iguais dentro da tabela temporaria
	    SELECT 
	        CodigoDoOrgaoSuperior,
	        NomeDoOrgaoSuperior,
	        ROW_NUMBER() OVER(PARTITION BY CodigoDoOrgaoSuperior ORDER BY CodigoDoOrgaoSuperior) AS rn  --Aqui estamos criando uma sequência contendo os valores repitidos da tabela. Para que em seu preenchimento não haja duplicatas de uma PK
	    FROM ##temp_viajens_convertido_tb
	    WHERE CodigoDoOrgaoSuperior <> 0																--Estamos excluindo os que contém '0' da consulta, porque são valores invalidos
	)
	INSERT INTO OrgaoSuperior (IdOrgaoSuperior, NomeOrgaoSuperior)  --Preenchimento da tabela OrgaoSuperior
	SELECT CodigoDoOrgaoSuperior, NomeDoOrgaoSuperior
	FROM CTE
	WHERE rn = 1									--Pegando apenas os primeiros da sequencia criada anteriormente para evitar duplicadas
	  AND NOT EXISTS (								--Verificando se o valor já existe na tabela principal
	      SELECT 1 FROM OrgaoSuperior o
	      WHERE o.IdOrgaoSuperior = CTE.CodigoDoOrgaoSuperior
	  );
	
	
	WITH CTE AS (				--Criação de uma CTE para selecionar os dados necessários, e principalmente para a criação de um ROW_NUMBER que será usado para diferenciar os dados iguais dentro da tabela temporaria
		SELECT
			CodigoOrgaoSolicitante,
			NomeOrgaoSolicitante,
			ROW_NUMBER() OVER (PARTITION BY CodigoOrgaoSolicitante ORDER BY CodigoOrgaoSolicitante) AS rn  --Aqui estamos criando uma sequência contendo os valores repitidos da tabela. Para que em seu preenchimento não haja duplicatas de uma PK
		FROM ##temp_viajens_convertido_tb
		WHERE CodigoOrgaoSolicitante <> 0																--Estamos excluindo os que contém '0' da consulta, porque são valores invalidos
	)
	INSERT INTO OrgaoSolicitante (IdOrgaoSolicitante, NomeOrgaoSolicitante)  --Preenchimento da tabela OrgaoSolicitante
	SELECT CodigoOrgaoSolicitante, NomeOrgaoSolicitante
	FROM CTE
	WHERE rn = 1									--Pegando apenas os primeiros da sequencia criada anteriormente para evitar duplicadas
		AND NOT EXISTS (								--Verificando se o valor já existe na tabela principal
			SELECT 1 FROM OrgaoSolicitante o
			WHERE o.IdOrgaoSolicitante = CTE.CodigoOrgaoSolicitante
		);


WITH CTE AS (				--Criação de uma CTE para selecionar os dados necessários, e principalmente para a criação de um ROW_NUMBER que será usado para diferenciar os dados iguais dentro da tabela temporaria
		SELECT
		tp.IdentificadorDoprocessoDeViagem,
		tp.Periodo_DataDeFim,
		tp.Periodo_DataDeInicio,
		tp.Destinos,
		tp.Motivo,
		tp.ValorDiarias,
		tp.ValorPassagens,
		tp.ValorOutrosGastos,
		tp.CodigoDoOrgaoSuperior,		--caso esteja como '0', coloca NULL
		tp.CodigoOrgaoSolicitante,		--caso esteja como '0', coloca NULL
		ROW_NUMBER() OVER (PARTITION BY IdentificadorDoprocessoDeViagem ORDER BY IdentificadorDoprocessoDeViagem) AS rn  --Aqui estamos criando uma sequência contendo os valores repitidos da tabela. Para que em seu preenchimento não haja duplicatas de uma PK
		FROM ##temp_viajens_convertido_tb tp																--Estamos excluindo os que contém '0' da consulta, porque são valores invalidos
	)
	INSERT INTO Viagem (		--Preenchimento da tabela de Viagem
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
		CTE.IdentificadorDoprocessoDeViagem,
		CTE.Periodo_DataDeFim,
		CTE.Periodo_DataDeInicio,
		CTE.Destinos,
		CTE.Motivo,
		CTE.ValorDiarias + CTE.ValorPassagens + CTE.ValorOutrosGastos,
		NULLIF(CTE.CodigoDoOrgaoSuperior, 0),		--caso esteja como '0', coloca NULL
		NULLIF(CTE.CodigoOrgaoSolicitante, 0)		--caso esteja como '0', coloca NULL
		FROM CTE
		WHERE  CTE.rn = 1 AND NOT EXISTS (SELECT 1 FROM Viagem v WHERE v.IdViagem = CTE.IdentificadorDoprocessoDeViagem)
END;
GO

CREATE PROCEDURE SP_ETL_VIAGEM			--Stored Procedure que executa as SP de ETL Viagem
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

CREATE PROCEDURE SP_EXTRAI_PASSAGEM			 --Criação da Sored Procedure que extrai os dados do csv passagem
@CAMINHO VARCHAR(150)
AS
BEGIN
	IF OBJECT_ID('tempdb..##tb_passagem_csv_tb') IS NOT NULL  --Verificação se a tabela temporaria já existe, caso exista ela é apagada
	DROP TABLE ##tb_passagem_csv_tb

	CREATE TABLE ##tb_passagem_csv_tb(                 -- Criação da tabela temporaria que irá receber todos os dados do csv despesas, com os campos todos em VARCHAR(MAX), que serão tratados e convertidos para seu tipo ideal posteriormente
	
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
	
	DECLARE @sql NVARCHAR(MAX);   --Criação de uma variavél temporaria para armazernar a instrução BULK INSERT (Isso está sendo utilizado para que essa intrução aceite o @CAMINHO)
	    SET @sql = N'
	    BULK INSERT ##tb_passagem_csv_tb
	    FROM ''' + @CAMINHO + N'''
	    WITH (
	        FIELDTERMINATOR = '';'' ,
	        ROWTERMINATOR = ''0x0A'',
	        FIRSTROW = 2,
	        CODEPAGE = ''1252''
	    );';							--Instrução para realização do BULK INSERT

    EXEC sp_executesql @sql;     --Execução do que foi armazenado (sp_executesql é um procedimento de sistema para a execução de um comando SQL através de uma string de texto)
END
GO

CREATE PROCEDURE SP_TRATA_PASSAGEM      --Procedure responsável por tratar os valores extraidos
AS
BEGIN
	ALTER TABLE ##tb_passagem_csv_tb		--Deleta tabelas que são desnecessárias
	DROP COLUMN NúmeroDaPropostaPCDP, CidadeOrigemIda, CidadeDestinoIda, PaísOrigemVolta, UFOrigemVolta,
				CidadeOrigemVolta, PaisDestinoVolta, UFDestinoVolta, CidadeDestinoVolta, DatadaEmissão, HoradaEmissão

	UPDATE ##tb_passagem_csv_tb						--Como todos os dados vem com '"' no inicio e no fim, essa parte é responsável por removê-los
		SET 
	    IdentificadorDoProcessoDeViagem = REPLACE(IdentificadorDoprocessoDeViagem, '"', ''),
	    MeioDeTransporte				= REPLACE(MeioDeTransporte, '"', ''),
	    PaísOrigemIda					= REPLACE(PaísOrigemIda, '"', ''),
	    UFOrigemIda				        = REPLACE(UFOrigemIda, '"', ''),
	    PaísDestinoIda					= REPLACE(PaísDestinoIda, '"', ''),
	    UFDestinoIda					= REPLACE(UFDestinoIda, '"', ''),
		ValorDaPassagem					= REPLACE(ValorDaPassagem, '"', ''),
		TaxaDeServiço					= REPLACE(TaxaDeServiço, '"', '');

	IF OBJECT_ID('tempdb..##temp_passagem_convertido_tb') IS NOT NULL		--Verificação se a tabela temporaria já existe, caso exista ela é apagada
	DROP TABLE ##temp_passagem_convertido_tb

	CREATE TABLE ##temp_passagem_convertido_tb (		--Criação de uma tabela que irá receber os valores que serão convertidos para seu tipo ideal, para depois serem distribuidos para suas respectivas tabelas
		    IdentificadorDoprocessoDeViagem INT,
		    MeioDeTransporte VARCHAR(255),
		    Origem VARCHAR(150),
		    Destino VARCHAR(150),
		    ValorPassagem DECIMAL(18,2),
		    TaxaServico DECIMAL(18,2),
		   );
	
	INSERT INTO ##temp_passagem_convertido_tb 			--Casting dos dados
	SELECT
		CAST(IdentificadorDoprocessoDeViagem AS INT),
		CAST(MeioDeTransporte AS VARCHAR(255)),
		CAST(CONCAT(PaísOrigemIda, '-', UFOrigemIda) AS VARCHAR(255)),
		CAST(CONCAT(PaísDestinoIda, '-', UFDestinoIda) AS VARCHAR(255)),
		CASE WHEN ValorDaPassagem IN ('', '-1') THEN 0 ELSE CAST(REPLACE(ValorDaPassagem, ',', '.') AS DECIMAL(18,2)) END,	--Todos os decimal a partir daqui serão verificados para valores como '' e '-1', e eles serão converter a ',' para '.', que é o padrão usado no SQL SERVER
		CASE WHEN TaxaDeServiço IN ('', '-1') THEN 0 ELSE CAST(REPLACE(TaxaDeServiço, ',', '.') AS DECIMAL(18,2)) END
	FROM ##tb_passagem_csv_tb
END
GO

CREATE PROCEDURE SP_CARREGA_PASSAGEM		--Stored Procedure responsável por carregar os dados tratados para sua respectiva tabela
AS
BEGIN
	INSERT INTO Passagem (				--Preenchimento da tabela despesas
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
	INNER JOIN Viagem v			--JOIIN para garantir que todas as passagens tenham um Idviagem 
	on tp.IdentificadorDoprocessoDeViagem = v.IdViagem
END
GO

CREATE PROCEDURE SP_ETL_PASSAGEM			--Stored Procedure que executa as SP de ETL passagem
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

CREATE PROCEDURE SP_EXTRAI_PAGAMENTO --Criação da Sored Procedure que extrai os dados do csv pagamento
@CAMINHO VARCHAR(150)   --Caminho do csv que a SP irá receber para execultar o bulk insert
AS
BEGIN
	IF OBJECT_ID('tempdb..##temp_pagamneto_csv_tb') IS NOT NULL  --Verificação se a tabela temporaria já existe, caso exista ela é apagada
	DROP TABLE ##temp_pagamneto_csv_tb
	CREATE TABLE ##temp_pagamneto_csv_tb (                 -- Criação da tabela temporaria que irá receber todos os dados do csv despesas, com os campos todos em VARCHAR(MAX), que serão tratados e convertidos para seu tipo ideal posteriormente
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
	
		DECLARE @sql NVARCHAR(MAX);   --Criação de uma variavél temporaria para armazernar a instrução BULK INSERT (Isso está sendo utilizado para que essa intrução aceite o @CAMINHO)
		    SET @sql = N'
		    BULK INSERT ##temp_pagamneto_csv_tb
		    FROM ''' + @CAMINHO + N'''
		    WITH (
		        FIELDTERMINATOR = '';'' ,
		        ROWTERMINATOR = ''0x0A'',
		        FIRSTROW = 2,
		        CODEPAGE = ''1252''
		    );';							--Instrução para realização do BULK INSERT
	
	    EXEC sp_executesql @sql;     --Execução do que foi armazenado (sp_executesql é um procedimento de sistema para a execução de um comando SQL através de uma string de texto)
END;
GO

CREATE PROCEDURE SP_TRATA_PAGAMENTO      --Procedure responsável por tratar os valores extraidos
AS
BEGIN
	ALTER TABLE ##temp_pagamneto_csv_tb		--Deleta tabelas que são desnecessárias
	DROP COLUMN NumeroDaPropostaPCDP

	UPDATE ##temp_pagamneto_csv_tb						--Como todos os dados vem com '"' no inicio e no fim, essa parte é responsável por removê-los
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

	IF OBJECT_ID('tempdb..##temp_pagamento_convertido_tb') IS NOT NULL		--Verificação se a tabela temporaria já existe, caso exista ela é apagada
	DROP TABLE ##temp_pagamento_convertido_tb

	CREATE TABLE ##temp_pagamento_convertido_tb (		--Criação de uma tabela que irá receber os valores que serão convertidos para seu tipo ideal, para depois serem distribuidos para suas respectivas tabelas
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

	INSERT INTO ##temp_pagamento_convertido_tb			--Casting dos dados
	SELECT
		CAST(IdentificadorDoprocessoDeViagem AS INT),
		CASE WHEN CodigodoOrgaoSuperior IN ('', '-11', '-1', '-3') THEN 0 ELSE CAST(CodigodoOrgaoSuperior AS INT) END, --A partir daqui todos os dados que forem inteiros ocorrerá uma verificação que caso esteja como '', '-3' ou '-1', sejam substituido para '0', antes de sua conversão
		CAST(NomeDoOrgaoSuperior AS VARCHAR(150)),
		CASE WHEN CodigoDoOrgaoPagador IN ('', '-11', '-3', '-1') THEN 0 ELSE CAST(CodigoDoOrgaoPagador AS INT) END,
		CAST(NomeDoOrgaoPagador AS VARCHAR(150)),
		CASE WHEN CodigoDaUnidadeGestoraPagadora IN ('', '-11', '-1', '-3') THEN 0 ELSE CAST(CodigoDaUnidadeGestoraPagadora AS INT) END,
		CAST(NomeDaUnidadeGestoraPagadora AS VARCHAR(150)),
		CAST(TipoDePagamento AS VARCHAR(150)),
		CASE WHEN Valor IN ('', '-1') THEN 0 ELSE CAST(REPLACE(Valor, ',', '.') AS DECIMAL(18,2)) END	--Todos os decimal a partir daqui serão verificados o mesmo caso dos inteiros, e eles serão converter a ',' para '.', que é o padrão usado no SQL SERVER
	FROM ##temp_pagamneto_csv_tb
END;
GO


CREATE PROCEDURE SP_CARREGA_PAGAMENTO		--Stored Procedure responsável por carregar os dados tratados para sua respectiva tabela
AS
BEGIN

	WITH CTE AS (				--Criação de uma CTE para selecionar os dados necessários, e principalmente para a criação de um ROW_NUMBER que será usado para diferenciar os dados iguais dentro da tabela temporaria
		SELECT
			CodigodoOrgaoSuperior,
			NomeDoOrgaoSuperior,
			ROW_NUMBER() OVER(PARTITION BY CodigodoOrgaoSuperior ORDER BY CodigodoOrgaoSuperior) as rn  --Aqui estamos criando uma sequência contendo os valores repitidos da tabela. Para que em seu preenchimento não haja duplicatas de uma PK
			FROM ##temp_pagamento_convertido_tb
			WHERE CodigodoOrgaoSuperior <> 0															--Estamos excluindo os que contém '0' da consulta, porque são valores invalidos
		)
		INSERT INTO OrgaoSuperior (IdOrgaoSuperior, NomeOrgaoSuperior)				--Preenchimento da tabela OrgaoSuperior
		SELECT
			CodigodoOrgaoSuperior,
			NomeDoOrgaoSuperior
		FROM CTE
		WHERE CTE.rn = 1 									--Pegando apenas os primeiros da sequencia criada anteriormente para evitar duplicadas
		AND NOT EXISTS (									--Verificando se o valor já existe na tabela principal
			SELECT 1 FROM OrgaoSuperior o
		    WHERE o.IdOrgaoSuperior = CTE.CodigodoOrgaoSuperior
			);
	
	WITH CTE AS (				--Criação de uma CTE para selecionar os dados necessários, e principalmente para a criação de um ROW_NUMBER que será usado para diferenciar os dados iguais dentro da tabela temporaria
		SELECT
			CodigoDoOrgaoPagador,
			NomeDoOrgaoPagador,
			ROW_NUMBER() OVER(PARTITION BY CodigoDoOrgaoPagador ORDER BY CodigoDoOrgaoPagador) as rn  --Aqui estamos criando uma sequência contendo os valores repitidos da tabela. Para que em seu preenchimento não haja duplicatas de uma PK
			FROM ##temp_pagamento_convertido_tb
			WHERE CodigoDoOrgaoPagador <> 0															--Estamos excluindo os que contém '0' da consulta, porque são valores invalidos
		)
		INSERT INTO OrgaoPagador(IdOrgaoPagador, NomeOrgaoPagador)				--Preenchimento da tabela OrgaoPagador
		SELECT
			CodigoDoOrgaoPagador,
			NomeDoOrgaoPagador
		FROM CTE
		WHERE CTE.rn = 1  									--Pegando apenas os primeiros da sequencia criada anteriormente para evitar duplicadas
		AND NOT EXISTS (									--Verificando se o valor já existe na tabela principal
			SELECT 1 FROM OrgaoPagador o
		    WHERE o.IdOrgaoPagador = CTE.CodigoDoOrgaoPagador
			);
	
	
	WITH CTE AS (				--Criação de uma CTE para selecionar os dados necessários, e principalmente para a criação de um ROW_NUMBER que será usado para diferenciar os dados iguais dentro da tabela temporaria
		SELECT
			CodigoDaUnidadeGestoraPagadora,
			NomeDaUnidadeGestoraPagadora,
			ROW_NUMBER() OVER(PARTITION BY CodigoDaUnidadeGestoraPagadora ORDER BY CodigoDaUnidadeGestoraPagadora) as rn  --Aqui estamos criando uma sequência contendo os valores repitidos da tabela. Para que em seu preenchimento não haja duplicatas de uma PK
			FROM ##temp_pagamento_convertido_tb
			WHERE CodigoDaUnidadeGestoraPagadora <> 0															--Estamos excluindo os que contém '0' da consulta, porque são valores invalidos
		)
		INSERT INTO UnidadeGestoraPagadora (IdUnidadeGestoraPagadora, NomeUnidadeGestoraPagadora)				--Preenchimento da tabela UnidadeGestoraPagadora
		SELECT
			CodigoDaUnidadeGestoraPagadora,
			NomeDaUnidadeGestoraPagadora
		FROM CTE
		WHERE CTE.rn = 1  									--Pegando apenas os primeiros da sequencia criada anteriormente para evitar duplicadas
		AND NOT EXISTS (									--Verificando se o valor já existe na tabela principal
			SELECT 1 FROM UnidadeGestoraPagadora u
		    WHERE u.IdUnidadeGestoraPagadora = CTE.CodigoDaUnidadeGestoraPagadora
			);
	
	INSERT INTO Pagamento (				--Preenchimento da tabela pagamento
		TipodePagamento,
	    ValordaDespeza,
	    IdOrgaoSuperior,
	    IdUnidadeGestoraPagadora,
	    IdViagem,
	    IdOrgaoPagador)
		SELECT
			TipoDePagamento,
			Valor,
			NULLIF(CodigodoOrgaoSuperior,0),				--caso esteja como '0', coloca NULL
			NULLIF(CodigoDaUnidadeGestoraPagadora,0),		--caso esteja como '0', coloca NULL
			IdentificadorDoprocessoDeViagem,
			NULLIF(CodigoDoOrgaoPagador,0)					--caso esteja como '0', coloca NULL
		FROM ##temp_pagamento_convertido_tb tp
		INNER JOIN Viagem v									--JOIIN para garantir que todas as passagens tenham um Idviagem 
		on tp.IdentificadorDoProcessoDeViagem = v.IdViagem
END;
GO


CREATE PROCEDURE SP_ETL_PAGAMENTO			--Stored Procedure que executa as SP de ETL pagamento
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
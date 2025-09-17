USE ProjetoGastosGovernamentais
GO

CREATE PROCEDURE SP_EXTRAI_CSV_DESPESAS
@CAMINHO VARCHAR(150)
AS
BEGIN
	CREATE TABLE ##temp_depesas(
		AnoMesLancamento VARCHAR(MAX),
		CodigoOrgaoSuperior VARCHAR(MAX),
		NomeOrgaoSuperior VARCHAR (MAX),
		CodigoOrgaoSubordinado VARCHAR(MAX),
		NomeOrgaoSubordinado VARCHAR (MAX),
		CodigoUnidadeGestora VARCHAR(MAX),
		NomeUnidadeGestora VARCHAR (MAX),
		CodigoGestao VARCHAR(MAX),
		NomeGestao VARCHAR(MAX),
		CodigoUnidadeOrcamentaria VARCHAR(MAX),
		NomeUnidadeOrcamentaria VARCHAR (MAX),
		CodigoFuncao VARCHAR(MAX),
		NomeFuncao VARCHAR(MAX),
		CodigoSubfuncao VARCHAR(MAX),
		NomeSubfuncao VARCHAR(MAX),
		CodigoProgramaOrcamentario VARCHAR(MAX),
		NomeProgramaOrcamentario VARCHAR(MAX),
		CodigoAcao VARCHAR(MAX),
		NomeAcao VARCHAR(MAX),
		CodigoPlanoOrcamentario VARCHAR(MAX),
		PlanoOrcamentario VARCHAR(MAX),
		CodigoProgramaGoverno VARCHAR(MAX),
		NomeProgramaGoverno VARCHAR (MAX),
		Uf VARCHAR(MAX),
		Municipio VARCHAR(MAX),
		CodigoSubtitulo VARCHAR(MAX),
		NomeSubtitulo VARCHAR(MAX),
		CodigoLocalizador VARCHAR(MAX),
		NomeLocalizador VARCHAR(MAX),
		SiglaLocalizador VARCHAR(MAX),
		DescricaoComplementarLocalizador VARCHAR(MAX),
		CodigoAutorEmenda VARCHAR(MAX),
		NomeAutorEmenda VARCHAR(MAX),
		CodigoCategoriaEconomica VARCHAR(MAX),
		NomeCategoriaEconomica VARCHAR(MAX),
		CodigoGrupoDespesa VARCHAR(MAX),
		NomeGrupoDespesa VARCHAR(MAX),
		CodigoElementoDespesa VARCHAR(MAX),
		NomeElementoDespesa VARCHAR(MAX),
		CodigoModalidadeDespesa VARCHAR(MAX),
		ModalidadeDespesa VARCHAR(MAX),
		ValorEmpenhado VARCHAR(MAX),
		ValorLiquidado VARCHAR(MAX),
		ValorPago VARCHAR(MAX),
		ValorRestosPagarInscritos VARCHAR(MAX),
		ValorRestosPagarCancelado VARCHAR(MAX),
		ValorRestosPagarPagos VARCHAR(MAX)
	);
	
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = N'
    BULK INSERT ##temp_depesas
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

CREATE PROCEDURE SP_TRATA_CSV_DESPESAS
AS
BEGIN
UPDATE ##temp_depesas
SET 
		AnoMesLancamento = REPLACE(AnoMesLancamento, '"',''),
		CodigoOrgaoSuperior = REPLACE(CodigoOrgaoSuperior, '"',''),
		NomeOrgaoSuperior = REPLACE(NomeOrgaoSuperior, '"',''),
		CodigoOrgaoSubordinado = REPLACE(CodigoOrgaoSubordinado, '"',''),
		NomeOrgaoSubordinado = REPLACE(NomeOrgaoSubordinado, '"',''),
		CodigoUnidadeGestora = REPLACE(CodigoUnidadeGestora, '"',''),
		NomeUnidadeGestora = REPLACE(NomeUnidadeGestora, '"',''),
		CodigoGestao = REPLACE(CodigoGestao, '"',''),
		NomeGestao = REPLACE(NomeGestao, '"',''),
		CodigoUnidadeOrcamentaria = REPLACE(CodigoUnidadeOrcamentaria, '"',''),
		NomeUnidadeOrcamentaria = REPLACE(NomeUnidadeOrcamentaria, '"',''),
		CodigoFuncao = REPLACE(CodigoFuncao, '"',''),
		NomeFuncao = REPLACE(NomeFuncao, '"',''),
		CodigoSubfuncao = REPLACE(CodigoSubfuncao, '"',''),
		NomeSubfuncao = REPLACE(NomeSubfuncao, '"',''),
		CodigoProgramaOrcamentario = REPLACE(CodigoProgramaOrcamentario, '"',''),
		NomeProgramaOrcamentario = REPLACE(NomeProgramaOrcamentario, '"',''),
		CodigoAcao = REPLACE(CodigoAcao, '"',''),
		NomeAcao = REPLACE(NomeAcao, '"',''),
		CodigoPlanoOrcamentario = REPLACE(CodigoPlanoOrcamentario, '"',''),
		PlanoOrcamentario = REPLACE(PlanoOrcamentario, '"',''),
		CodigoProgramaGoverno = REPLACE(CodigoProgramaGoverno, '"',''),
		NomeProgramaGoverno = REPLACE(NomeProgramaGoverno, '"',''),
		Uf = REPLACE(Uf, '"',''),
		Municipio = REPLACE(Municipio, '"',''),
		CodigoSubtitulo = REPLACE(CodigoSubtitulo, '"',''),
		NomeSubtitulo = REPLACE(NomeSubtitulo, '"',''),
		CodigoLocalizador = REPLACE(CodigoLocalizador, '"',''),
		NomeLocalizador = REPLACE(NomeLocalizador, '"',''),
		SiglaLocalizador = REPLACE(SiglaLocalizador, '"',''),
		DescricaoComplementarLocalizador = REPLACE(DescricaoComplementarLocalizador, '"',''),
		CodigoAutorEmenda = REPLACE(CodigoAutorEmenda, '"',''),
		NomeAutorEmenda = REPLACE(NomeAutorEmenda, '"',''),
		CodigoCategoriaEconomica = REPLACE(CodigoCategoriaEconomica, '"',''),
		NomeCategoriaEconomica = REPLACE(NomeCategoriaEconomica, '"',''),
		CodigoGrupoDespesa = REPLACE(CodigoGrupoDespesa, '"',''),
		NomeGrupoDespesa = REPLACE(NomeGrupoDespesa, '"',''),
		CodigoElementoDespesa = REPLACE(CodigoElementoDespesa, '"',''),
		NomeElementoDespesa = REPLACE(NomeElementoDespesa, '"',''),
		CodigoModalidadeDespesa = REPLACE(CodigoModalidadeDespesa, '"',''),
		ModalidadeDespesa = REPLACE(ModalidadeDespesa, '"',''),
		ValorEmpenhado = REPLACE(ValorEmpenhado, '"',''),
		ValorLiquidado = REPLACE(ValorLiquidado, '"',''),
		ValorPago = REPLACE(ValorPago, '"',''),
		ValorRestosPagarInscritos = REPLACE(ValorRestosPagarInscritos, '"',''),
		ValorRestosPagarCancelado = REPLACE(ValorRestosPagarCancelado, '"',''),
		ValorRestosPagarPagos = REPLACE(ValorRestosPagarPagos, '"','')



DELETE FROM ##temp_depesas
WHERE CodigoOrgaoSuperior = '-1'


ALTER TABLE ##temp_depesas 
DROP COLUMN CodigoProgramaGoverno, NomeProgramaGoverno, CodigoPlanoOrcamentario, PlanoOrcamentario,CodigoSubtitulo, NomeSubtitulo, CodigoAutorEmenda, NomeAutorEmenda


CREATE TABLE ##temp_despesas_Convertido(
		AnoMesLancamento DATE,
		CodigoOrgaoSuperior INT,
		NomeOrgaoSuperior VARCHAR (150),
		CodigoOrgaoSubordinado INT,
		NomeOrgaoSubordinado VARCHAR (150),
		CodigoUnidadeGestora INT,
		NomeUnidadeGestora VARCHAR (150),
		CodigoGestao INT,
		NomeGestao VARCHAR(150),
		CodigoUnidadeOrcamentaria INT,
		NomeUnidadeOrcamentaria VARCHAR (150),
		CodigoFuncao INT,
		NomeFuncao VARCHAR(150),
		CodigoSubfuncao INT,
		NomeSubfuncao VARCHAR(150),
		CodigoProgramaOrcamentario INT,
		NomeProgramaOrcamentario VARCHAR(150),
		CodigoAcao VARCHAR(10),
		NomeAcao VARCHAR(150),
		Uf CHAR(2),
		Municipio VARCHAR(150),
		CodigoLocalizador INT,
		NomeLocalizador VARCHAR(150),
		SiglaLocalizador VARCHAR(10),
		DescricaoComplementarLocalizador VARCHAR(155),
		CodigoCategoriaEconomica INT,
		NomeCategoriaEconomica VARCHAR(MAX),
		CodigoGrupoDespesa INT,
		NomeGrupoDespesa VARCHAR(MAX),
		CodigoElementoDespesa INT,
		NomeElementoDespesa VARCHAR(MAX),
		CodigoModalidadeDespesa INT,
		ModalidadeDespesa VARCHAR(MAX),
		ValorEmpenhado DECIMAL(18,2),
		ValorLiquidado DECIMAL(18,2),
		ValorPago DECIMAL(18,2),
		ValorRestosPagarInscritos DECIMAL(18,2),
		ValorRestosPagarCancelado DECIMAL(18,2),
		ValorRestosPagarPagos DECIMAL(18,2)
	);

INSERT INTO ##temp_despesas_Convertido
SELECT
    CASE 
        WHEN AnoMesLancamento IS NULL OR AnoMesLancamento = '' THEN NULL
        ELSE CAST(CONCAT(REPLACE(AnoMesLancamento,'/','-'), '-01') AS DATE)
    END AS AnoMesLancamento,

    CASE WHEN CodigoOrgaoSuperior IN ('','-1') THEN 0 ELSE CAST(CodigoOrgaoSuperior AS INT) END,
    CAST(NomeOrgaoSuperior AS VARCHAR(150)),

    CASE WHEN CodigoOrgaoSubordinado IN ('','-1') THEN 0 ELSE CAST(CodigoOrgaoSubordinado AS INT) END,
    CAST(NomeOrgaoSubordinado AS VARCHAR(150)),

    CASE WHEN CodigoUnidadeGestora IN ('','-1') THEN 0 ELSE CAST(CodigoUnidadeGestora AS INT) END,
    CAST(NomeUnidadeGestora AS VARCHAR(150)),

    CASE WHEN CodigoGestao IN ('','-1') THEN 0 ELSE CAST(CodigoGestao AS INT) END,
    CAST(NomeGestao AS VARCHAR(150)),

    CASE WHEN CodigoUnidadeOrcamentaria IN ('','-1') THEN 0 ELSE CAST(CodigoUnidadeOrcamentaria AS INT) END,
    CAST(NomeUnidadeOrcamentaria AS VARCHAR(150)),

    CASE WHEN CodigoFuncao IN ('','-1') THEN 0 ELSE CAST(CodigoFuncao AS INT) END,
    CAST(NomeFuncao AS VARCHAR(150)),

    CASE WHEN CodigoSubfuncao IN ('','-1') THEN 0 ELSE CAST(CodigoSubfuncao AS INT) END,
    CAST(NomeSubfuncao AS VARCHAR(150)),

    CASE WHEN CodigoProgramaOrcamentario IN ('','-1') THEN 0 ELSE CAST(CodigoProgramaOrcamentario AS INT) END,
    CAST(NomeProgramaOrcamentario AS VARCHAR(150)),

    CAST(CodigoAcao AS VARCHAR(10)),

    CAST(NomeAcao AS VARCHAR(150)),

    CAST(Uf AS CHAR(2)),
    CAST(Municipio AS VARCHAR(150)),

    CASE WHEN CodigoLocalizador IN ('','-1') THEN 0 ELSE CAST(CodigoLocalizador AS INT) END,
    CAST(NomeLocalizador AS VARCHAR(150)),

    CAST(SiglaLocalizador AS VARCHAR(10)),

    CAST(DescricaoComplementarLocalizador AS VARCHAR(155)),

    CASE WHEN CodigoCategoriaEconomica IN ('','-1') THEN 0 ELSE CAST(CodigoCategoriaEconomica AS INT) END,
    CAST(NomeCategoriaEconomica AS VARCHAR(MAX)),

    CASE WHEN CodigoGrupoDespesa IN ('','-1') THEN 0 ELSE CAST(CodigoGrupoDespesa AS INT) END,
    CAST(NomeGrupoDespesa AS VARCHAR(MAX)),

    CASE WHEN CodigoElementoDespesa IN ('','-1') THEN 0 ELSE CAST(CodigoElementoDespesa AS INT) END,
    CAST(NomeElementoDespesa AS VARCHAR(MAX)),

    CASE WHEN CodigoModalidadeDespesa IN ('','-1') THEN 0 ELSE CAST(CodigoModalidadeDespesa AS INT) END,
    CAST(ModalidadeDespesa AS VARCHAR(MAX)),

    
    CASE WHEN ValorEmpenhado IN ('','-1') THEN 0 ELSE CAST(REPLACE(ValorEmpenhado,',','.') AS DECIMAL(18,2)) END,
    CASE WHEN ValorLiquidado IN ('','-1') THEN 0 ELSE CAST(REPLACE(ValorLiquidado,',','.') AS DECIMAL(18,2)) END,
    CASE WHEN ValorPago IN ('','-1') THEN 0 ELSE CAST(REPLACE(ValorPago,',','.') AS DECIMAL(18,2)) END,
    CASE WHEN ValorRestosPagarInscritos IN ('','-1') THEN 0 ELSE CAST(REPLACE(ValorRestosPagarInscritos,',','.') AS DECIMAL(18,2)) END,
    CASE WHEN ValorRestosPagarCancelado IN ('','-1') THEN 0 ELSE CAST(REPLACE(ValorRestosPagarCancelado,',','.') AS DECIMAL(18,2)) END,
    CASE WHEN ValorRestosPagarPagos IN ('','-1') THEN 0 ELSE CAST(REPLACE(ValorRestosPagarPagos,',','.') AS DECIMAL(18,2)) END

FROM ##temp_depesas;

DROP TABLE ##temp_depesas
END
GO

CREATE PROCEDURE SP_CARREGA_CSV_DESPESAS
AS 
BEGIN
WITH CTE AS (
    SELECT 
        CodigoOrgaoSuperior,
        NomeOrgaoSuperior,
        ROW_NUMBER() OVER(PARTITION BY CodigoOrgaoSuperior ORDER BY CodigoOrgaoSuperior) AS rn
    FROM ##temp_despesas_Convertido
    WHERE CodigoOrgaoSuperior <> 0
)
INSERT INTO OrgaoSuperior (IdOrgaoSuperior, NomeOrgaoSuperior)
SELECT CodigoOrgaoSuperior, NomeOrgaoSuperior
FROM CTE
WHERE rn = 1
  AND NOT EXISTS (
      SELECT 1 FROM OrgaoSuperior o
      WHERE o.IdOrgaoSuperior = CTE.CodigoOrgaoSuperior
  );



  WITH CTE AS (
    SELECT 
        CodigoOrgaoSubordinado,
        NomeOrgaoSubordinado,
        CodigoOrgaoSuperior,
        ROW_NUMBER() OVER(PARTITION BY CodigoOrgaoSubordinado ORDER BY CodigoOrgaoSubordinado) AS rn
    FROM ##temp_despesas_Convertido
    WHERE CodigoOrgaoSubordinado <> 0 AND CodigoOrgaoSuperior <> 0
)
INSERT INTO OrgaoSubordinado (IdOrgaoSubordinado, NomeOrgaoSubordinado, IdOrgaoSuperior)
SELECT CodigoOrgaoSubordinado, NomeOrgaoSubordinado, CodigoOrgaoSuperior
FROM CTE
WHERE rn = 1
  AND NOT EXISTS (
      SELECT 1 FROM OrgaoSubordinado o
      WHERE o.IdOrgaoSubordinado = CTE.CodigoOrgaoSubordinado
  );



  WITH CTE AS (
    SELECT 
        CodigoGestao,
        NomeGestao,
        ROW_NUMBER() OVER(PARTITION BY CodigoGestao ORDER BY CodigoGestao) AS rn
    FROM ##temp_despesas_Convertido
    WHERE CodigoGestao <> 0
)
INSERT INTO Gestao (IdGestao, NomeGestao)
SELECT CodigoGestao, NomeGestao
FROM CTE
WHERE rn = 1
  AND NOT EXISTS (
      SELECT 1 FROM Gestao g
      WHERE g.IdGestao = CTE.CodigoGestao
  );

    WITH CTE AS (
    SELECT 
        CodigoUnidadeGestora,
        NomeUnidadeGestora,
        CodigoOrgaoSuperior,
        CodigoGestao,
        ROW_NUMBER() OVER(PARTITION BY CodigoUnidadeGestora ORDER BY CodigoUnidadeGestora) AS rn
    FROM ##temp_despesas_Convertido
    WHERE CodigoUnidadeGestora <> 0 AND CodigoOrgaoSuperior <> 0 AND CodigoGestao <> 0
)
INSERT INTO UnidadeGestora (IdUnidadeGestora, NomeUnidadeGestora, IdOrgaoSuperior, IdGestao)
SELECT CodigoUnidadeGestora, NomeUnidadeGestora, CodigoOrgaoSuperior, CodigoGestao
FROM CTE
WHERE rn = 1
  AND NOT EXISTS (
      SELECT 1 FROM UnidadeGestora u
      WHERE u.IdUnidadeGestora = CTE.CodigoUnidadeGestora
       -- AND u.IdOrgaoSuperior = CTE.CodigoOrgaoSuperior
       -- AND u.IdGestao = CTE.CodigoGestao
  );



  WITH CTE AS (
    SELECT 
        CodigoGrupoDespesa,
        NomeGrupoDespesa,
        ROW_NUMBER() OVER(PARTITION BY CodigoGrupoDespesa ORDER BY CodigoGrupoDespesa) AS rn
    FROM ##temp_despesas_Convertido
    WHERE CodigoGrupoDespesa <> 0
)
INSERT INTO GrupoDespesa (IdGrupoDespesa, NomeGrupoDespesa)
SELECT CodigoGrupoDespesa, NomeGrupoDespesa
FROM CTE
WHERE rn = 1
  AND NOT EXISTS (
      SELECT 1 FROM GrupoDespesa g
      WHERE g.IdGrupoDespesa = CTE.CodigoGrupoDespesa
  );


  WITH CTE AS (
    SELECT 
        CodigoCategoriaEconomica,
        NomeCategoriaEconomica,
        CodigoGrupoDespesa,
        ROW_NUMBER() OVER(PARTITION BY CodigoCategoriaEconomica ORDER BY CodigoCategoriaEconomica) AS rn
    FROM ##temp_despesas_Convertido
    WHERE CodigoCategoriaEconomica <> 0 AND CodigoGrupoDespesa <> 0
)
INSERT INTO CategoriaEconomica (IdCategoriaEconomica, NomeCategoriaEconomica, IdGrupoDespesa)
SELECT CodigoCategoriaEconomica, NomeCategoriaEconomica, CodigoGrupoDespesa
FROM CTE
WHERE rn = 1
  AND NOT EXISTS (
      SELECT 1 FROM CategoriaEconomica c
      WHERE c.IdCategoriaEconomica = CTE.CodigoCategoriaEconomica
  );



  WITH CTE AS (
    SELECT 
        CodigoModalidadeDespesa,
        ModalidadeDespesa,
        CodigoGrupoDespesa,
        ROW_NUMBER() OVER(PARTITION BY CodigoModalidadeDespesa ORDER BY CodigoModalidadeDespesa) AS rn
    FROM ##temp_despesas_Convertido
    WHERE CodigoModalidadeDespesa <> 0 AND CodigoGrupoDespesa <> 0
)
INSERT INTO ModalidadeDespesa (IdModalidadeDespesa, NomeModalidadeDespesa, IdGrupoDespesa)
SELECT CodigoModalidadeDespesa, ModalidadeDespesa, CodigoGrupoDespesa
FROM CTE
WHERE rn = 1
  AND NOT EXISTS (
      SELECT 1 FROM ModalidadeDespesa m
      WHERE m.IdModalidadeDespesa = CTE.CodigoModalidadeDespesa
  );


  WITH CTE AS (
    SELECT 
        CodigoElementoDespesa,
        NomeElementoDespesa,
        CodigoGrupoDespesa,
        ROW_NUMBER() OVER(PARTITION BY CodigoElementoDespesa ORDER BY CodigoElementoDespesa) AS rn
    FROM ##temp_despesas_Convertido
    WHERE CodigoElementoDespesa <> 0 AND CodigoGrupoDespesa <> 0
)
INSERT INTO ElementoDespesa (IdElementoDespesa, NomeElementoDespesa, IdGrupoDespesa)
SELECT CodigoElementoDespesa, NomeElementoDespesa, CodigoGrupoDespesa
FROM CTE
WHERE rn = 1
  AND NOT EXISTS (
      SELECT 1 FROM ElementoDespesa e
      WHERE e.IdElementoDespesa = CTE.CodigoElementoDespesa
  );


  WITH CTE AS (
    SELECT 
        CodigoLocalizador,
        NomeLocalizador,
        SiglaLocalizador,
        DescricaoComplementarLocalizador,
        ROW_NUMBER() OVER(PARTITION BY CodigoLocalizador ORDER BY CodigoLocalizador) AS rn
    FROM ##temp_despesas_Convertido
    WHERE CodigoLocalizador <> 0
)
INSERT INTO Localizador (IdLocalizador, NomeLocalizador, SiglaLocalizador, DescricaoComplementarLocalizador)
SELECT CodigoLocalizador, NomeLocalizador, SiglaLocalizador, DescricaoComplementarLocalizador
FROM CTE
WHERE rn = 1
  AND NOT EXISTS (
      SELECT 1 FROM Localizador l
      WHERE l.IdLocalizador = CTE.CodigoLocalizador
  );


  WITH CTE AS (
    SELECT 
        CodigoUnidadeOrcamentaria,
        NomeUnidadeOrcamentaria,
        ROW_NUMBER() OVER(PARTITION BY CodigoUnidadeOrcamentaria ORDER BY CodigoUnidadeOrcamentaria) AS rn
    FROM ##temp_despesas_Convertido
    WHERE CodigoUnidadeOrcamentaria <> 0
)
INSERT INTO UnidadeOrcamentaria (IdUnidadeOrcamentaria, NomeUnidadeOrcamentaria)
SELECT CodigoUnidadeOrcamentaria, NomeUnidadeOrcamentaria
FROM CTE
WHERE rn = 1
  AND NOT EXISTS (
      SELECT 1 FROM UnidadeOrcamentaria u
      WHERE u.IdUnidadeOrcamentaria = CTE.CodigoUnidadeOrcamentaria
  );


  WITH CTE AS (
    SELECT 
        CodigoProgramaOrcamentario,
        NomeProgramaOrcamentario,
        CodigoUnidadeOrcamentaria,
        ROW_NUMBER() OVER(PARTITION BY CodigoProgramaOrcamentario ORDER BY CodigoProgramaOrcamentario) AS rn
    FROM ##temp_despesas_Convertido
    WHERE CodigoProgramaOrcamentario <> 0 AND CodigoUnidadeOrcamentaria <> 0
)
INSERT INTO ProgramaOrcamentario (IdProgramaOrcamentario, NomeProgramaOrcamentario, IdUnidadeOrcamentaria)
SELECT CodigoProgramaOrcamentario, NomeProgramaOrcamentario, CodigoUnidadeOrcamentaria
FROM CTE
WHERE rn = 1
  AND NOT EXISTS (
      SELECT 1 FROM ProgramaOrcamentario p
      WHERE p.IdProgramaOrcamentario = CTE.CodigoProgramaOrcamentario
  );

  WITH CTE AS (
    SELECT 
        CodigoFuncao,
        NomeFuncao,
        ROW_NUMBER() OVER(PARTITION BY CodigoFuncao ORDER BY CodigoFuncao) AS rn
    FROM ##temp_despesas_Convertido
    WHERE CodigoFuncao <> 0
)
INSERT INTO Funcao (IdFuncao, NomeFuncao)
SELECT CodigoFuncao, NomeFuncao
FROM CTE
WHERE rn = 1
  AND NOT EXISTS (
      SELECT 1 FROM Funcao f
      WHERE f.IdFuncao = CTE.CodigoFuncao
  );

  WITH CTE AS (
    SELECT 
        CodigoSubfuncao,
        NomeSubfuncao,
        CodigoFuncao,
        ROW_NUMBER() OVER(PARTITION BY CodigoSubfuncao ORDER BY CodigoSubfuncao) AS rn
    FROM ##temp_despesas_Convertido
    WHERE CodigoSubfuncao <> 0 AND CodigoFuncao <> 0
)
INSERT INTO SubFuncao (IdSubFuncao, NomeSubFuncao, IdFuncao)
SELECT CodigoSubfuncao, NomeSubfuncao, CodigoFuncao
FROM CTE
WHERE rn = 1
  AND NOT EXISTS (
      SELECT 1 FROM SubFuncao s
      WHERE s.IdSubFuncao = CTE.CodigoSubfuncao
  );

  ;WITH CTE AS (
    SELECT 
        CodigoAcao,
        NomeAcao,
        ROW_NUMBER() OVER(PARTITION BY CodigoAcao ORDER BY CodigoAcao) AS rn
    FROM ##temp_despesas_Convertido
    WHERE CodigoAcao <> '0'  -- remove valores inválidos
)
INSERT INTO Acao (IdAcao, NomeAcao)
SELECT CodigoAcao, NomeAcao
FROM CTE
WHERE rn = 1
  AND NOT EXISTS (
      SELECT 1 
      FROM Acao a
      WHERE a.IdAcao = CTE.CodigoAcao
  );

INSERT INTO Despesas (
    DataLancamento,
    UF,
    Municipio,
    ValorEmpenhado,
    ValorLiquido,
    ValorPago,
    ValorRestosAPagarInscritos,
    ValorRestosAPagarCancelados,
    IdElementoDespesa,
    IdOrgaoSuperior,
    IdCategoriaEconomica,
    IdGestao,
    IdProgramaOrcamentario,
    IdLocalizador,
    IdMandato,
    IdAcao,
    IdFuncao
)
SELECT
    t.AnoMesLancamento,
    t.UF,
    t.Municipio,
    t.ValorEmpenhado,
    t.ValorLiquidado,
    t.ValorPago,
    t.ValorRestosPagarInscritos,
    t.ValorRestosPagarCancelado,
    t.CodigoElementoDespesa,
    t.CodigoOrgaoSuperior,
    t.CodigoCategoriaEconomica,
    NULLIF(t.CodigoGestao, 0),
    t.CodigoProgramaOrcamentario,
    NULLIF(t.CodigoLocalizador,0),
    m.IdMandato, 
    t.CodigoAcao,
    t.CodigoFuncao
FROM ##temp_despesas_Convertido t
JOIN Mandato m
    ON t.AnoMesLancamento >= m.DataInicio
   AND (t.AnoMesLancamento <= m.DataFim OR m.DataFim IS NULL);
END
GO


CREATE PROCEDURE SP_CARREGA_PRESIDENTE
AS
BEGIN
   INSERT INTO Presidente(IdPresidente, NomePresidente)
   VALUES (1, 'Dilma Roussef')

   INSERT INTO Presidente(IdPresidente, NomePresidente)
   VALUES (2, 'Michel Temer')

   INSERT INTO Presidente(IdPresidente, NomePresidente)
   VALUES (3, 'Jair Bolsonaro')

   INSERT INTO Presidente(IdPresidente, NomePresidente)
   VALUES (4, 'Lula')

   INSERT INTO Mandato(IdMandato, DataInicio,DataFim,IdPresidente)
   VALUES (1,'2015-10-01', '2016-08-31',1)

   INSERT INTO Mandato(IdMandato, DataInicio,DataFim,IdPresidente)
   VALUES (2,'2016-09-01', '2018-12-31',2)

   INSERT INTO Mandato(IdMandato, DataInicio,DataFim,IdPresidente)
   VALUES (3,'2019-01-01', '2022-12-31',3)

   INSERT INTO Mandato(IdMandato, DataInicio,DataFim,IdPresidente)
   VALUES (4,'2023-01-01', NULL,4)

END
GO

CREATE PROCEDURE SP_ETL_DESPESAS
@CAMINHO_CSV VARCHAR(150)
AS
BEGIN
EXEC SP_EXTRAI_CSV_DESPESAS @CAMINHO = @CAMINHO_CSV
EXEC SP_TRATA_CSV_DESPESAS
EXEC SP_CARREGA_CSV_DESPESAS
DROP TABLE ##temp_despesas_Convertido
END
GO
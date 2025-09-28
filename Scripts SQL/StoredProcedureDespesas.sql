USE ProjetoGastosGovernamentais
GO

CREATE PROCEDURE SP_EXTRAI_CSV_DESPESAS --Criação da Sored Procedure que extrai os dados do csv despesas
@CAMINHO VARCHAR(150)   --Caminho do csv que a SP irá receber para execultar o bulk insert
AS
BEGIN
	IF OBJECT_ID('tempdb..##temp_depesas') IS NOT NULL  --Verificação se a tabela temporaria já existe, caso exista ela é apagada
    DROP TABLE ##temp_depesas;

	CREATE TABLE ##temp_depesas(                 -- Criação da tabela temporaria que irá receber todos os dados do csv despesas, com os campos todos em VARCHAR(MAX), que serão tratados e convertidos para seu tipo ideal posteriormente
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
	
    DECLARE @sql NVARCHAR(MAX);   --Criação de uma variavél temporaria para armazernar a instrução BULK INSERT (Isso está sendo utilizado para que essa intrução aceite o @CAMINHO)
    SET @sql = N'				
    BULK INSERT ##temp_depesas
    FROM ''' + @CAMINHO + N'''
    WITH (
        FIELDTERMINATOR = '';'' ,
        ROWTERMINATOR = ''\n'',
        FIRSTROW = 2,
        CODEPAGE = ''1252''
    );';							--Instrução para realização do BULK INSERT

    EXEC sp_executesql @sql;     --Execução do que foi armazenado (sp_executesql é um procedimento de sistema para a execução de um comando SQL através de uma string de texto)

END;
GO

CREATE PROCEDURE SP_TRATA_CSV_DESPESAS      --Procedure responsável por tratar os valores extraidos
AS
BEGIN
UPDATE ##temp_depesas						--Como todos os dados vem com '"' no inicio e no fim, essa parte é responsável por removê-los
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



DELETE FROM ##temp_depesas				--Deleta os dados que contÊm o Codigo do Orgão Supeior como -1
WHERE CodigoOrgaoSuperior = '-1'


ALTER TABLE ##temp_depesas		--Deleta tabelas que são desnecessárias
DROP COLUMN CodigoProgramaGoverno, NomeProgramaGoverno, CodigoPlanoOrcamentario, PlanoOrcamentario,CodigoSubtitulo, NomeSubtitulo, CodigoAutorEmenda, NomeAutorEmenda

IF OBJECT_ID('tempdb..##temp_despesas_Convertido') IS NOT NULL		--Verificação se a tabela temporaria já existe, caso exista ela é apagada
DROP TABLE ##temp_despesas_Convertido;

CREATE TABLE ##temp_despesas_Convertido(		--Criação de uma tabela que irá receber os valores que serão convertidos para seu tipo ideal, para depois serem distribuidos para suas respectivas tabelas
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


	DELETE																		--Alguns de valor estavam vindo com informações de outras colunas, então aqui nós identificamos eles e apagamos
	FROM ##temp_depesas
	WHERE TRY_CAST(CodigoOrgaoSuperior AS INT) IS NULL 
	OR TRY_CAST(CodigoOrgaoSubordinado AS INT) IS NULL 
	OR TRY_CAST(CodigoUnidadeGestora AS INT) IS NULL 
	OR TRY_CAST(CodigoGestao AS INT) IS NULL 
	OR TRY_CAST(CodigoUnidadeOrcamentaria AS INT) IS NULL 
	OR TRY_CAST(CodigoFuncao AS INT) IS NULL 
	OR TRY_CAST(CodigoSubfuncao AS INT) IS NULL 
	OR TRY_CAST(CodigoProgramaOrcamentario AS INT) IS NULL 
	OR TRY_CAST(CodigoLocalizador AS INT) IS NULL 
	OR TRY_CAST(CodigoCategoriaEconomica AS INT) IS NULL 
	OR TRY_CAST(CodigoGrupoDespesa AS INT) IS NULL 
	OR TRY_CAST(CodigoElementoDespesa AS INT) IS NULL 
	OR TRY_CAST(CodigoModalidadeDespesa AS INT) IS NULL 
	AND CodigoOrgaoSuperior NOT IN ('', '-1', 'I', '-3')
	AND CodigoOrgaoSubordinado NOT IN ('', '-1', 'I', '-3')
	AND CodigoUnidadeGestora NOT IN ('', '-1', 'I', '-3')
	AND CodigoGestao NOT IN ('', '-1', 'I', '-3')
	AND CodigoUnidadeOrcamentaria NOT IN ('', '-1', 'I', '-3')
	AND CodigoFuncao NOT IN ('', '-1', 'I', '-3')
	AND CodigoSubfuncao NOT IN ('', '-1', 'I', '-3')
	AND CodigoProgramaOrcamentario NOT IN ('', '-1', 'I', '-3')
	AND CodigoLocalizador NOT IN ('', '-1', 'I', '-3')
	AND CodigoCategoriaEconomica NOT IN ('', '-1', 'I', '-3')
	AND CodigoGrupoDespesa NOT IN ('', '-1', 'I', '-3')
	AND CodigoElementoDespesa NOT IN ('', '-1', 'I', '-3')
	AND CodigoModalidadeDespesa NOT IN ('', '-1', 'I', '-3')


INSERT INTO ##temp_despesas_Convertido			--Casting dos dados
SELECT
    CASE 
        WHEN AnoMesLancamento IS NULL OR AnoMesLancamento = '' THEN NULL
        ELSE CAST(CONCAT(REPLACE(AnoMesLancamento,'/','-'), '-01') AS DATE) END,				--Como a data está em formato 12/2025, é substituido o / por -, e adicionado o dia 01 no final para ocorrer a conversão

    CASE WHEN CodigoOrgaoSuperior IN ('','-1','I','-3', ' JUVENT','BACELAR / EMENDA 2') THEN 0 ELSE CAST(CodigoOrgaoSuperior AS INT) END, --A partir daqui todos os dados que forem inteiros ocorrerá uma verificação que caso esteja como '' ou '-1', sejam substituido para '0', antes de sua conversão
    CAST(NomeOrgaoSuperior AS VARCHAR(150)),

    CASE WHEN CodigoOrgaoSubordinado IN ('','-1','I','-3', ' JUVENT','BACELAR / EMENDA 2') THEN 0 ELSE CAST(CodigoOrgaoSubordinado AS INT) END,
    CAST(NomeOrgaoSubordinado AS VARCHAR(150)),

    CASE WHEN CodigoUnidadeGestora IN ('','-1','I','-3', ' JUVENT','BACELAR / EMENDA 2') THEN 0 ELSE CAST(CodigoUnidadeGestora AS INT) END,
    CAST(NomeUnidadeGestora AS VARCHAR(150)),

    CASE WHEN CodigoGestao IN ('','-1','I','-3', ' JUVENT','BACELAR / EMENDA 2') THEN 0 ELSE CAST(CodigoGestao AS INT) END,
    CAST(NomeGestao AS VARCHAR(150)),

    CASE WHEN CodigoUnidadeOrcamentaria IN ('','-1','I','-3', ' JUVENT','BACELAR / EMENDA 2') THEN 0 ELSE CAST(CodigoUnidadeOrcamentaria AS INT) END,
    CAST(NomeUnidadeOrcamentaria AS VARCHAR(150)),

    CASE WHEN CodigoFuncao IN ('','-1','I','-3', ' JUVENT','BACELAR / EMENDA 2') THEN 0 ELSE CAST(CodigoFuncao AS INT) END,
    CAST(NomeFuncao AS VARCHAR(150)),

    CASE WHEN CodigoSubfuncao IN ('','-1','I','-3', ' JUVENT') THEN 0 ELSE CAST(CodigoSubfuncao AS INT) END,
    CAST(NomeSubfuncao AS VARCHAR(150)),

    CASE WHEN CodigoProgramaOrcamentario IN ('','-1','I','-3', ' JUVENT','BACELAR / EMENDA 2') THEN 0 ELSE CAST(CodigoProgramaOrcamentario AS INT) END,
    CAST(NomeProgramaOrcamentario AS VARCHAR(150)),

    CAST(CodigoAcao AS VARCHAR(10)),

    CAST(NomeAcao AS VARCHAR(150)),

    CAST(Uf AS CHAR(2)),
    CAST(Municipio AS VARCHAR(150)),

    CASE WHEN CodigoLocalizador IN ('','-1','I','-3',' JUVENT','BACELAR / EMENDA 2') THEN 0 ELSE CAST(CodigoLocalizador AS INT) END,
    CAST(NomeLocalizador AS VARCHAR(150)),

    CAST(SiglaLocalizador AS VARCHAR(10)),

    CAST(DescricaoComplementarLocalizador AS VARCHAR(155)),

    CASE WHEN CodigoCategoriaEconomica IN ('','-1','I','-3',' JUVENT','BACELAR / EMENDA 2') THEN 0 ELSE CAST(CodigoCategoriaEconomica AS INT) END,
    CAST(NomeCategoriaEconomica AS VARCHAR(MAX)),

    CASE WHEN CodigoGrupoDespesa IN ('','-1','I','-3', ' JUVENT','BACELAR / EMENDA 2') THEN 0 ELSE CAST(CodigoGrupoDespesa AS INT) END,
    CAST(NomeGrupoDespesa AS VARCHAR(MAX)),

    CASE WHEN CodigoElementoDespesa IN ('','-1','I','-3', ' JUVENT','BACELAR / EMENDA 2') THEN 0 ELSE CAST(CodigoElementoDespesa AS INT) END,
    CAST(NomeElementoDespesa AS VARCHAR(MAX)),

    CASE WHEN CodigoModalidadeDespesa IN ('','-1','I','-3', ' JUVENT','BACELAR / EMENDA 2') THEN 0 ELSE CAST(CodigoModalidadeDespesa AS INT) END,
    CAST(ModalidadeDespesa AS VARCHAR(MAX)),

    
    CASE WHEN ValorEmpenhado IN ('','-1') THEN 0 ELSE CAST(REPLACE(ValorEmpenhado,',','.') AS DECIMAL(18,2)) END,	--Todos os decimal a partir daqui serão verificados o mesmo caso dos inteiros, e eles serão converter a ',' para '.', que é o padrão usado no SQL SERVER
    CASE WHEN ValorLiquidado IN ('','-1') THEN 0 ELSE CAST(REPLACE(ValorLiquidado,',','.') AS DECIMAL(18,2)) END,
    CASE WHEN ValorPago IN ('','-1') THEN 0 ELSE CAST(REPLACE(ValorPago,',','.') AS DECIMAL(18,2)) END,
    CASE WHEN ValorRestosPagarInscritos IN ('','-1') THEN 0 ELSE CAST(REPLACE(ValorRestosPagarInscritos,',','.') AS DECIMAL(18,2)) END,
    CASE WHEN ValorRestosPagarCancelado IN ('','-1') THEN 0 ELSE CAST(REPLACE(ValorRestosPagarCancelado,',','.') AS DECIMAL(18,2)) END,
    CASE WHEN ValorRestosPagarPagos IN ('','-1') THEN 0 ELSE CAST(REPLACE(ValorRestosPagarPagos,',','.') AS DECIMAL(18,2)) END

FROM ##temp_depesas;

DROP TABLE ##temp_depesas
END
GO

CREATE PROCEDURE SP_CARREGA_CSV_DESPESAS		--Stored Procedure responsável por carregar os dados tratados para sua respectiva tabela
AS 
BEGIN
WITH CTE AS (				--Criação de uma CTE para selecionar os dados necessários, e principalmente para a criação de um ROW_NUMBER que será usado para diferenciar os dados iguais dentro da tabela temporaria
    SELECT 
        CodigoOrgaoSuperior,
        NomeOrgaoSuperior,
        ROW_NUMBER() OVER(PARTITION BY CodigoOrgaoSuperior ORDER BY CodigoOrgaoSuperior) AS rn  --Aqui estamos criando uma sequência contendo os valores repitidos da tabela. Para que em seu preenchimento não haja duplicatas de uma PK
    FROM ##temp_despesas_Convertido
    WHERE CodigoOrgaoSuperior <> 0																--Estamos excluindo os que contém '0' da consulta, porque são valores invalidos
)
INSERT INTO OrgaoSuperior (IdOrgaoSuperior, NomeOrgaoSuperior)				--Preenchimento da tabela OrgaoSuperior
SELECT CodigoOrgaoSuperior, NomeOrgaoSuperior
FROM CTE
WHERE rn = 1									--Pegando apenas os primeiros da sequencia criada anteriormente para evitar duplicadas
  AND NOT EXISTS (								--Verificando se o valor já existe na tabela principal
      SELECT 1 FROM OrgaoSuperior o
      WHERE o.IdOrgaoSuperior = CTE.CodigoOrgaoSuperior
  );



  WITH CTE AS (				--Criação de uma CTE para selecionar os dados necessários, e principalmente para a criação de um ROW_NUMBER que será usado para diferenciar os dados iguais dentro da tabela temporaria
    SELECT 
        CodigoOrgaoSubordinado,
        NomeOrgaoSubordinado,
        CodigoOrgaoSuperior,
        ROW_NUMBER() OVER(PARTITION BY CodigoOrgaoSubordinado ORDER BY CodigoOrgaoSubordinado) AS rn  --Aqui estamos criando uma sequência contendo os valores repitidos da tabela. Para que em seu preenchimento não haja duplicatas de uma PK
    FROM ##temp_despesas_Convertido
    WHERE CodigoOrgaoSubordinado <> 0 AND CodigoOrgaoSuperior <> 0		--Estamos excluindo os que contém '0' da consulta, porque são valores invalidos
)
INSERT INTO OrgaoSubordinado (IdOrgaoSubordinado, NomeOrgaoSubordinado, IdOrgaoSuperior)  --Preenchimento da tabela OrgaoSubordinado
SELECT CodigoOrgaoSubordinado, NomeOrgaoSubordinado, CodigoOrgaoSuperior
FROM CTE
WHERE rn = 1									--Pegando apenas os primeiros da sequencia criada anteriormente para evitar duplicadas
  AND NOT EXISTS (
      SELECT 1 FROM OrgaoSubordinado o
      WHERE o.IdOrgaoSubordinado = CTE.CodigoOrgaoSubordinado
  );



  WITH CTE AS (				--Criação de uma CTE para selecionar os dados necessários, e principalmente para a criação de um ROW_NUMBER que será usado para diferenciar os dados iguais dentro da tabela temporaria
    SELECT 
        CodigoGestao,
        NomeGestao,
        ROW_NUMBER() OVER(PARTITION BY CodigoGestao ORDER BY CodigoGestao) AS rn  --Aqui estamos criando uma sequência contendo os valores repitidos da tabela. Para que em seu preenchimento não haja duplicatas de uma PK
    FROM ##temp_despesas_Convertido
    WHERE CodigoGestao <> 0															--Estamos excluindo os que contém '0' da consulta, porque são valores invalidos
)
INSERT INTO Gestao (IdGestao, NomeGestao)  --Preenchimento da tabela Gestao
SELECT CodigoGestao, NomeGestao
FROM CTE
WHERE rn = 1									--Pegando apenas os primeiros da sequencia criada anteriormente para evitar duplicadas
  AND NOT EXISTS (								--Verificadno se o valor já existe na tabela principal
      SELECT 1 FROM Gestao g
      WHERE g.IdGestao = CTE.CodigoGestao
  );

  WITH CTE AS (				--Criação de uma CTE para selecionar os dados necessários, e principalmente para a criação de um ROW_NUMBER que será usado para diferenciar os dados iguais dentro da tabela temporaria
    SELECT 
        CodigoUnidadeGestora,
        NomeUnidadeGestora,
        CodigoOrgaoSuperior,
        CodigoGestao,
        ROW_NUMBER() OVER(PARTITION BY CodigoUnidadeGestora ORDER BY CodigoUnidadeGestora) AS rn  --Aqui estamos criando uma sequência contendo os valores repitidos da tabela. Para que em seu preenchimento não haja duplicatas de uma PK
    FROM ##temp_despesas_Convertido
    WHERE CodigoUnidadeGestora <> 0 AND CodigoOrgaoSuperior <> 0 AND CodigoGestao <> 0			--Estamos excluindo os que contém '0' da consulta, porque são valores invalidos
)
INSERT INTO UnidadeGestora (IdUnidadeGestora, NomeUnidadeGestora, IdOrgaoSuperior, IdGestao)  --Preenchimento da tabela UnidadeGestora
SELECT CodigoUnidadeGestora, NomeUnidadeGestora, CodigoOrgaoSuperior, CodigoGestao
FROM CTE
WHERE rn = 1									--Pegando apenas os primeiros da sequencia criada anteriormente para evitar duplicadas
  AND NOT EXISTS (								--Verificadno se o valor já existe na tabela principal
      SELECT 1 FROM UnidadeGestora u
      WHERE u.IdUnidadeGestora = CTE.CodigoUnidadeGestora
       -- AND u.IdOrgaoSuperior = CTE.CodigoOrgaoSuperior
       -- AND u.IdGestao = CTE.CodigoGestao
  );



  WITH CTE AS (				--Criação de uma CTE para selecionar os dados necessários, e principalmente para a criação de um ROW_NUMBER que será usado para diferenciar os dados iguais dentro da tabela temporaria
    SELECT 
        CodigoGrupoDespesa,
        NomeGrupoDespesa,
        ROW_NUMBER() OVER(PARTITION BY CodigoGrupoDespesa ORDER BY CodigoGrupoDespesa) AS rn  --Aqui estamos criando uma sequência contendo os valores repitidos da tabela. Para que em seu preenchimento não haja duplicatas de uma PK
    FROM ##temp_despesas_Convertido
    WHERE CodigoGrupoDespesa <> 0																--Estamos excluindo os que contém '0' da consulta, porque são valores invalidos
)
INSERT INTO GrupoDespesa (IdGrupoDespesa, NomeGrupoDespesa)  --Preenchimento da tabela GrupoDespesa
SELECT CodigoGrupoDespesa, NomeGrupoDespesa
FROM CTE
WHERE rn = 1									--Pegando apenas os primeiros da sequencia criada anteriormente para evitar duplicadas
  AND NOT EXISTS (								--Verificadno se o valor já existe na tabela principal
      SELECT 1 FROM GrupoDespesa g
      WHERE g.IdGrupoDespesa = CTE.CodigoGrupoDespesa
  );


  WITH CTE AS (				--Criação de uma CTE para selecionar os dados necessários, e principalmente para a criação de um ROW_NUMBER que será usado para diferenciar os dados iguais dentro da tabela temporaria
    SELECT 
        CodigoCategoriaEconomica,
        NomeCategoriaEconomica,
        CodigoGrupoDespesa,
        ROW_NUMBER() OVER(PARTITION BY CodigoCategoriaEconomica ORDER BY CodigoCategoriaEconomica) AS rn  --Aqui estamos criando uma sequência contendo os valores repitidos da tabela. Para que em seu preenchimento não haja duplicatas de uma PK
    FROM ##temp_despesas_Convertido
    WHERE CodigoCategoriaEconomica <> 0 AND CodigoGrupoDespesa <> 0										--Estamos excluindo os que contém '0' da consulta, porque são valores invalidos
)
INSERT INTO CategoriaEconomica (IdCategoriaEconomica, NomeCategoriaEconomica, IdGrupoDespesa)  --Preenchimento da tabela CategoriaEconomica
SELECT CodigoCategoriaEconomica, NomeCategoriaEconomica, CodigoGrupoDespesa
FROM CTE
WHERE rn = 1									--Pegando apenas os primeiros da sequencia criada anteriormente para evitar duplicadas
  AND NOT EXISTS (								--Verificadno se o valor já existe na tabela principal
      SELECT 1 FROM CategoriaEconomica c
      WHERE c.IdCategoriaEconomica = CTE.CodigoCategoriaEconomica
  );



  WITH CTE AS (				--Criação de uma CTE para selecionar os dados necessários, e principalmente para a criação de um ROW_NUMBER que será usado para diferenciar os dados iguais dentro da tabela temporaria
    SELECT 
        CodigoModalidadeDespesa,
        ModalidadeDespesa,
        CodigoGrupoDespesa,
        ROW_NUMBER() OVER(PARTITION BY CodigoModalidadeDespesa ORDER BY CodigoModalidadeDespesa) AS rn  --Aqui estamos criando uma sequência contendo os valores repitidos da tabela. Para que em seu preenchimento não haja duplicatas de uma PK
    FROM ##temp_despesas_Convertido
    WHERE CodigoModalidadeDespesa <> 0 AND CodigoGrupoDespesa <> 0										--Estamos excluindo os que contém '0' da consulta, porque são valores invalidos
)
INSERT INTO ModalidadeDespesa (IdModalidadeDespesa, NomeModalidadeDespesa, IdGrupoDespesa)  --Preenchimento da tabela ModalidadeDespesa
SELECT CodigoModalidadeDespesa, ModalidadeDespesa, CodigoGrupoDespesa
FROM CTE
WHERE rn = 1									--Pegando apenas os primeiros da sequencia criada anteriormente para evitar duplicadas
  AND NOT EXISTS (								--Verificadno se o valor já existe na tabela principal
      SELECT 1 FROM ModalidadeDespesa m
      WHERE m.IdModalidadeDespesa = CTE.CodigoModalidadeDespesa
  );


  WITH CTE AS (				--Criação de uma CTE para selecionar os dados necessários, e principalmente para a criação de um ROW_NUMBER que será usado para diferenciar os dados iguais dentro da tabela temporaria
    SELECT 
        CodigoElementoDespesa,
        NomeElementoDespesa,
        CodigoGrupoDespesa,
        ROW_NUMBER() OVER(PARTITION BY CodigoElementoDespesa ORDER BY CodigoElementoDespesa) AS rn  --Aqui estamos criando uma sequência contendo os valores repitidos da tabela. Para que em seu preenchimento não haja duplicatas de uma PK
    FROM ##temp_despesas_Convertido
    WHERE CodigoElementoDespesa <> 0 AND CodigoGrupoDespesa <> 0									--Estamos excluindo os que contém '0' da consulta, porque são valores invalidos
)
INSERT INTO ElementoDespesa (IdElementoDespesa, NomeElementoDespesa, IdGrupoDespesa)  --Preenchimento da tabela ElementoDespesa
SELECT CodigoElementoDespesa, NomeElementoDespesa, CodigoGrupoDespesa
FROM CTE
WHERE rn = 1									--Pegando apenas os primeiros da sequencia criada anteriormente para evitar duplicadas
  AND NOT EXISTS (								--Verificadno se o valor já existe na tabela principal
      SELECT 1 FROM ElementoDespesa e
      WHERE e.IdElementoDespesa = CTE.CodigoElementoDespesa
  );


  WITH CTE AS (				--Criação de uma CTE para selecionar os dados necessários, e principalmente para a criação de um ROW_NUMBER que será usado para diferenciar os dados iguais dentro da tabela temporaria
    SELECT 
        CodigoLocalizador,
        NomeLocalizador,
        SiglaLocalizador,
        DescricaoComplementarLocalizador,
        ROW_NUMBER() OVER(PARTITION BY CodigoLocalizador ORDER BY CodigoLocalizador) AS rn  --Aqui estamos criando uma sequência contendo os valores repitidos da tabela. Para que em seu preenchimento não haja duplicatas de uma PK
    FROM ##temp_despesas_Convertido
    WHERE CodigoLocalizador <> 0																--Estamos excluindo os que contém '0' da consulta, porque são valores invalidos
)
INSERT INTO Localizador (IdLocalizador, NomeLocalizador, SiglaLocalizador, DescricaoComplementarLocalizador)  --Preenchimento da tabela Localizador
SELECT CodigoLocalizador, NomeLocalizador, SiglaLocalizador, DescricaoComplementarLocalizador
FROM CTE
WHERE rn = 1									--Pegando apenas os primeiros da sequencia criada anteriormente para evitar duplicadas
  AND NOT EXISTS (								--Verificadno se o valor já existe na tabela principal
      SELECT 1 FROM Localizador l
      WHERE l.IdLocalizador = CTE.CodigoLocalizador
  );


  WITH CTE AS (				--Criação de uma CTE para selecionar os dados necessários, e principalmente para a criação de um ROW_NUMBER que será usado para diferenciar os dados iguais dentro da tabela temporaria
    SELECT 
        CodigoUnidadeOrcamentaria,
        NomeUnidadeOrcamentaria,
        ROW_NUMBER() OVER(PARTITION BY CodigoUnidadeOrcamentaria ORDER BY CodigoUnidadeOrcamentaria) AS rn  --Aqui estamos criando uma sequência contendo os valores repitidos da tabela. Para que em seu preenchimento não haja duplicatas de uma PK
    FROM ##temp_despesas_Convertido
    WHERE CodigoUnidadeOrcamentaria <> 0																--Estamos excluindo os que contém '0' da consulta, porque são valores invalidos
)
INSERT INTO UnidadeOrcamentaria (IdUnidadeOrcamentaria, NomeUnidadeOrcamentaria)  --Preenchimento da tabela UnidadeOrcamentaria
SELECT CodigoUnidadeOrcamentaria, NomeUnidadeOrcamentaria
FROM CTE
WHERE rn = 1									--Pegando apenas os primeiros da sequencia criada anteriormente para evitar duplicadas
  AND NOT EXISTS (								--Verificadno se o valor já existe na tabela principal
      SELECT 1 FROM UnidadeOrcamentaria u
      WHERE u.IdUnidadeOrcamentaria = CTE.CodigoUnidadeOrcamentaria
  );


  WITH CTE AS (				--Criação de uma CTE para selecionar os dados necessários, e principalmente para a criação de um ROW_NUMBER que será usado para diferenciar os dados iguais dentro da tabela temporaria
    SELECT 
        CodigoProgramaOrcamentario,
        NomeProgramaOrcamentario,
        CodigoUnidadeOrcamentaria,
        ROW_NUMBER() OVER(PARTITION BY CodigoProgramaOrcamentario ORDER BY CodigoProgramaOrcamentario) AS rn  --Aqui estamos criando uma sequência contendo os valores repitidos da tabela. Para que em seu preenchimento não haja duplicatas de uma PK
    FROM ##temp_despesas_Convertido
    WHERE CodigoProgramaOrcamentario <> 0 AND CodigoUnidadeOrcamentaria <> 0																--Estamos excluindo os que contém '0' da consulta, porque são valores invalidos
)
INSERT INTO ProgramaOrcamentario (IdProgramaOrcamentario, NomeProgramaOrcamentario, IdUnidadeOrcamentaria)  --Preenchimento da tabela ProgramaOrcamentario
SELECT CodigoProgramaOrcamentario, NomeProgramaOrcamentario, CodigoUnidadeOrcamentaria
FROM CTE
WHERE rn = 1									--Pegando apenas os primeiros da sequencia criada anteriormente para evitar duplicadas
  AND NOT EXISTS (								--Verificadno se o valor já existe na tabela principal
      SELECT 1 FROM ProgramaOrcamentario p
      WHERE p.IdProgramaOrcamentario = CTE.CodigoProgramaOrcamentario
  );

  WITH CTE AS (				--Criação de uma CTE para selecionar os dados necessários, e principalmente para a criação de um ROW_NUMBER que será usado para diferenciar os dados iguais dentro da tabela temporaria
    SELECT 
        CodigoFuncao,
        NomeFuncao,
        ROW_NUMBER() OVER(PARTITION BY CodigoFuncao ORDER BY CodigoFuncao) AS rn  --Aqui estamos criando uma sequência contendo os valores repitidos da tabela. Para que em seu preenchimento não haja duplicatas de uma PK
    FROM ##temp_despesas_Convertido
    WHERE CodigoFuncao <> 0														--Estamos excluindo os que contém '0' da consulta, porque são valores invalidos
)
INSERT INTO Funcao (IdFuncao, NomeFuncao)  --Preenchimento da tabela Funcao
SELECT CodigoFuncao, NomeFuncao
FROM CTE
WHERE rn = 1									--Pegando apenas os primeiros da sequencia criada anteriormente para evitar duplicadas
  AND NOT EXISTS (								--Verificadno se o valor já existe na tabela principal
      SELECT 1 FROM Funcao f
      WHERE f.IdFuncao = CTE.CodigoFuncao
  );

  WITH CTE AS (				--Criação de uma CTE para selecionar os dados necessários, e principalmente para a criação de um ROW_NUMBER que será usado para diferenciar os dados iguais dentro da tabela temporaria
    SELECT 
        CodigoSubfuncao,
        NomeSubfuncao,
        CodigoFuncao,
        ROW_NUMBER() OVER(PARTITION BY CodigoSubfuncao ORDER BY CodigoSubfuncao) AS rn  --Aqui estamos criando uma sequência contendo os valores repitidos da tabela. Para que em seu preenchimento não haja duplicatas de uma PK
    FROM ##temp_despesas_Convertido
    WHERE CodigoSubfuncao <> 0 AND CodigoFuncao <> 0									--Estamos excluindo os que contém '0' da consulta, porque são valores invalidos
)
INSERT INTO SubFuncao (IdSubFuncao, NomeSubFuncao, IdFuncao)  --Preenchimento da tabela SubFuncao
SELECT CodigoSubfuncao, NomeSubfuncao, CodigoFuncao
FROM CTE
WHERE rn = 1									--Pegando apenas os primeiros da sequencia criada anteriormente para evitar duplicadas
  AND NOT EXISTS (								--Verificadno se o valor já existe na tabela principal
      SELECT 1 FROM SubFuncao s
      WHERE s.IdSubFuncao = CTE.CodigoSubfuncao
  );

  ;WITH CTE AS (				--Criação de uma CTE para selecionar os dados necessários, e principalmente para a criação de um ROW_NUMBER que será usado para diferenciar os dados iguais dentro da tabela temporaria
    SELECT 
        CodigoAcao,
        NomeAcao,
        ROW_NUMBER() OVER(PARTITION BY CodigoAcao ORDER BY CodigoAcao) AS rn  --Aqui estamos criando uma sequência contendo os valores repitidos da tabela. Para que em seu preenchimento não haja duplicatas de uma PK
    FROM ##temp_despesas_Convertido
    WHERE CodigoAcao <> '0'  														--Estamos excluindo os que contém '0' da consulta, porque são valores invalidos
)
INSERT INTO Acao (IdAcao, NomeAcao)  --Preenchimento da tabela Acao
SELECT CodigoAcao, NomeAcao
FROM CTE
WHERE rn = 1									--Pegando apenas os primeiros da sequencia criada anteriormente para evitar duplicadas
  AND NOT EXISTS (								--Verificadno se o valor já existe na tabela principal
      SELECT 1 
      FROM Acao a
      WHERE a.IdAcao = CTE.CodigoAcao
  );

INSERT INTO Despesas (				--Preenchimento da tabela despesas
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
    NULLIF(t.CodigoElementoDespesa,0),
    t.CodigoOrgaoSuperior,
    NULLIF(t.CodigoCategoriaEconomica,0),
    NULLIF(t.CodigoGestao, 0),		--caso esteja como '0', coloca NULL
    NULLIF(t.CodigoProgramaOrcamentario,0),   --caso esteja como '0', coloca NULL
    NULLIF(t.CodigoLocalizador,0),
    m.IdMandato, 
    t.CodigoAcao,
    NULLIF(t.CodigoFuncao,0)
FROM ##temp_despesas_Convertido t
JOIN Mandato m						--JOIN para saber qual o mandato daquela data
    ON t.AnoMesLancamento >= m.DataInicio
   AND (t.AnoMesLancamento <= m.DataFim OR m.DataFim IS NULL);
END
GO


CREATE PROCEDURE SP_CARREGA_PRESIDENTE		--Stored Procedure que preenche a tabela presisdente e mandato
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
   VALUES (1,'2015-01-01', '2016-08-31',1)

   INSERT INTO Mandato(IdMandato, DataInicio,DataFim,IdPresidente)
   VALUES (2,'2016-09-01', '2018-12-31',2)

   INSERT INTO Mandato(IdMandato, DataInicio,DataFim,IdPresidente)
   VALUES (3,'2019-01-01', '2022-12-31',3)

   INSERT INTO Mandato(IdMandato, DataInicio,DataFim,IdPresidente)
   VALUES (4,'2023-01-01', NULL,4)

END
GO

CREATE PROCEDURE SP_ETL_DESPESAS			--Stored Procedure que executa as SP de ETL despesa
@CAMINHO_CSV VARCHAR(150)
AS
BEGIN
EXEC SP_EXTRAI_CSV_DESPESAS @CAMINHO = @CAMINHO_CSV
EXEC SP_TRATA_CSV_DESPESAS
EXEC SP_CARREGA_CSV_DESPESAS
IF OBJECT_ID('tempdb..##temp_despesas_Convertido') IS NOT NULL
DROP TABLE ##temp_despesas_Convertido;
IF OBJECT_ID('tempdb..##temp_depesas') IS NOT NULL
DROP TABLE ##temp_depesas;

END
GO
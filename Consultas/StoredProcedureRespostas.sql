-- Pergunta sobre investimentos por funcao

CREATE PROCEDURE sp_PerguntaMaioresNumerosFuncao
AS
BEGIN
SELECT NomePresidente, NomeFuncao,
SUM(TotalPago) AS TotalInvestido
FROM vw_DespesasPorMandatoFuncao
WHERE NomeFuncao IN ('Ciência e Tecnologia', 'Saúde', 'Educação', 'Segurança Pública')
GROUP BY NomePresidente, NomeFuncao
ORDER BY NomeFuncao, TotalInvestido DESC;
END;

-- Pergunta sobre aumento de despesas durante anos eleitorais

CREATE PROCEDURE sp_AumentoAnosEleitorais
AS
BEGIN
SET NOCOUNT ON;
WITH Totais AS ( 
SELECT IdMandato, NomePresidente, Ano, 
SUM(TotalPago) AS TotalPago
FROM vw_DespesasPorAnoMandato
GROUP BY IdMandato, NomePresidente, Ano
),
Comparacao AS
( SELECT t1.IdMandato, t1.NomePresidente, 
t1.Ano AS AnoEleitoral, 
t1.TotalPago AS TotalAnoEleitoral, 
t2.TotalPago AS TotalAnoAnterior,
CASE WHEN t2.TotalPago IS NULL OR t2.TotalPago = 0 THEN NULL
ELSE ((t1.TotalPago - t2.TotalPago) / t2.TotalPago) * 100
END AS PercentualAumento
FROM Totais t1
LEFT JOIN Totais t2 
ON t1.IdMandato = t2.IdMandato 
AND t1.Ano = t2.Ano + 1
WHERE t1.Ano IN (2018, 2022)
)
SELECT * 
FROM Comparacao
WHERE PercentualAumento IS NOT NULL
ORDER BY PercentualAumento DESC;
END;


-- Pergunta sobre gastos com cartão de pagamento do governo federal

CREATE PROCEDURE sp_MaioresGastosCartao
AS 
BEGIN
SELECT IdMandato, NomePresidente,
SUM(TotalGastoCartao)
FROM vw_CartaoPorMandato
GROUP BY IdMandato, NomePresidente
ORDER BY SUM(TotalGastoCartao) DESC;
END;


-- Pergunta sobre gastos com cartão de pagamento do governo federal

CREATE PROCEDURE sp_MaioresGastosViagens
AS
BEGIN
SELECT NomePresidente, SUM(ValorGasto) AS TotalGastoViagens,
COUNT(IdViagem) AS QuantidadeViagens
FROM vw_ViagemPresidenteGastos
GROUP BY NomePresidente
ORDER BY SUM(ValorGasto) DESC;
END;

-- Setores com redução ou aumento orçamentário

CREATE PROCEDURE sp_VariacaoOrcamentariaPorMandatoAno
@NomePresidente NVARCHAR(100) = NULL,
@NomeFuncao NVARCHAR(100) = NULL
AS
BEGIN
WITH Totais AS ( SELECT IdMandato, NomePresidente, NomeFuncao, Ano,
SUM(TotalPago) AS TotalPago
FROM vw_DespesasPorFuncaoAno
GROUP BY IdMandato, NomePresidente, NomeFuncao, Ano ),

Comparacao AS ( SELECT t1.IdMandato, t1.NomePresidente, t1.NomeFuncao, t1.Ano AS AnoBase,
t2.Ano AS AnoComparado, t1.TotalPago AS TotalAnoBase, t2.TotalPago AS TotalAnoComparado,
CASE 
WHEN ISNULL(t1.TotalPago,0) = 0 THEN NULL
ELSE ((ISNULL(t2.TotalPago,0) - t1.TotalPago) / t1.TotalPago) * 100
END AS PercentualVariacao
FROM Totais t1
JOIN Totais t2 ON t1.IdMandato = t2.IdMandato AND t1.NomeFuncao = t2.NomeFuncao AND t2.Ano = t1.Ano + 1)

SELECT IdMandato, NomePresidente, NomeFuncao, AnoBase, AnoComparado, TotalAnoBase, TotalAnoComparado, PercentualVariacao
FROM Comparacao
WHERE (@NomePresidente IS NULL OR NomePresidente = @NomePresidente) AND (@NomeFuncao IS NULL OR NomeFuncao = @NomeFuncao)
ORDER BY IdMandato, NomeFuncao, AnoBase;
END;

-- Impacto da pandemia da COVID-19 nos padrões de gasto público

CREATE PROCEDURE sp_PandemiaCovid
AS
BEGIN
WITH AntesPandemia AS (
SELECT NomeFuncao,
SUM(TotalPago) AS TotalAntes
FROM vw_DespesasCOVID
WHERE Ano = 2019
GROUP BY NomeFuncao
),
DurantePandemia AS (
SELECT NomeFuncao,
SUM(TotalPago) AS TotalPandemia
FROM vw_DespesasCOVID
WHERE Ano IN (2020,2021)
GROUP BY NomeFuncao
)
SELECT COALESCE(p.NomeFuncao, d.NomeFuncao) AS NomeFuncao,
ISNULL(p.TotalAntes,0) AS TotalPrePandemia,
ISNULL(d.TotalPandemia,0) AS TotalDurantePandemia,
CASE WHEN ISNULL(p.TotalAntes,0) = 0 THEN NULL
ELSE ((ISNULL(d.TotalPandemia,0) - p.TotalAntes) / p.TotalAntes) * 100
END AS PercentualVariacao
FROM AntesPandemia p
FULL JOIN DurantePandemia d ON p.NomeFuncao = d.NomeFuncao
ORDER BY PercentualVariacao DESC;
END;

Select * From Despesas
SELECT DISTINCT Ano FROM vw_DespesasCOVID;


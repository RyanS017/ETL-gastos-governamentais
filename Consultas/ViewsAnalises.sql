-- Base para perguntas sobre Ciência e Tecnologia, Saúde, Educação, Segurança Pública. (Exemplo: SELECT * FROM vw_DespesasPorMandatoFuncao WHERE NomeFuncao = 'Ciência e Tecnologia')
CREATE VIEW vw_DespesasPorMandatoFuncao
AS
SELECT p.NomePresidente, m.IdMandato, m.DataInicio, m.DataFim, f.NomeFuncao,
YEAR(d.DataLancamento) AS Ano, 
SUM(d.ValorPago) AS TotalPago
FROM Despesas d
JOIN Funcao f ON d.IdFuncao = f.IdFuncao
JOIN Mandato m ON d.IdMandato = m.IdMandato
JOIN Presidente p ON m.IdPresidente = p.IdPresidente
GROUP BY p.NomePresidente, m.IdMandato, m.DataInicio, m.DataFim, f.NomeFuncao, YEAR(d.DataLancamento);

SELECT * FROM vw_DespesasPorMandatoFuncao where NomeFuncao = 'Educação'

-- Base para análises de anos eleitorais 
CREATE VIEW vw_DespesasPorAnoMandato
AS 
SELECT m.IdMandato, p.NomePresidente,
YEAR(d.DataLancamento) AS Ano,
SUM(d.ValorPago) AS TotalPago
FROM Despesas d
JOIN Mandato m    ON d.IdMandato = m.IdMandato
JOIN Presidente p ON m.IdPresidente = p.IdPresidente
GROUP BY m.IdMandato, p.NomePresidente, YEAR(d.DataLancamento);


-- Base para gastos com Cartão de Pagamento do Governo Federal
CREATE VIEW vw_CartaoPorMandato
AS
SELECT p.NomePresidente, m.IdMandato,
YEAR(gc.DataTransacao) AS Ano,
SUM(gc.ValorTransacao) AS TotalGastoCartao
FROM GastosCartao gc
JOIN Mandato m    ON gc.IdMandato = m.IdMandato
JOIN Presidente p ON m.IdPresidente = p.IdPresidente
GROUP BY p.NomePresidente, m.IdMandato, YEAR(gc.DataTransacao);


-- Base para maiores gastos com viagens
CREATE VIEW vw_ViagemPresidenteGastos
AS
SELECT v.IdViagem, v.PeriodoInicio, v.PeriodoFim, v.Gastos AS ValorGasto, p.NomePresidente
FROM Viagem v
JOIN Mandato m
ON (CAST(v.PeriodoInicio AS DATE) <= ISNULL(m.DataFim, '9999-12-31')
AND CAST(v.PeriodoFim AS DATE) >= m.DataInicio)
JOIN Presidente p ON m.IdPresidente = p.IdPresidente;


-- Base para redução ou aumento orçamentário. 
CREATE VIEW vw_DespesasPorFuncaoAno
AS
SELECT f.NomeFuncao, m.IdMandato, p.NomePresidente,
YEAR(d.DataLancamento) AS Ano,
SUM(d.ValorPago) AS TotalPago
FROM Despesas d
JOIN Funcao f ON d.IdFuncao = f.IdFuncao
JOIN Mandato m ON d.IdMandato = m.IdMandato
JOIN Presidente p ON m.IdPresidente = p.IdPresidente
GROUP BY f.NomeFuncao, m.IdMandato, p.NomePresidente, YEAR(d.DataLancamento);


-- Base para análises de impacto da pandemia.
CREATE VIEW vw_DespesasCOVID
AS
SELECT f.NomeFuncao,
YEAR(d.DataLancamento) AS Ano,
SUM(d.ValorPago) AS TotalPago
FROM Despesas d
JOIN Funcao f ON d.IdFuncao = f.IdFuncao
WHERE YEAR(d.DataLancamento) BETWEEN 2020 AND 2022
GROUP BY f.NomeFuncao, YEAR(d.DataLancamento);
-- Retorna a quantidade de registros com IdMandato não nulo mas sem correspondência em Mandato.
SELECT COUNT(*) AS QtdeSemMandato
FROM Despesas d
LEFT JOIN Mandato m ON d.IdMandato = m.IdMandato
WHERE d.IdMandato IS NOT NULL AND m.IdMandato IS NULL;


-- GastosCartao com IdOrgaoSuperior inexistente
SELECT COUNT(*) AS QtdeGastosCartaoSemOrgaoSuperior
FROM GastosCartao gc
LEFT JOIN OrgaoSuperior os ON gc.IdOrgaoSuperior = os.IdOrgaoSuperior
WHERE gc.IdOrgaoSuperior IS NOT NULL AND os.IdOrgaoSuperior IS NULL;


-- Totais básicos de Despesas por Presidente por Despesas, Mandato e Presidente, para garantir que os vínculos estão corretos.
SELECT p.NomePresidente,
SUM(d.ValorEmpenhado) AS TotalEmpenhado,
SUM(d.ValorPago) AS TotalPago
FROM Despesas d
JOIN Mandato m ON d.IdMandato = m.IdMandato
JOIN Presidente p ON m.IdPresidente = p.IdPresidente
GROUP BY p.NomePresidente
ORDER BY TotalPago DESC;


-- Verificar duplicidade de nomes na dimensão Funcao. O ideal é que cada função apareça apenas uma vez (Educação, Saúde, etc.)
SELECT NomeFuncao, COUNT(*) AS Qtde
FROM Funcao
GROUP BY NomeFuncao
HAVING COUNT(*) > 1;


-- Procurar duplicidade no identificador de despesas
SELECT IdDespesas, COUNT(*) AS Qtde
FROM Despesas
GROUP BY IdDespesas
HAVING COUNT(*) > 1;


-- Procurar duplicidade no identificador de GastosCartao
SELECT IdGastosCartao, COUNT(*) AS Qtde
FROM GastosCartao
GROUP BY IdGastosCartao
HAVING COUNT(*) > 1;


-- Transações cujo mês/ano da DataTransacao não coincide com mês/ano do DataExtrato
SELECT  gc.IdGastosCartao, gc.DataTransacao, gc.DataExtrato, gc.ValorTransacao
FROM GastosCartao gc
WHERE YEAR(gc.DataTransacao) <> YEAR(gc.DataExtrato) OR MONTH(gc.DataTransacao) <> MONTH(gc.DataExtrato);


-- Lista despesas em que ValorPago > ValorLiquido,
SELECT d.IdDespesas, d.[DataLancamento], d.ValorLiquido, d.ValorPago, ed.NomeElementoDespesa, os.NomeOrgaoSuperior, p.NomeProgramaOrcamentario, f.NomeFuncao
FROM Despesas d
JOIN ElementoDespesa ed   ON d.IdElementoDespesa = ed.IdElementoDespesa
JOIN OrgaoSuperior os     ON d.IdOrgaoSuperior   = os.IdOrgaoSuperior
JOIN ProgramaOrcamentario p ON d.IdProgramaOrcamentario = p.IdProgramaOrcamentario
JOIN Funcao f             ON d.IdFuncao          = f.IdFuncao
WHERE d.ValorPago > d.ValorLiquido
ORDER BY d.ValorPago - d.ValorLiquido DESC;



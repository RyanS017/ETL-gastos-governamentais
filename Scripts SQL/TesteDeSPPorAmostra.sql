USE ProjetoGastosGovernamentais
GO

EXEC SP_CARREGA_PRESIDENTE
GO


--Caso queria executar trocar o @CAMINHO_CSV pelo caminho do csv que est� em sua maquina
EXEC SP_ETL_CARTAO @CAMINHO_CSV = 'C:\Users\Leandro Felix\Documents\ETL-dados-governamentais\dataset\Cart�o de Pagamento\2015\201501_CPGF\201501_CPGF.csv'
GO

EXEC SP_ETL_DESPESAS @CAMINHO_CSV = 'C:\Users\Leandro Felix\Documents\ETL-dados-governamentais\dataset\Execu��o da Despesa\2022\202201_Despesas.csv'
GO

SELECT *
FROM Despesas
GO

SELECT *
FROM GastosCartao
GO




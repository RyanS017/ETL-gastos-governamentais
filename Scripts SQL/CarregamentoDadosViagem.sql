Use ProjetoGastosGovernamentais
GO


-- Trocar o caminho pelo caminho de sua maquina
DECLARE @CaminhoBase VARCHAR(200) = 
    'C:\Users\rapha\Documents\ETL-dados-governamentais\dataset\Viagens\'

DECLARE @CaminhoCompleto VARCHAR(300)
------------------------
-- ANO 2015
------------------------
SET @CaminhoCompleto = @CaminhoBase + '2015\2015_Viagem.csv'
EXEC SP_ETL_VIAGEM @CAMINHO_CSV = @CaminhoCompleto

SET @CaminhoCompleto = @CaminhoBase + '2015\2015_Pagamento.csv'
EXEC SP_ETL_PAGAMENTO @CAMINHO_CSV = @CaminhoCompleto

SET @CaminhoCompleto = @CaminhoBase + '2015\2015_Passagem.csv'
EXEC SP_ETL_PASSAGEM @CAMINHO_CSV = @CaminhoCompleto

------------------------
-- ANO 2016
------------------------
SET @CaminhoCompleto = @CaminhoBase + '2016\2016_Viagem.csv'
EXEC SP_ETL_VIAGEM @CAMINHO_CSV = @CaminhoCompleto

SET @CaminhoCompleto = @CaminhoBase + '2016\2016_Pagamento.csv'
EXEC SP_ETL_PAGAMENTO @CAMINHO_CSV = @CaminhoCompleto

SET @CaminhoCompleto = @CaminhoBase + '2016\2016_Passagem.csv'
EXEC SP_ETL_PASSAGEM @CAMINHO_CSV = @CaminhoCompleto

------------------------
-- ANO 2017
------------------------
SET @CaminhoCompleto = @CaminhoBase + '2017\2017_Viagem.csv'
EXEC SP_ETL_VIAGEM @CAMINHO_CSV = @CaminhoCompleto

SET @CaminhoCompleto = @CaminhoBase + '2017\2017_Pagamento.csv'
EXEC SP_ETL_PAGAMENTO @CAMINHO_CSV = @CaminhoCompleto

SET @CaminhoCompleto = @CaminhoBase + '2017\2017_Passagem.csv'
EXEC SP_ETL_PASSAGEM @CAMINHO_CSV = @CaminhoCompleto

------------------------
-- ANO 2018
------------------------
SET @CaminhoCompleto = @CaminhoBase + '2018\2018_Viagem.csv'
EXEC SP_ETL_VIAGEM @CAMINHO_CSV = @CaminhoCompleto

SET @CaminhoCompleto = @CaminhoBase + '2018\2018_Pagamento.csv'
EXEC SP_ETL_PAGAMENTO @CAMINHO_CSV = @CaminhoCompleto

SET @CaminhoCompleto = @CaminhoBase + '2018\2018_Passagem.csv'
EXEC SP_ETL_PASSAGEM @CAMINHO_CSV = @CaminhoCompleto

------------------------
-- ANO 2019
------------------------
SET @CaminhoCompleto = @CaminhoBase + '2019\2019_Viagem.csv'
EXEC SP_ETL_VIAGEM @CAMINHO_CSV = @CaminhoCompleto

SET @CaminhoCompleto = @CaminhoBase + '2019\2019_Pagamento.csv'
EXEC SP_ETL_PAGAMENTO @CAMINHO_CSV = @CaminhoCompleto

SET @CaminhoCompleto = @CaminhoBase + '2019\2019_Passagem.csv'
EXEC SP_ETL_PASSAGEM @CAMINHO_CSV = @CaminhoCompleto

------------------------
-- ANO 2020
------------------------
SET @CaminhoCompleto = @CaminhoBase + '2020\2020_Viagem.csv'
EXEC SP_ETL_VIAGEM @CAMINHO_CSV = @CaminhoCompleto

SET @CaminhoCompleto = @CaminhoBase + '2020\2020_Pagamento.csv'
EXEC SP_ETL_PAGAMENTO @CAMINHO_CSV = @CaminhoCompleto

SET @CaminhoCompleto = @CaminhoBase + '2020\2020_Passagem.csv'
EXEC SP_ETL_PASSAGEM @CAMINHO_CSV = @CaminhoCompleto

------------------------
-- ANO 2021
------------------------
SET @CaminhoCompleto = @CaminhoBase + '2021\2021_Viagem.csv'
EXEC SP_ETL_VIAGEM @CAMINHO_CSV = @CaminhoCompleto

SET @CaminhoCompleto = @CaminhoBase + '2021\2021_Pagamento.csv'
EXEC SP_ETL_PAGAMENTO @CAMINHO_CSV = @CaminhoCompleto

SET @CaminhoCompleto = @CaminhoBase + '2021\2021_Passagem.csv'
EXEC SP_ETL_PASSAGEM @CAMINHO_CSV = @CaminhoCompleto

------------------------
-- ANO 2022
------------------------
SET @CaminhoCompleto = @CaminhoBase + '2022\2022_Viagem.csv'
EXEC SP_ETL_VIAGEM @CAMINHO_CSV = @CaminhoCompleto

SET @CaminhoCompleto = @CaminhoBase + '2022\2022_Pagamento.csv'
EXEC SP_ETL_PAGAMENTO @CAMINHO_CSV = @CaminhoCompleto

SET @CaminhoCompleto = @CaminhoBase + '2022\2022_Passagem.csv'
EXEC SP_ETL_PASSAGEM @CAMINHO_CSV = @CaminhoCompleto

------------------------
-- ANO 2023
------------------------
SET @CaminhoCompleto = @CaminhoBase + '2023\2023_Viagem.csv'
EXEC SP_ETL_VIAGEM @CAMINHO_CSV = @CaminhoCompleto

SET @CaminhoCompleto = @CaminhoBase + '2023\2023_Pagamento.csv'
EXEC SP_ETL_PAGAMENTO @CAMINHO_CSV = @CaminhoCompleto

SET @CaminhoCompleto = @CaminhoBase + '2023\2023_Passagem.csv'
EXEC SP_ETL_PASSAGEM @CAMINHO_CSV = @CaminhoCompleto

------------------------
-- ANO 2024
------------------------
SET @CaminhoCompleto = @CaminhoBase + '2024\2024_Viagem.csv'
EXEC SP_ETL_VIAGEM @CAMINHO_CSV = @CaminhoCompleto

SET @CaminhoCompleto = @CaminhoBase + '2024\2024_Pagamento.csv'
EXEC SP_ETL_PAGAMENTO @CAMINHO_CSV = @CaminhoCompleto

SET @CaminhoCompleto = @CaminhoBase + '2024\2024_Passagem.csv'
EXEC SP_ETL_PASSAGEM @CAMINHO_CSV = @CaminhoCompleto
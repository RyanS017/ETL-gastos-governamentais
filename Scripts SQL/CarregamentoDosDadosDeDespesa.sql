USE ProjetoGastosGovernamentais
GO

EXEC SP_CARREGA_PRESIDENTE
GO


--Troque esse caminho pelo que esta em sua maquina
DECLARE @CaminhoBase VARCHAR(200) = 
    'C:\Users\rapha\Documents\ETL-dados-governamentais\dataset\Execução da Despesa\'

DECLARE @CaminhoCompleto VARCHAR(300)
------------------------
-- ANO 2015
------------------------
SET @CaminhoCompleto = @CaminhoBase + '2015\201501_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2015\201502_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2015\201503_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2015\201504_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2015\201505_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2015\201506_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2015\201507_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2015\201508_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2015\201509_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2015\201510_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2015\201511_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2015\201512_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto

------------------------
-- ANO 2016
------------------------
SET @CaminhoCompleto = @CaminhoBase + '2016\201601_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2016\201602_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2016\201603_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2016\201604_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2016\201605_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2016\201606_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2016\201607_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2016\201608_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2016\201609_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2016\201610_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2016\201611_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2016\201612_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto

------------------------
-- ANO 2017
------------------------
SET @CaminhoCompleto = @CaminhoBase + '2017\201701_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2017\201702_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2017\201703_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2017\201704_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2017\201705_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2017\201706_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2017\201707_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2017\201708_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2017\201709_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2017\201710_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2017\201711_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2017\201712_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto

------------------------
-- ANO 2018
------------------------
SET @CaminhoCompleto = @CaminhoBase + '2018\201801_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2018\201802_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2018\201803_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2018\201804_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2018\201805_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2018\201806_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2018\201807_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2018\201808_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2018\201809_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2018\201810_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2018\201811_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2018\201812_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto


----2019

SET @CaminhoCompleto = @CaminhoBase + '2019\201901_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2019\201902_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2019\201903_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2019\201904_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2019\201905_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2019\201906_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2019\201907_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2019\201908_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2019\201909_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2019\201910_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2019\201911_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2019\201912_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto

------------------------
-- ANO 2020
------------------------
SET @CaminhoCompleto = @CaminhoBase + '2020\202001_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2020\202002_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2020\202003_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2020\202004_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2020\202005_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2020\202006_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2020\202007_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2020\202008_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2020\202009_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2020\202010_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2020\202011_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2020\202012_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto

------------------------
-- ANO 2021
------------------------
SET @CaminhoCompleto = @CaminhoBase + '2021\202101_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2021\202102_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2021\202103_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2021\202104_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2021\202105_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2021\202106_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2021\202107_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2021\202108_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2021\202109_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2021\202110_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2021\202111_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2021\202112_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto

DELETE FROM Despesas
------------------------
-- ANO 2022
------------------------
SET @CaminhoCompleto = @CaminhoBase + '2022\202201_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2022\202202_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2022\202203_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2022\202204_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2022\202205_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2022\202206_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2022\202207_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2022\202208_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2022\202209_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2022\202210_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2022\202211_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2022\202212_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto

------------------------
-- ANO 2023
------------------------
SET @CaminhoCompleto = @CaminhoBase + '2023\202301_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2023\202302_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2023\202303_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2023\202304_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2023\202305_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2023\202306_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2023\202307_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2023\202308_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2023\202309_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2023\202310_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2023\202311_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2023\202312_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto

------------------------
-- ANO 2024
------------------------
SET @CaminhoCompleto = @CaminhoBase + '2024\202401_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2024\202402_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2024\202403_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2024\202404_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2024\202405_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2024\202406_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2024\202407_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2024\202408_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2024\202409_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2024\202410_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2024\202411_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2024\202412_Despesas.csv'
EXEC SP_ETL_DESPESAS @CAMINHO_CSV = @CaminhoCompleto
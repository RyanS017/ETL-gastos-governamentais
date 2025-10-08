USE ProjetoGastosGovernamentais
GO

--Coloque o caminho da sua maquina na variavel
DECLARE @CaminhoBase VARCHAR(200) = 
    'C:\Users\Leandro Felix\Documents\ETL-dados-governamentais\dataset\Cart�o de Pagamento\'

DECLARE @CaminhoCompleto VARCHAR(300)
------------------------
-- ANO 2015
------------------------
SET @CaminhoCompleto = @CaminhoBase + '2015\201501_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2015\201502_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2015\201503_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2015\201504_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2015\201505_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2015\201506_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2015\201507_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2015\201508_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2015\201509_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2015\201510_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2015\201511_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2015\201512_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto

------------------------
-- ANO 2016
------------------------
SET @CaminhoCompleto = @CaminhoBase + '2016\201601_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2016\201602_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2016\201603_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2016\201604_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2016\201605_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2016\201606_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2016\201607_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2016\201608_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2016\201609_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2016\201610_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2016\201611_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2016\201612_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto

------------------------
-- ANO 2017
------------------------
SET @CaminhoCompleto = @CaminhoBase + '2017\201701_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2017\201702_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2017\201703_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2017\201704_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2017\201705_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2017\201706_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2017\201707_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2017\201708_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2017\201709_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2017\201710_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2017\201711_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2017\201712_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto

------------------------
-- ANO 2018
------------------------
SET @CaminhoCompleto = @CaminhoBase + '2018\201801_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2018\201802_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2018\201803_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2018\201804_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2018\201805_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2018\201806_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2018\201807_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2018\201808_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2018\201809_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2018\201810_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2018\201811_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2018\201812_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto

------------------------
-- ANO 2019
------------------------
SET @CaminhoCompleto = @CaminhoBase + '2019\201901_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2019\201902_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2019\201903_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2019\201904_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2019\201905_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2019\201906_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2019\201907_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2019\201908_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2019\201909_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2019\201910_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2019\201911_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2019\201912_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto

------------------------
-- ANO 2020
------------------------
SET @CaminhoCompleto = @CaminhoBase + '2020\202001_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2020\202002_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2020\202003_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2020\202004_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2020\202005_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2020\202006_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2020\202007_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2020\202008_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2020\202009_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2020\202010_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2020\202011_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2020\202012_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto

------------------------
-- ANO 2021
------------------------
SET @CaminhoCompleto = @CaminhoBase + '2021\202101_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2021\202102_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2021\202103_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2021\202104_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2021\202105_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2021\202106_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2021\202107_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2021\202108_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2021\202109_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2021\202110_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2021\202111_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2021\202112_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto

------------------------
-- ANO 2022
------------------------
SET @CaminhoCompleto = @CaminhoBase + '2022\202201_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2022\202202_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2022\202203_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2022\202204_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2022\202205_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2022\202206_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2022\202207_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2022\202208_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2022\202209_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2022\202210_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2022\202211_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2022\202212_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto

------------------------
-- ANO 2023
------------------------
SET @CaminhoCompleto = @CaminhoBase + '2023\202301_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2023\202302_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2023\202303_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2023\202304_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2023\202305_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2023\202306_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2023\202307_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2023\202308_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2023\202309_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2023\202310_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2023\202311_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2023\202312_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto

------------------------
-- ANO 2024
------------------------
SET @CaminhoCompleto = @CaminhoBase + '2024\202401_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2024\202402_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2024\202403_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2024\202404_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2024\202405_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2024\202406_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2024\202407_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2024\202408_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2024\202409_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2024\202410_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2024\202411_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
SET @CaminhoCompleto = @CaminhoBase + '2024\202412_CPGF.csv'
EXEC SP_ETL_CARTAO @CAMINHO_CSV = @CaminhoCompleto
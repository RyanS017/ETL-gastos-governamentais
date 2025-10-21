USE ProjetoGastosGovernamentais;
GO

-- Criação das Roles
CREATE ROLE ProfileVisualizadorViews AUTHORIZATION dbo;
CREATE ROLE ProfileAnalistaAvancado AUTHORIZATION dbo;
CREATE ROLE ProfileDesenvolvedorFullAccess AUTHORIZATION dbo;
GO

-- VISUALIZADOR: acesso apenas a views (SELECT)

GRANT SELECT ON OBJECT::dbo.vw_CartaoPorMandato TO ProfileVisualizadorViews;
GRANT SELECT ON OBJECT::dbo.vw_DespesasCOVID TO ProfileVisualizadorViews;
GRANT SELECT ON OBJECT::dbo.vw_DespesasPorAnoMandato TO ProfileVisualizadorViews;
GRANT SELECT ON OBJECT::dbo.vw_DespesasPorFuncaoAno TO ProfileVisualizadorViews;
GRANT SELECT ON OBJECT::dbo.vw_DespesasPorMandatoFuncao TO ProfileVisualizadorViews;
GRANT SELECT ON OBJECT::dbo.vw_ViagemPresidenteGastos TO ProfileVisualizadorViews;
GO

-- ANALISTA: acesso às views + EXECUTE em stored procedures

GRANT SELECT ON OBJECT::dbo.vw_CartaoPorMandato TO ProfileAnalistaAvancado;
GRANT SELECT ON OBJECT::dbo.vw_DespesasCOVID TO ProfileAnalistaAvancado;
GRANT SELECT ON OBJECT::dbo.vw_DespesasPorAnoMandato TO ProfileAnalistaAvancado;
GRANT SELECT ON OBJECT::dbo.vw_DespesasPorFuncaoAno TO ProfileAnalistaAvancado;
GRANT SELECT ON OBJECT::dbo.vw_DespesasPorMandatoFuncao TO ProfileAnalistaAvancado;
GRANT SELECT ON OBJECT::dbo.vw_ViagemPresidenteGastos TO ProfileAnalistaAvancado;

GRANT EXECUTE ON OBJECT::dbo.sp_PerguntaInvestimentosFuncao TO ProfileAnalistaAvancado;
GRANT EXECUTE ON OBJECT::dbo.sp_AumentoAnosEleitorais TO ProfileAnalistaAvancado;
GRANT EXECUTE ON OBJECT::dbo.sp_MaioresGastosCartao TO ProfileAnalistaAvancado;
GRANT EXECUTE ON OBJECT::dbo.sp_MaioresGastosViagens TO ProfileAnalistaAvancado;
GRANT EXECUTE ON OBJECT::dbo.sp_VariacaoOrcamentariaPorFuncao TO ProfileAnalistaAvancado;
GRANT EXECUTE ON OBJECT::dbo.sp_PandemiaCovid TO ProfileAnalistaAvancado;
GO


-- DESENVOLVEDOR: acesso total (membro de db_owner)

ALTER ROLE db_owner ADD MEMBER ProfileDesenvolvedorFullAccess;
GO

-- Criação dos Usuários (mapeando para logins)

CREATE USER User_Visualizador FOR LOGIN Login_Visualizador;
ALTER ROLE ProfileVisualizadorViews ADD MEMBER User_Visualizador;

CREATE USER User_Analista FOR LOGIN Login_Analista;
ALTER ROLE ProfileAnalistaAvancado ADD MEMBER User_Analista;

CREATE USER User_Desenvolvedor FOR LOGIN Login_Desenvolvedor;
ALTER ROLE ProfileDesenvolvedorFullAccess ADD MEMBER User_Desenvolvedor;
GO

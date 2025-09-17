CREATE DATABASE ProjetoGastosGovernamentais
GO

USE ProjetoGastosGovernamentais
GO

CREATE TABLE OrgaoSuperior (
    IdOrgaoSuperior INT PRIMARY KEY,
    NomeOrgaoSuperior VARCHAR(150) NOT NULL
);

CREATE TABLE OrgaoSubordinado (
    IdOrgaoSubordinado INT PRIMARY KEY,
    NomeOrgaoSubordinado VARCHAR(150) NOT NULL,
    IdOrgaoSuperior INT NOT NULL,
    FOREIGN KEY (IdOrgaoSuperior) REFERENCES OrgaoSuperior(IdOrgaoSuperior)
);

CREATE TABLE Gestao (
    IdGestao INT PRIMARY KEY,
    NomeGestao VARCHAR(150) NOT NULL,
);

CREATE TABLE UnidadeGestora (
    IdUnidadeGestora INT PRIMARY KEY,
    NomeUnidadeGestora VARCHAR(150) NOT NULL,
    IdOrgaoSuperior INT NOT NULL,
	IdGestao INT NULL,
    FOREIGN KEY (IdOrgaoSuperior) REFERENCES OrgaoSuperior(IdOrgaoSuperior),
	FOREIGN KEY (IdGestao) REFERENCES Gestao(IdGestao)
);




CREATE TABLE GrupoDespesa (
    IdGrupoDespesa INT PRIMARY KEY,
    NomeGrupoDespesa VARCHAR(150) NOT NULL
);

CREATE TABLE CategoriaEconomica (
    IdCategoriaEconomica INT PRIMARY KEY,
    NomeCategoriaEconomica VARCHAR(150) NOT NULL,
    IdGrupoDespesa INT NOT NULL,
    FOREIGN KEY (IdGrupoDespesa) REFERENCES GrupoDespesa(IdGrupoDespesa)
);

CREATE TABLE ModalidadeDespesa (
    IdModalidadeDespesa INT PRIMARY KEY,
    NomeModalidadeDespesa VARCHAR(150) NOT NULL,
    IdGrupoDespesa INT NOT NULL,
    FOREIGN KEY (IdGrupoDespesa) REFERENCES GrupoDespesa(IdGrupoDespesa)
);

CREATE TABLE ElementoDespesa (
    IdElementoDespesa INT PRIMARY KEY,
    NomeElementoDespesa VARCHAR(150) NOT NULL,
    IdGrupoDespesa INT NOT NULL,
    FOREIGN KEY (IdGrupoDespesa) REFERENCES GrupoDespesa(IdGrupoDespesa)
);

CREATE TABLE Localizador (
    IdLocalizador INT PRIMARY KEY,
    NomeLocalizador VARCHAR(150) NOT NULL,
    SiglaLocalizador VARCHAR(10) NULL,
    DescricaoComplementarLocalizador VARCHAR(255) NULL
);

CREATE TABLE UnidadeOrcamentaria (
    IdUnidadeOrcamentaria INT PRIMARY KEY,
    NomeUnidadeOrcamentaria VARCHAR(150) NOT NULL
);

CREATE TABLE ProgramaOrcamentario (
    IdProgramaOrcamentario INT PRIMARY KEY,
    NomeProgramaOrcamentario VARCHAR(150) NOT NULL,
    IdUnidadeOrcamentaria INT NOT NULL,
    FOREIGN KEY (IdUnidadeOrcamentaria) REFERENCES UnidadeOrcamentaria(IdUnidadeOrcamentaria)
);

CREATE TABLE Funcao (
    IdFuncao INT PRIMARY KEY,
    NomeFuncao VARCHAR(150) NOT NULL
);

CREATE TABLE SubFuncao (
    IdSubFuncao INT PRIMARY KEY,
    NomeSubFuncao VARCHAR(150) NOT NULL,
    IdFuncao INT NOT NULL,
    FOREIGN KEY (IdFuncao) REFERENCES Funcao(IdFuncao)
);

CREATE TABLE Acao (
    IdAcao VARCHAR(10) PRIMARY KEY,
    NomeAcao VARCHAR(150) NOT NULL
);

CREATE TABLE Presidente (
    IdPresidente INT PRIMARY KEY,
    NomePresidente VARCHAR(150) NOT NULL,
);

CREATE TABLE Mandato (
    IdMandato INT PRIMARY KEY,
    DataInicio DATE NOT NULL,
    DataFim DATE NULL, 
    IdPresidente INT NOT NULL,
    FOREIGN KEY (IdPresidente) REFERENCES Presidente(IdPresidente)
);

CREATE TABLE Despesas (
    IdDespesas BIGINT IDENTITY(1,1) PRIMARY KEY,
    DataLancamento DATE NOT NULL,
    UF CHAR(2) NOT NULL CHECK (UF IN (
        'AC','AL','AP','AM','BA','CE','DF','ES','GO','MA',
        'MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN',
        'RS','RO','RR','SC','SP','SE','TO', ''
    )),
    Municipio VARCHAR(150) NULL,
    ValorEmpenhado DECIMAL(18,2) NOT NULL DEFAULT 0,
    ValorLiquido DECIMAL(18,2) NOT NULL DEFAULT 0,
    ValorPago DECIMAL(18,2) NOT NULL DEFAULT 0,
    ValorRestosAPagarInscritos DECIMAL(18,2) NOT NULL DEFAULT 0,
    ValorRestosAPagarCancelados DECIMAL(18,2) NOT NULL DEFAULT 0,

    IdElementoDespesa INT NOT NULL,
    IdOrgaoSuperior INT NOT NULL,
    IdCategoriaEconomica INT NOT NULL,
    IdGestao INT NULL,
    IdProgramaOrcamentario INT NOT NULL,
    IdLocalizador INT NULL,
    IdMandato INT NOT NULL,
    IdAcao VARCHAR(10) NOT NULL,
    IdFuncao INT NOT NULL,

    CONSTRAINT FK_Despesas_ElementoDespesa FOREIGN KEY (IdElementoDespesa) REFERENCES ElementoDespesa(IdElementoDespesa),
    CONSTRAINT FK_Despesas_OrgaoSuperior FOREIGN KEY (IdOrgaoSuperior) REFERENCES OrgaoSuperior(IdOrgaoSuperior),
    CONSTRAINT FK_Despesas_CategoriaEconomica FOREIGN KEY (IdCategoriaEconomica) REFERENCES CategoriaEconomica(IdCategoriaEconomica),
    CONSTRAINT FK_Despesas_Gestao FOREIGN KEY (IdGestao) REFERENCES Gestao(IdGestao),
    CONSTRAINT FK_Despesas_Programa FOREIGN KEY (IdProgramaOrcamentario) REFERENCES ProgramaOrcamentario(IdProgramaOrcamentario),
    CONSTRAINT FK_Despesas_Localizador FOREIGN KEY (IdLocalizador) REFERENCES Localizador(IdLocalizador),
    CONSTRAINT FK_Despesas_Mandato FOREIGN KEY (IdMandato) REFERENCES Mandato(IdMandato),
    CONSTRAINT FK_Despesas_Acao FOREIGN KEY (IdAcao) REFERENCES Acao(IdAcao),
    CONSTRAINT FK_Despesas_Funcao FOREIGN KEY (IdFuncao) REFERENCES Funcao(IdFuncao)
);

CREATE TABLE GastosCartao (
    IdGastosCartao INT PRIMARY KEY NOT NULL,
    DataTransacao DATE NOT NULL,
    ValorTransacao DECIMAL (18,2),
    DataExtrato DATE,

    IdOrgaoSuperior INT NOT NULL,
	IdUnidadeGestora INT NOT NULL,
    IdMandato INT NOT NULL,
	IdOrgaoSubordinado INT NOT NULL,

    FOREIGN KEY (IdOrgaoSuperior) REFERENCES OrgaoSuperior(IdOrgaoSuperior),
    FOREIGN KEY (IdUnidadeGestora) REFERENCES UnidadeGestora(IdUnidadeGestora), 
    FOREIGN KEY (IdMandato) REFERENCES Mandato(IdMandato),
	CONSTRAINT FK_GastoCartão_OrgaoSubordinado FOREIGN KEY (IdOrgaoSubordinado) REFERENCES OrgaoSubordinado(IdOrgaoSubordinado)
);

CREATE TABLE OrgaoPagador (
    IdOrgaoPagador INT PRIMARY KEY NOT NULL,
    NomeOrgaoPagador VARCHAR (150) NOT NULL,
    DocViajante VARCHAR (150) NOT NULL,
    Cargo VARCHAR (150) NOT NULL,
);

CREATE TABLE UnidadeGestoraPagadora (
    IdUnidadeGestoraPagadora INT PRIMARY KEY NOT NULL,
    NomeUnidadeGestoraPagadora VARCHAR (150) NOT NULL,
);

CREATE TABLE OrgaoSolicitante
(
	IdOrgaoSolicitante INT PRIMARY KEY,
	NomeOrgaoSolicitante VARCHAR(255) NOT NULL,
	NomeUnidadeOrgaoSolicitante VARCHAR(255) NOT NULL
);

CREATE TABLE Viajante
(
	IdViajante INT PRIMARY KEY,
	DocViajante VARCHAR(11) NOT NULL,
	Cargo VARCHAR(255) NOT NULL
);

CREATE TABLE Viagem
(
	IdViagem INT PRIMARY KEY,
	PeriodoInicio DATE NOT NULL,
	PeriodoFim DATE NOT NULL,
	Destinos VARCHAR(255) NOT NULL,
	Motivo VARCHAR(255) NOT NULL,
	Gastos DECIMAL(18,2) NOT NULL DEFAULT 0.00,
	IdOrgaoSuperior INT NOT NULL,
	IdOrgaoSolicitante INT NOT NULL,
	IdViajante INT NOT NULL,
	FOREIGN KEY (IdOrgaoSuperior) REFERENCES OrgaoSuperior(IdOrgaoSuperior),
	FOREIGN KEY (IdOrgaoSolicitante) REFERENCES OrgaoSolicitante(IdOrgaoSolicitante),
	FOREIGN KEY (IdViajante) REFERENCES Viajante(IdViajante)
);

CREATE TABLE Pagamento (
    IdPagamento INT PRIMARY KEY NOT NULL,
    TipodePagamento VARCHAR (150) NOT NULL,
    ValordaDespeza DECIMAL(18,2) NOT NULL,

    IdOrgaoSuperior INT NOT NULL,
    IdUnidadeGestoraPagadora INT    NOT NULL,
    IdViagem INT NOT NULL,
    IdOrgaoPagador INT NOT NULL,

    FOREIGN KEY (IdOrgaoSuperior) REFERENCES OrgaoSuperior(IdOrgaoSuperior),
    FOREIGN KEY (IdUnidadeGestoraPagadora) REFERENCES UnidadeGestoraPagadora(IdUnidadeGestoraPagadora),
    FOREIGN KEY (IdViagem) REFERENCES Viagem(IdViagem),
    FOREIGN KEY (IdOrgaoPagador) REFERENCES OrgaoPagador(IdOrgaoPagador)
);

CREATE TABLE Passagem
(
	IdPassagem INT PRIMARY KEY,
	MeioTransporte VARCHAR(255) NOT NULL,
	Origem VARCHAR(255) NOT NULL,
	Destino VARCHAR(255) NOT NULL,
	ValorPassagem DECIMAL(18,2) NOT NULL DEFAULT 0.00,
	TaxaServico DECIMAL(18,2) NOT NULL DEFAULT 0.00,
    IdViagem INT NOT NULL,
	FOREIGN KEY (IdViagem) REFERENCES Viagem(IdViagem)
);

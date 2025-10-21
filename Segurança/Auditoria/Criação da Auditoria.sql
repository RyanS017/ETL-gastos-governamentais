USE ProjetoGastosGovernamentais;
GO
CREATE TABLE Auditoria (
    IdAuditoria BIGINT IDENTITY(1,1) PRIMARY KEY,
    TabelaAfetada VARCHAR(100) NOT NULL,
    Operacao VARCHAR(10) NOT NULL CHECK (Operacao IN ('INSERT', 'UPDATE', 'DELETE')),
    ChavePrimaria VARCHAR(100) NOT NULL,
    DadosAntigos NVARCHAR(MAX) NULL,
    DadosNovos NVARCHAR(MAX) NULL,
    DataHoraOperacao DATETIME2 NOT NULL DEFAULT GETDATE()
);
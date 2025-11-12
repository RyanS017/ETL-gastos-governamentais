USE ProjetoGastosGovernamentais;
GO
CREATE TRIGGER TR_Auditoria_Pagamento ON Pagamento AFTER INSERT, UPDATE, DELETE AS BEGIN SET NOCOUNT ON;
-- INSERT
IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
BEGIN
    INSERT INTO Auditoria (TabelaAfetada, Operacao, ChavePrimaria, DadosNovos)
    SELECT
        'Pagamento',
        'INSERT',
        CAST(i.IdPagamento AS VARCHAR(100)),
        (SELECT * FROM inserted FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER)
    FROM inserted i;
END

-- UPDATE
IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
BEGIN
    INSERT INTO Auditoria (TabelaAfetada, Operacao, ChavePrimaria, DadosAntigos, DadosNovos)
    SELECT
        'Pagamento',
        'UPDATE',
        CAST(i.IdPagamento AS VARCHAR(100)),
        (SELECT * FROM deleted FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER),
        (SELECT * FROM inserted FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER)
    FROM inserted i;
END

-- DELETE
IF EXISTS (SELECT * FROM deleted) AND NOT EXISTS (SELECT * FROM inserted)
BEGIN
    INSERT INTO Auditoria (TabelaAfetada, Operacao, ChavePrimaria, DadosAntigos)
    SELECT
        'Pagamento',
        'DELETE',
        CAST(d.IdPagamento AS VARCHAR(100)),
        (SELECT * FROM deleted FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER)
    FROM deleted d;
END

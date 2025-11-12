USE [ProjetoGastosGovernamentais]
GO
CREATE TRIGGER TR_Auditoria_GastosCartao ON GastosCartao AFTER INSERT, UPDATE, DELETE AS BEGIN
-- INSERT
IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
BEGIN
    INSERT INTO Auditoria (TabelaAfetada, Operacao, ChavePrimaria, DadosNovos)
    SELECT
        'GastosCartao',
        'INSERT',
        CAST(i.IdGastosCartao AS VARCHAR(100)),
        (SELECT * FROM inserted FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER)
    FROM inserted i;
END

-- UPDATE
IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
BEGIN
    INSERT INTO Auditoria (TabelaAfetada, Operacao, ChavePrimaria, DadosAntigos, DadosNovos)
    SELECT
        'GastosCartao',
        'UPDATE',
        CAST(i.IdGastosCartao AS VARCHAR(100)),
        (SELECT * FROM deleted FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER),
        (SELECT * FROM inserted FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER)
    FROM inserted i;
END

-- DELETE
IF EXISTS (SELECT * FROM deleted) AND NOT EXISTS (SELECT * FROM inserted)
BEGIN
    INSERT INTO Auditoria (TabelaAfetada, Operacao, ChavePrimaria, DadosAntigos)
    SELECT
        'GastosCartao',
        'DELETE',
        CAST(d.IdGastosCartao AS VARCHAR(100)),
        (SELECT * FROM deleted FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER)
    FROM deleted d;
END
END;


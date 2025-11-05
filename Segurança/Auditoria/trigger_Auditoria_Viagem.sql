USE [ProjetoGastosGovernamentais]
GO
CREATE TRIGGER TR_Auditoria_Viagem ON Viagem AFTER INSERT, UPDATE, DELETE AS BEGIN
-- INSERT
IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
BEGIN
    INSERT INTO Auditoria (TabelaAfetada, Operacao, ChavePrimaria, DadosNovos)
    SELECT
        'Viagem',
        'INSERT',
        CAST(i.IdViagem AS VARCHAR(100)),
        (SELECT * FROM inserted FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER)
    FROM inserted i;
END

-- UPDATE
IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
BEGIN
    INSERT INTO Auditoria (TabelaAfetada, Operacao, ChavePrimaria, DadosAntigos, DadosNovos)
    SELECT
        'Viagem',
        'UPDATE',
        CAST(i.IdViagem AS VARCHAR(100)),
        (SELECT * FROM deleted FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER),
        (SELECT * FROM inserted FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER)
    FROM inserted i;
END

-- DELETE
IF EXISTS (SELECT * FROM deleted) AND NOT EXISTS (SELECT * FROM inserted)
BEGIN
    INSERT INTO Auditoria (TabelaAfetada, Operacao, ChavePrimaria, DadosAntigos)
    SELECT
        'Viagem',
        'DELETE',
        CAST(d.IdViagem AS VARCHAR(100)),
        (SELECT * FROM deleted FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER)
    FROM deleted d;
END
END;

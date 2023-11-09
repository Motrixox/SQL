DROP TRIGGER IF EXISTS dbo.tr_kontrola_danych; 
GO 
CREATE TRIGGER dbo.tr_kontrola_danych 
	 	ON dbo.Oferta 
	 	FOR UPDATE, INSERT 
AS 
BEGIN 
	 	DECLARE @id int 
	 	SET @id = (SELECT IDProduktu FROM inserted) 
	 	IF UPDATE(CenaJednostkowa) 
	 	BEGIN 
	 	 	IF (SELECT CenaJednostkowa FROM inserted) < 0 
	 	 	BEGIN 
	 	 	 	IF (SELECT CenaJednostkowa FROM deleted) IS NULL 
	 	 	 	BEGIN 
	 	 	 	 	PRINT('Wprowadzono ujemną cenę! Nie dodano rekordu!') 
	 	 	 	 	DELETE FROM Oferta WHERE IDproduktu = @id 
	 	 	 	END; 
	 	 	 	ELSE 
	 	 	 	BEGIN 
	 	 	 	 	UPDATE Oferta 
	 	 	 	 	SET CenaJednostkowa = (SELECT CenaJednostkowa FROM deleted) 
	 	 	 	 	WHERE IDproduktu = @id; 
	 	 	 	 	PRINT('Wprowadzono ujemną cenę! Nie zmieniono ceny!') 
	 	 	 	END; 
	 	 	END; 
	 	END; 
	 	IF UPDATE(StanMagazynu) 
	 	BEGIN 
	 	 	IF (SELECT StanMagazynu FROM inserted) < 0 
	 	 	BEGIN 
	 	 	 	IF (SELECT StanMagazynu FROM deleted) IS NULL 
	 	 	 	BEGIN 
	 	 	 	 	PRINT('Wprowadzono ujemny stan magazynu! Nie dodano rekordu!') 
	 	 	 	 	DELETE FROM Oferta WHERE IDproduktu = @id 
	 	 	 	END; 
	 	 	 	ELSE 
	 	 	 	BEGIN 
	 	 	 	 	UPDATE Oferta 
	 	 	 	 	SET StanMagazynu = (SELECT StanMagazynu FROM deleted) 
	 	 	 	 	WHERE IDproduktu = @id; 
	  	 	 	PRINT('Wprowadzono ujemny stan magazynu! Nie zmieniono stanu magazynu!') 
	 	 	 	END; 
	 	 	END; 
	 	END; 
END; 
GO 
 
UPDATE Oferta 
SET CenaJednostkowa = -1.00 
WHERE IDproduktu = 1; 
-- nie zadziała 
 
UPDATE Oferta 
SET CenaJednostkowa = 11.00 
WHERE IDproduktu = 1; 
-- zadziała 
 
UPDATE Oferta 
SET StanMagazynu = -30 
WHERE IDproduktu = 2; 
-- nie zadziała 
 
UPDATE Oferta 
SET StanMagazynu = 12 WHERE IDproduktu = 2; 
-- zadziała 
 
INSERT INTO Oferta VALUES (83, 'abc', 7, 4, '10kg', -12.00, 10, 0, 0, 0); 
-- próba dodania rekordu z ujemną ceną (nie zadziała) 
 
INSERT INTO Oferta VALUES (84, 'abc', 7, 4, '10kg', 12.00, -10, 0, 0, 0); 
-- próba dodania rekordu z ujemnym stanem magazynu (nie zadziała) 
 
INSERT INTO Oferta VALUES (83, 'abc', 7, 4, '10kg', 12.00, 10, 0, 0, 0); 
-- próba dodania rekordu z poprawną ceną i stanem magazynu (zadziała) 
 
SELECT * FROM Oferta; 
 

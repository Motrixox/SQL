-- zad 1
DROP FUNCTION IF EXISTS dbo.f_WTM; 
GO

CREATE FUNCTION f_WTM() 
RETURNS FLOAT 
AS 
BEGIN 
 	RETURN ( SELECT SUM(CenaJednostkowa * StanMagazynu) FROM Produkty ); 
END; 
GO 
 
SELECT dbo.f_WTM() [Sumaryczna wartość produktów w magazynie]; 
  
  
-- zad 2 
 
DROP FUNCTION IF EXISTS dbo.f_Wiek_Pracownika1; 
GO 
 
CREATE FUNCTION f_Wiek_Pracownika1() 
RETURNS INT 
AS 
BEGIN 
 	RETURN ( 
 	 	SELECT DATEDIFF(D, DataUrodzenia, SYSDATETIME()) / 365.25 
 	 	FROM Pracownicy WHERE IDpracownika = 1); 
END; 
GO 
 
SELECT IDpracownika, Imię, Nazwisko, dbo.f_Wiek_Pracownika1() [Wiek] 
FROM Pracownicy 
WHERE IDpracownika = 1; 
  
  
-- zad 3 
 
DROP FUNCTION IF EXISTS dbo.f_WZ; 
GO 
 
CREATE FUNCTION f_WZ(@id INT) 
RETURNS FLOAT 
AS 
BEGIN 
 	RETURN ( 
 	 	SELECT SUM(CenaJednostkowa * Ilość) 
 	 	FROM PozycjeZamówienia 
 	 	WHERE IDzamówienia = @id); 
END; 
GO 
 
SELECT IDzamówienia, dbo.f_WZ(IDzamówienia) [Wartość zamówienia] 
FROM Zamówienia; 
-- zad 4
DROP FUNCTION IF EXISTS dbo.f_Wiek_Pracownika2; 
GO
CREATE FUNCTION f_Wiek_Pracownika2(@data date) 
RETURNS INT 
AS 
BEGIN 
 	RETURN ( 
 	 	SELECT DATEDIFF(D, DataUrodzenia, @data) / 365.25 
 	 	FROM Pracownicy WHERE IDpracownika = 2); 
END; 
GO 
 
SELECT IDpracownika, Imię, Nazwisko, dbo.f_Wiek_Pracownika2('2012-02-18') [Wiek] 
FROM Pracownicy 
WHERE IDpracownika = 2; 
  
  
-- zad 5 
 
DROP FUNCTION IF EXISTS dbo.f_Nowe_Ceny; 
GO 
 
CREATE FUNCTION f_Nowe_Ceny(@przyrost float) 
RETURNS @nowe_produkty TABLE 
( 
 	[IDproduktu] INT NOT NULL, 
 	[NazwaProduktu] NVARCHAR(40) NOT NULL, 
 	[NazwaKategorii] NVARCHAR(40) NOT NULL, 
 	[CenaJednostkowa] MONEY NOT NULL, 
 	[ZmodyfikowanaCenaJednostkowa] MONEY NOT NULL, 
 	[StanMagazynu] INT NOT NULL 
) 
AS 
BEGIN 
 	INSERT INTO @nowe_produkty 
 	SELECT IDproduktu, NazwaProduktu, NazwaKategorii, CenaJednostkowa,  
 	(CenaJednostkowa + CenaJednostkowa * 0.01 * @przyrost), StanMagazynu 
 	FROM Produkty p  
 	JOIN Kategorie k ON p.IDkategorii = k.IDkategorii 
 	WHERE StanMagazynu < StanMinimum 
 
 	RETURN  
END; 
GO 
 
SELECT * 
FROM dbo.f_Nowe_Ceny(100); 
   
   
-- zad 6
DROP PROCEDURE IF EXISTS dbo.spu_Pobierz_Wartosc_Zamowienia; 
GO
CREATE PROCEDURE dbo.spu_Pobierz_Wartosc_Zamowienia 
@idZamowienia AS INT = NULL 
AS 
BEGIN 
 	IF @idZamowienia IS NULL 
 	BEGIN 
 	 	SELECT z.IDzamówienia, 'ALL' [IDKlienta],  
 	 	SUM(pz.CenaJednostkowa * pz.Ilość) [Wartosc] 
 	 	FROM Zamówienia z  
 	 	JOIN PozycjeZamówienia pz ON z.IDzamówienia = pz.IDzamówienia 
 	 	GROUP BY z.IDzamówienia 
 	END; 
 	ELSE IF @idZamowienia IS NOT NULL 
 	BEGIN 
 	 	SELECT z.IDzamówienia, IDKlienta,  
 	 	SUM(pz.CenaJednostkowa * pz.Ilość) [Wartosc] 
 	 	FROM Zamówienia z  
 	 	JOIN PozycjeZamówienia pz ON z.IDzamówienia = pz.IDzamówienia 
 	 	WHERE z.IDzamówienia = @idZamowienia 
 	 	GROUP BY z.IDzamówienia, IDklienta 
 	END; 
END; 
 
EXEC dbo.spu_Pobierz_Wartosc_Zamowienia; 
 
EXEC dbo.spu_Pobierz_Wartosc_Zamowienia 
 	@idZamowienia = 10414; 
 
   
-- zad 7 
 
DROP PROCEDURE IF EXISTS dbo.spu_Pobierz_Zamowienia_Klienta; 
GO 
 
CREATE PROCEDURE dbo.spu_Pobierz_Zamowienia_Klienta 
@idKlienta AS NVARCHAR(5) 
AS 
BEGIN 
 	SELECT k.IDKlienta, k.NazwaFirmy, z.IDzamówienia, z.DataZamówienia 
 	FROM Zamówienia z  
 	JOIN Klienci k ON z.IDklienta = k.IDklienta 
 	WHERE k.IDklienta = @idKlienta 
END; 
 
EXEC dbo.spu_Pobierz_Zamowienia_Klienta 
 	@idKlienta = 'FRANK'; 
   
   
-- zad 8
DROP PROCEDURE IF EXISTS dbo.spu_Pobierz_Zamowienia_Pracownika; 
GO
CREATE PROCEDURE dbo.spu_Pobierz_Zamowienia_Pracownika 
@idPracownika AS INT = NULL, 
@liczbaZamowien AS INT = NULL 
AS 
BEGIN 
 	IF @idPracownika IS NULL 
 	BEGIN 
 	 	SELECT COUNT(IDzamówienia) [Liczba wszystkich przyjetych zamowien]  
 	 	FROM Zamówienia; 
 	END; 
 	ELSE IF @liczbaZamowien > 0 
 	BEGIN 
 	 	IF (SELECT COUNT(IDzamówienia)  
 	 	FROM Zamówienia 
 	 	WHERE IDpracownika = @idPracownika) > @liczbaZamowien 
 	 	BEGIN 
 	 	 	SELECT 'Pracownik przyjal wiecej zamowien niz ' + 
STR(@liczbaZamowien) 
 	 	END; 
 	 	ELSE 
 	 	BEGIN 
 	 	 	SELECT 'Pracownik nie przyjal wiecej zamowien niz ' + 
STR(@liczbaZamowien) 
 	 	END; 
 	END; 
 	ELSE IF @liczbaZamowien < 0 
 	BEGIN 
 	 	SELECT '-1' 
 	 	RETURN -1 
 	END; 
END; 
 
EXEC dbo.spu_Pobierz_Zamowienia_Pracownika 
 	@idPracownika = 2, 
 	@liczbaZamowien = 10; 

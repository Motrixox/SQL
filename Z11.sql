-- zad 1
DECLARE @a float = -3; 
DECLARE @b float = 2; 
DECLARE @c float = 1; 
DECLARE @x1 float; 
DECLARE @x2 float; 
DECLARE @delta float; 
 
DECLARE @stopien int = IIF (@a != 0, 2,  
 	 	 	 	 	IIF (@b != 0, 1, 0) 
 	 	 	 	) 
 
PRINT 'Stopień = ' + CAST(@stopien AS VARCHAR) 
IF (@stopien = 0) 
 	BEGIN 
 	 	PRINT 'Błędne równanie!' 
 	END 
ELSE IF (@stopien = 1) 
 	BEGIN 
 	 	SET @x1 = -1 * @c / @b 
 	 	PRINT 'x1 = ' + CAST(@x1 AS VARCHAR) 
 	END 
ELSE IF (@stopien = 2) 
 	BEGIN 
 	 	SET @delta = (@b * @b) - (4.0 * @a * @c) 
 	 	PRINT 'DELTA = ' + CAST(@delta AS VARCHAR) 
 	 	IF (@delta < 0) 
 	 	 	BEGIN 
 	 	 	 	PRINT 'DELTA < 0, Brak rozwiązań rzeczywistych' 
 	 	 	END 
 	 	ELSE IF (@delta = 0) 
 	 	 	BEGIN 
 	 	 	 	SET @x1 = -1.0 * @b / (2.0 * @a) 
 	 	 	 	PRINT 'DELTA = 0, x0 = ' + CAST(@x1 AS VARCHAR) 
 	 	 	END 
 	 	ELSE IF (@delta > 0) 
 	 	 	BEGIN 
 	 	 	 	SET @x1 = (-1.0 * @b - SQRT(@delta)) / (2.0 * @a) 
 	 	 	 	SET @x2 = (-1.0 * @b + SQRT(@delta)) / (2.0 * @a) 
 	 	 	 	PRINT 'DELTA > 0, x1 = ' + CAST(@x1 AS VARCHAR) + ', x2 = '  
 	 	 	 	+ CAST(@x2 AS VARCHAR) 
 	 	 	END 
 	END 
 
-- zad 2 
DECLARE @losowa float; 
BEGIN 
 	SET @losowa = ROUND(RAND() * 1000, 0); 
 
 	IF @losowa BETWEEN 0 AND 333 
 	 	PRINT 'Wylosowana liczba znajduje się w zakresie 0-333. Wylosowana liczba  
 	 	 	to: ' + CAST(@losowa AS VARCHAR(max)); 
 	ELSE IF @losowa BETWEEN 334 AND 666 
 	 	PRINT 'Wylosowana liczba znajduje się w zakresie 334-666. Wylosowana  
 	 	 	liczba to: ' + CAST(@losowa AS VARCHAR(max)); 
 	ELSE 
  PRINT 'Wylosowana liczba znajduje się w zakresie 667-1000. Wylosowana     liczba to: ' + CAST(@losowa AS VARCHAR(max)); 
END; 
SELECT CAST(@losowa AS VARCHAR(max)); 
GO 
  
-- zad 3
DROP TABLE IF EXISTS Produkty_Kopia; 
GO 
 
CREATE TABLE Produkty_Kopia (IDproduktu INT NOT NULL PRIMARY KEY,  
  NazwaProduktu VARCHAR(50), CenaJednostkowa FLOAT) 
 
INSERT INTO Produkty_Kopia 
SELECT IDproduktu, NazwaProduktu, CenaJednostkowa 
FROM Produkty 
 
WHILE (SELECT AVG(CenaJednostkowa) FROM Produkty_Kopia) < 350  
BEGIN 
 	UPDATE Produkty_Kopia 
 	SET CenaJednostkowa = CenaJednostkowa * 1.1 
 	IF (SELECT MAX(CenaJednostkowa) FROM Produkty_Kopia) > 1000 
 	 	BREAK 
 	ELSE 
 	 	CONTINUE 
END 
PRINT 'Zakończono iteracyjne zwiększanie cen.' 
-- średnia = 110,240450470109, max = 1000,64081149184 
 
-- zad 4 
DROP TABLE IF EXISTS Produkty_Kopia; 
GO 
 
CREATE TABLE Produkty_Kopia (IDproduktu INT NOT NULL PRIMARY KEY, NazwaProduktu 
VARCHAR(50), CenaJednostkowa FLOAT) 
 
INSERT INTO Produkty_Kopia 
SELECT IDproduktu, NazwaProduktu, CenaJednostkowa 
FROM Produkty 
 
DECLARE @srednia float = (SELECT AVG(CenaJednostkowa) FROM Produkty_Kopia); 
DECLARE @max float = (SELECT MAX(CenaJednostkowa) FROM Produkty_Kopia);  
PRINT 'Przed podwyżką: średnia = ' + CAST(@srednia AS VARCHAR) + ', max = '  + CAST(@max AS VARCHAR) 
 
WHILE (SELECT AVG(CenaJednostkowa) FROM Produkty_Kopia) < 350  
BEGIN 
 	UPDATE Produkty_Kopia 
 	SET CenaJednostkowa = CenaJednostkowa * 1.1 
 	IF (SELECT MAX(CenaJednostkowa) FROM Produkty_Kopia) > 1000 
 	 	BREAK 
 	ELSE 
 	 	CONTINUE 
END 
 
SET @srednia = (SELECT AVG(CenaJednostkowa) FROM Produkty_Kopia); 
SET @max = (SELECT MAX(CenaJednostkowa) FROM Produkty_Kopia); 
 
PRINT 'Zakończono iteracyjne zwiększanie cen.' 
PRINT 'Po podwyżce: średnia = ' + CAST(@srednia AS VARCHAR) + ', max = '  + CAST(@max AS VARCHAR) 
   
 
  
-- zad 5
DECLARE @liczba INT = 12 
DECLARE @suma INT = 0; 
 
WHILE @liczba <= 23 
BEGIN 
 	SET @suma = @suma + @liczba 
 	SET @liczba = @liczba + 1 
 	IF (SELECT DATENAME(dw, GETDATE())) = 'Friday' 
 	 	CONTINUE 
 	ELSE IF @suma > 1500 
 	 	BREAK 
END 
 
SELECT @suma AS Suma 
-- suma = 210 
 
-- zad 6 
DECLARE @rok INT = 1997 
 
SELECT t.Imię, t.Nazwisko, AVG(t.WartośćZamówienia) [Średnia wartość zamówienia] FROM 
 	(SELECT YEAR(z.DataZamówienia) [Rok], p.Imię, p.Nazwisko,  
 SUM(pz.CenaJednostkowa * pz.Ilość) [WartośćZamówienia]  	FROM Zamówienia z 
 	JOIN PozycjeZamówienia pz ON pz.IDzamówienia = z.IDzamówienia 
 	JOIN Pracownicy p ON p.IDpracownika = z.IDpracownika 
 	WHERE YEAR(z.DataZamówienia) = @rok 
 	GROUP BY YEAR(z.DataZamówienia), p.Imię, p.Nazwisko, z.IDzamówienia) t 
GROUP BY t.Rok, t.Imię, t.Nazwisko 
 
-- zad 7 
DECLARE @superLup DATE; 
 
SET @superLup = (SELECT z.DataZamówienia 
 	 	 	FROM 
 	 	 	 	(SELECT TOP 1 IDzamówienia, COUNT(IDproduktu) [Pozycje] 
 	 	 	 	FROM PozycjeZamówienia  
 	 	 	 	GROUP BY IDzamówienia 
 	 	 	 	ORDER BY [Pozycje] DESC) t 
 	 	 	JOIN Zamówienia z ON z.IDzamówienia = t.IDzamówienia) 
 
SELECT z.DataZamówienia, p.Imię, p.Nazwisko, COUNT(z.IDzamówienia) [Liczba zamówień] 
FROM Zamówienia z 
JOIN Pracownicy p ON p.IDpracownika = z.IDpracownika 
WHERE z.DataZamówienia = @superLup 
GROUP BY z.DataZamówienia, p.Imię, p.Nazwisko 
-- 4 pracowników przyjęło w tym dniu po 1 zamówieniu 
 
-- zad 8 
DECLARE @czarneowce table (imie VARCHAR(20), nazwisko VARCHAR(20))  
INSERT INTO @czarneowce(imie, nazwisko) 
 	(SELECT DISTINCT p.Imię, p.Nazwisko 
 	FROM Zamówienia z 
 	JOIN Pracownicy p ON p.IDpracownika = z.IDpracownika 
 	WHERE z.DataWysyłki IS NULL) 
 
SELECT * FROM @czarneowce 
-- 7 wierszy 
  
-- zad 9
DECLARE @debesciaki table (imie VARCHAR(20), nazwisko VARCHAR(20), liczba_zamówień INT, miesiąc TEXT) 
 
INSERT INTO @debesciaki(imie, nazwisko, liczba_zamówień, miesiąc) 
 	(SELECT p.Imię, p.Nazwisko,  
 	COUNT(z.IDzamówienia) [Ilość zamówień],  
 	STR(MONTH(DataZamówienia)) + '.' + RIGHT(STR(YEAR(DataZamówienia)), 4) [Miesiąc] 
 	FROM Pracownicy p 
 	JOIN Zamówienia z ON p.IDpracownika = z.IDpracownika 
 	GROUP BY z.IDpracownika, p.Imię, p.Nazwisko,  
 	STR(MONTH(DataZamówienia)) + '.' + RIGHT(STR(YEAR(DataZamówienia)), 4) 
 	HAVING COUNT(z.IDzamówienia) =  
 	 	(SELECT MAX(t.zamówienia) 
 	 	FROM 
 	 	 	(SELECT z2.IDpracownika,  
 	 	 	COUNT(z2.IDzamówienia) [zamówienia] 
 	 	 	FROM Zamówienia z2 
 	 	 	WHERE z2.IDpracownika = z.IDpracownika 
 	 	 	GROUP BY z2.IDpracownika, YEAR(z2.DataZamówienia), 
MONTH(z2.DataZamówienia)) t)) 
 
SELECT * FROM @debesciaki 
-- 9 wierszy 
 
-- zad 10 
DECLARE @debesciaki table (imie VARCHAR(20), nazwisko VARCHAR(20), liczba_zamówień 
INT, miesiąc TEXT) 
 
INSERT INTO @debesciaki(imie, nazwisko, liczba_zamówień, miesiąc) 
 	(SELECT p.Imię, p.Nazwisko,  
 	COUNT(z.IDzamówienia) [Ilość zamówień],  
 	STR(MONTH(DataZamówienia)) + '.' + RIGHT(STR(YEAR(DataZamówienia)), 4) [Miesiąc] 
 	FROM Pracownicy p 
 	JOIN Zamówienia z ON p.IDpracownika = z.IDpracownika 
 	GROUP BY z.IDpracownika, p.Imię, p.Nazwisko,  
 	STR(MONTH(DataZamówienia)) + '.' + RIGHT(STR(YEAR(DataZamówienia)), 4) 
 	HAVING COUNT(z.IDzamówienia) =  
 	 	(SELECT MAX(t.zamówienia) 
 	 	FROM 
 	 	 	(SELECT z2.IDpracownika,  
 	 	 	COUNT(z2.IDzamówienia) [zamówienia] 
 	 	 	FROM Zamówienia z2 
 	 	 	WHERE z2.IDpracownika = z.IDpracownika 
 	 	 	GROUP BY z2.IDpracownika, YEAR(z2.DataZamówienia), 
MONTH(z2.DataZamówienia)) t)) 
 
SELECT imie, nazwisko FROM @debesciaki 
WHERE miesiąc LIKE '%12.1996%' 
-- brak wyniku, ponieważ żaden pracownik nie miał swojego najlepszego miesiąca w grudniu 1996 

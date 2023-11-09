USE BD1_21D_3b 
GO 
 
-- zad 1a 
SELECT MAX(CenaJednostkowa) 
FROM Produkty; 
-- 263,50 
 
-- zad 1b 
SELECT TOP 1 CenaJednostkowa 
FROM Produkty 
ORDER BY CenaJednostkowa DESC; 
-- 263,50 
 
-- zad 2a 
SELECT TOP 1 DataWysyłki 
FROM Zamówienia 
WHERE DataWysyłki IS NOT NULL 
ORDER BY DataWysyłki; 
-- 1996-07-10 
 
-- zad 2b 
SELECT MIN(DataWysyłki) 
FROM Zamówienia 
WHERE DataWysyłki IS NOT NULL; 
-- 1996-07-10 
 
-- zad 3 
SELECT COUNT(IDKlienta) 
FROM Klienci; 
-- 95 klientów ogólnie 
 
-- zad 4 
SELECT COUNT(IDKlienta) 
FROM Klienci 
WHERE Kraj LIKE 'USA'; 
-- 13 klientów z USA 
 
-- zad 5 
SELECT k.NazwaKategorii, SUM(p.CenaJednostkowa) Wartość 
FROM Produkty p JOIN Kategorie k ON p.IDkategorii = k.IDkategorii 
GROUP BY k.NazwaKategorii 
ORDER BY Wartość DESC; 
-- 9 wierszy 
 
-- zad 6 
SELECT SUM(CenaJednostkowa * Ilość) 
FROM PozycjeZamówienia; 
-- 1354458,59 
 
-- zad 7 
SELECT SUM(CenaJednostkowa * Ilość) 
FROM PozycjeZamówienia p JOIN Zamówienia z ON p.IDzamówienia = z.IDzamówienia 
WHERE YEAR(z.DataZamówienia) = 1996; 
-- 226298,50 
 
-- zad 8 
SELECT MONTH(z.DataZamówienia) Miesiąc, SUM(CenaJednostkowa * Ilość) Wartość 
FROM PozycjeZamówienia p JOIN Zamówienia z ON p.IDzamówienia = z.IDzamówienia 
WHERE YEAR(z.DataZamówienia) = 1998 
GROUP BY MONTH(z.DataZamówienia); 
-- 5 wierszy 
 
-- zad 9 
SELECT DAY(z.DataZamówienia) Dzień, COUNT(DISTINCT pr.IDKategorii) Ilość_Kategorii 
FROM PozycjeZamówienia p 
JOIN Zamówienia z ON p.IDzamówienia = z.IDzamówienia 
JOIN Produkty pr ON p.IDproduktu = pr.IDproduktu 
WHERE YEAR(z.DataZamówienia) = 1998 AND MONTH(z.DataZamówienia) = 1 
GROUP BY DAY(z.DataZamówienia); 
-- 22 wiersze 
 
-- zad 10 
SELECT COUNT(DISTINCT z.IDZamówienia) 
FROM Zamówienia z 
JOIN Klienci k ON z.IDklienta = k.IDklienta 
JOIN PozycjeZamówienia pz ON pz.IDzamówienia = z.IDzamówienia 
JOIN Produkty p ON p.IDproduktu = pz.IDproduktu 
JOIN Kategorie kat ON kat.IDkategorii = p.IDkategorii 
WHERE YEAR(z.DataZamówienia) = 1996 
AND k.Kraj LIKE 'USA' 
AND kat.NazwaKategorii LIKE 'Przyprawy'; 
-- 5 zamówień 
 
-- zad 11 
SELECT DATEPART(QUARTER, z.DataZamówienia), COUNT(DISTINCT k.IDKlienta) 
FROM Zamówienia z 
JOIN Klienci k ON z.IDklienta = k.IDklienta 
JOIN PozycjeZamówienia pz ON pz.IDzamówienia = z.IDzamówienia 
JOIN Produkty p ON p.IDproduktu = pz.IDproduktu 
WHERE p.NazwaProduktu LIKE 'IKURA' 
AND YEAR(z.DataZamówienia) = 1997 
GROUP BY DATEPART(QUARTER, z.DataZamówienia); 
-- 4 wiersze 
 
-- zad 12 
SELECT YEAR(z.DataZamówienia) Rok, COUNT(DISTINCT k.IDKlienta) Liczba_Klientów 
FROM Zamówienia z 
JOIN Klienci k ON z.IDklienta = k.IDklienta 
JOIN PozycjeZamówienia pz ON pz.IDzamówienia = z.IDzamówienia 
JOIN Produkty p ON p.IDproduktu = pz.IDproduktu 
JOIN Dostawcy d ON d.IDdostawcy = p.IDdostawcy 
WHERE d.Kraj LIKE 'Japonia' 
GROUP BY YEAR(z.DataZamówienia); 
-- 3 wiersze 
 
-- zad 13 
SELECT SUM(pz.CenaJednostkowa * pz.Ilość) Wartość 
FROM Zamówienia z 
JOIN Klienci k ON z.IDklienta = k.IDklienta 
JOIN PozycjeZamówienia pz ON pz.IDzamówienia = z.IDzamówienia 
JOIN Produkty p ON p.IDproduktu = pz.IDproduktu 
JOIN Dostawcy d ON d.IDdostawcy = p.IDdostawcy 
WHERE d.Kraj LIKE 'Japonia'; 
-- 49211,50 
 
-- zad 14 
SELECT k.Kraj, SUM(pz.CenaJednostkowa * pz.Ilość) Wartość 
FROM Zamówienia z 
JOIN Klienci k ON z.IDklienta = k.IDklienta 
JOIN PozycjeZamówienia pz ON pz.IDzamówienia = z.IDzamówienia 
GROUP BY k.Kraj; 
-- 21 wierszy 
 
-- zad 15 
SELECT k.Kraj, SUM(pz.CenaJednostkowa * pz.Ilość) Wartość 
FROM Zamówienia z 
JOIN Klienci k ON z.IDklienta = k.IDklienta 
JOIN PozycjeZamówienia pz ON pz.IDzamówienia = z.IDzamówienia 
JOIN Pracownicy pr ON pr.IDpracownika = z.IDpracownika 
WHERE pr.Nazwisko LIKE 'Peacock' 
GROUP BY k.Kraj; 
-- 20 wierszy 
 
-- zad 16 
SELECT pr.Imię, pr.Nazwisko, YEAR(z.DataZamówienia) Rok, k.Kraj, 
SUM(pz.CenaJednostkowa * pz.Ilość) Wartość 
FROM Zamówienia z 
JOIN Klienci k ON z.IDklienta = k.IDklienta 
JOIN PozycjeZamówienia pz ON pz.IDzamówienia = z.IDzamówienia 
JOIN Pracownicy pr ON pr.IDpracownika = z.IDpracownika 
GROUP BY pr.Imię, pr.Nazwisko, YEAR(z.DataZamówienia), k.Kraj 
ORDER BY pr.Nazwisko, k.Kraj, Rok; 
-- 347 wierszy 
 
-- zad 17 
SELECT TOP 1 pr.Imię, pr.Nazwisko, COUNT(pr.IDPracownika) Zamówienia 
FROM Pracownicy pr 
JOIN Zamówienia z ON z.IDpracownika = pr.IDpracownika 
WHERE YEAR(z.DataZamówienia) = 1996 AND MONTH(z.DataZamówienia) = 11 
GROUP BY pr.Imię, pr.Nazwisko, pr.IDpracownika 
ORDER BY Zamówienia DESC; 
-- Margaret Peacock - 5 zamówień 
 
-- zad 18 
SELECT TOP 1 k.NazwaKategorii, SUM(pz.CenaJednostkowa * pz.Ilość) Obrót 
FROM Zamówienia z 
JOIN PozycjeZamówienia pz ON pz.IDzamówienia = z.IDzamówienia 
JOIN Produkty pr ON pr.IDproduktu = pz.IDproduktu 
JOIN Kategorie k ON k.IDkategorii=pr.IDkategorii 
WHERE YEAR(z.DataZamówienia) = 1998 AND MONTH(z.DataZamówienia) = 5 
GROUP BY k.NazwaKategorii 
ORDER BY Obrót DESC; 
-- Produkty zbożowe - 4421,00 
 
-- zad 19 
SELECT YEAR(z.DataZamówienia) Rok, AVG(pz.CenaJednostkowa * pz.Ilość) 'Średnia Wartość' 
FROM Zamówienia z 
JOIN PozycjeZamówienia pz ON pz.IDzamówienia = z.IDzamówienia 
GROUP BY YEAR(z.DataZamówienia) 
ORDER BY Rok; 
-- 3 wiersze 
 
-- zad 20 
SELECT TOP 1 d.NazwaFirmy, SUM(pz.CenaJednostkowa * pz.Ilość) Obrót 
FROM Zamówienia z 
JOIN Klienci k ON z.IDklienta = k.IDklienta 
JOIN PozycjeZamówienia pz ON pz.IDzamówienia = z.IDzamówienia 
JOIN Produkty p ON p.IDproduktu = pz.IDproduktu 
JOIN Dostawcy d ON d.IDdostawcy = p.IDdostawcy 
GROUP BY d.NazwaFirmy 
ORDER BY Obrót DESC; 
-- Aux joyeux ecclésiastiques - 163135,00 
  
-- zad 21 
SELECT tabela2.[Imie], tabela2.[Nazwisko], tabela2.[Rok], tabela3.Kraj, tabela2.Wartość 
FROM 
 	(SELECT [Imie], [Nazwisko], [Rok], MAX([Wartosc]) Wartość 
 	FROM 
(SELECT p.Imię [Imie], p.Nazwisko [Nazwisko], YEAR(z.DataZamówienia) 
[Rok], k.Kraj [Kraj], SUM(pz.CenaJednostkowa * pz.Ilość) [Wartosc] 
 	 	FROM Pracownicy p 
 	 	JOIN Zamówienia z ON z.IDpracownika = p.IDpracownika 
 	 	JOIN Klienci k ON k.IDklienta = z.IDklienta 
 	 	JOIN PozycjeZamówienia pz ON pz.IDzamówienia = z.IDzamówienia 
 	 	GROUP BY p.Imię, p.Nazwisko, YEAR(z.DataZamówienia), k.Kraj) tabela 
 	GROUP BY [Imie], [Nazwisko], [Rok]) tabela2 
JOIN 
(SELECT p.Imię [Imie], p.Nazwisko [Nazwisko], YEAR(z.DataZamówienia) [Rok], 
k.Kraj [Kraj], SUM(pz.CenaJednostkowa * pz.Ilość) [Wartosc] 
 	FROM Pracownicy p 
 	JOIN Zamówienia z ON z.IDpracownika = p.IDpracownika 
 	JOIN Klienci k ON k.IDklienta = z.IDklienta 
 	JOIN PozycjeZamówienia pz ON pz.IDzamówienia = z.IDzamówienia 
 	GROUP BY p.Imię, p.Nazwisko, YEAR(z.DataZamówienia), k.Kraj) tabela3 
ON tabela2.Wartość = tabela3.Wartosc 
ORDER BY tabela2.[Imie], tabela2.[Nazwisko], tabela2.[Rok]; 
-- 27 wierszy 

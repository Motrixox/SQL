-- zad 1 
SELECT IDzamówienia, DataZamówienia, IDklienta 
FROM Zamówienia 
WHERE IDklienta = ANY 
 	(SELECT IDklienta 
 	FROM Klienci 
 	WHERE Kraj LIKE 'Francja' OR Kraj LIKE 'Niemcy') 
-- 201 wierszy 
  
 
-- zad 2 
SELECT Imię, Nazwisko 
FROM Pracownicy 
WHERE IDpracownika IN 
 	(SELECT DISTINCT IDpracownika 
 	FROM Zamówienia 
 	WHERE DataWysyłki IS NULL) 
-- 7 wierszy 
  
 
-- zad 3 
SELECT p.NazwaProduktu 
FROM Produkty p 
WHERE p.IDproduktu NOT IN 
 	(SELECT DISTINCT p.IDproduktu 
 	FROM PozycjeZamówienia pz 
 	JOIN Zamówienia z ON pz.IDzamówienia = z.IDzamówienia 
 	JOIN Produkty p ON p.IDproduktu = pz.IDproduktu 
 	WHERE z.DataWysyłki IS NULL) 
-- 33 wiersze 
 
  
-- zad 4 
SELECT Imię, Nazwisko 
FROM Pracownicy 
WHERE IDpracownika IN 
 	(SELECT DISTINCT IDpracownika 
 	FROM Zamówienia 
 	WHERE DataWysyłki IS NULL AND YEAR(DataZamówienia) = 1998) 
-- 7 wierszy 
 
 
-- zad 5 
SELECT z.KrajOdbiorcy, p.IDproduktu, SUM(pz.Ilość) AS [Sprzedaż] 
FROM Produkty p 
JOIN PozycjeZamówienia pz ON pz.IDproduktu = p.IDproduktu 
JOIN Zamówienia z ON z.IDzamówienia = pz.IDzamówienia 
JOIN Pracownicy pr ON pr.IDpracownika = z.IDpracownika 
WHERE CONCAT(pr.Imię, ' ', pr.Nazwisko) LIKE 'Margaret Peacock' 
AND z.KrajOdbiorcy IN 
 	(SELECT z.KrajOdbiorcy 
 	FROM Zamówienia z 
 	JOIN Pracownicy p ON z.IDpracownika = p.IDpracownika 
 	WHERE (CONCAT(p.Imię, ' ', p.Nazwisko) LIKE 'Anne Dodsworth' 
 	OR CONCAT(p.Imię, ' ', p.Nazwisko) LIKE 'Andrew Fuller') 
 	AND z.DataZamówienia >= '1998-01-03' AND z.DataZamówienia <= '1998-01-07') 
GROUP BY p.IDproduktu, z.KrajOdbiorcy 
HAVING SUM(pz.Ilość) < 10 
-- 9 wierszy 
 
 
-- zad 6 
SELECT p.Imię, p.Nazwisko, AVG(a.[wartosc]) AS 'Srednia wartość zamówienia' 
FROM Pracownicy p 
JOIN 
 	(SELECT z.IDpracownika, z.IDzamówienia, SUM(pz.CenaJednostkowa * pz.Ilość) 
[wartosc] 
 	FROM Zamówienia z 
 	JOIN PozycjeZamówienia pz ON z.IDZamówienia = pz.IDZamówienia 
 	GROUP BY z.IDpracownika, z.IDzamówienia) a 
ON p.IDpracownika = a.IDpracownika 
GROUP BY p.Imię, p.Nazwisko 
-- 9 wierszy 
  
 
-- zad 7 
SELECT k.IDklienta, t.liczba_zamowien, t2.srednia_liczba_zamowien 
FROM Klienci k 
JOIN 
 	(SELECT k.IDklienta, COUNT(z.IDZamówienia) [liczba_zamowien] 
 	FROM Klienci k 
 	JOIN Zamówienia z ON z.IDklienta = k.IDklienta 
 	GROUP BY k.IDklienta) t 
ON k.IDklienta = t.IDklienta, 
 	(SELECT AVG(t.liczba_zamowien) [srednia_liczba_zamowien] 
 	FROM 
 	 	(SELECT k.IDklienta, COUNT(z.IDZamówienia) [liczba_zamowien] 
 	 	FROM Klienci k 
 	 	JOIN Zamówienia z ON z.IDklienta = k.IDklienta 
 	 	GROUP BY k.IDklienta) t) t2 
WHERE t.liczba_zamowien < t2.srednia_liczba_zamowien 
-- 45 wierszy 
  
 
-- zad 8 
SELECT p.Imię, p.Nazwisko, COUNT(z.IdZamówienia) 'Zamówienia przyjęte w ostatnich 2 tygodniach' FROM Pracownicy p 
JOIN Zamówienia z ON z.IDpracownika = p.IDpracownika 
JOIN 
 	(SELECT IDpracownika, MAX(DataZamówienia) [ostatnie], 
 	DATEADD(DAY, -14, MAX(DataZamówienia)) [ostatnie_minus_2_tygodnie] 
 	FROM Zamówienia 
 	GROUP BY IDpracownika) t 
ON t.IDpracownika = z.IDpracownika 
WHERE z.DataZamówienia >= t.ostatnie_minus_2_tygodnie 
AND z.DataZamówienia <= t.ostatnie 
GROUP BY p.Imię, p.Nazwisko 
-- 9 wierszy 
 
   
   
 
  
-- zad 9 
SELECT p.Imię + ' ' + p.Nazwisko Pracownik,  
COUNT(z.IDzamówienia) [Ilość zamówień],  
STR(MONTH(DataZamówienia)) + '.' + RIGHT(STR(YEAR(DataZamówienia)), 4) [Miesiąc] 
FROM Pracownicy p 
JOIN Zamówienia z ON p.IDpracownika = z.IDpracownika 
GROUP BY z.IDpracownika, (p.Imię + ' ' + p.Nazwisko),  
STR(MONTH(DataZamówienia)) + '.' + RIGHT(STR(YEAR(DataZamówienia)), 4) 
HAVING COUNT(z.IDzamówienia) =  
 	(SELECT MAX(t.zamówienia) 
 	FROM 
 	 	(SELECT z2.IDpracownika,  
 	 	COUNT(z2.IDzamówienia) [zamówienia] 
 	 	FROM Zamówienia z2 
 	 	WHERE z2.IDpracownika = z.IDpracownika 
 	 	GROUP BY z2.IDpracownika, YEAR(z2.DataZamówienia), 
MONTH(z2.DataZamówienia)) t) 
-- 9 wierszy 
 
 
-- zad 10 
SELECT k.NazwaFirmy, z.KrajOdbiorcy, t.wartość 
FROM Zamówienia z 
JOIN Klienci k ON k.IDklienta = z.IDklienta 
JOIN  
 	(SELECT z.IDzamówienia, SUM(pz.CenaJednostkowa * pz.Ilość) [wartość] 
 	FROM Zamówienia z 
 	JOIN PozycjeZamówienia pz ON pz.IDzamówienia = z.IDzamówienia 
 	GROUP BY z.IDzamówienia) t 
ON t.IDzamówienia = z.IDzamówienia 
WHERE t.wartość =  
 	(SELECT MAX(t.wartość) FROM 
 	 	(SELECT z.IDzamówienia, SUM(pz.CenaJednostkowa * pz.Ilość) [wartość] 
 	 	FROM Zamówienia z 
 	 	JOIN PozycjeZamówienia pz ON pz.IDzamówienia = z.IDzamówienia 
 	 	GROUP BY z.IDzamówienia) t) 
-- 1 wiersz (QUICK-Stop, Niemcy, 17250,00) 

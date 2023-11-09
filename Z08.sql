-- zad 1 
SELECT DISTINCT LEFT(Telefon, CHARINDEX( ')', Telefon)) AS Prefix 
FROM Klienci 
WHERE Telefon LIKE '(%)%'; 
-- 27 wierszy 
 
-- zad 2 
SELECT DISTINCT Kraj, Miasto, LEFT(Telefon, CHARINDEX( ')', Telefon)) AS Prefix 
FROM Klienci 
WHERE Telefon LIKE '(%)%' 
ORDER BY Kraj, Miasto; 
-- 36 wierszy 
 
-- zad 3 
SELECT DISTINCT NazwaFirmy, 
'(***)' + RIGHT(Telefon, LEN(Telefon) - CHARINDEX( ')', Telefon)) AS 'Telefon bez prefiksu' FROM Klienci 
WHERE Telefon LIKE '(%)%'; 
-- 57 wierszy 
 
-- zad 4 
SET STATISTICS IO, TIME ON  
 
SELECT a1.Kraj,  
 	CONCAT ( CONVERT(DECIMAL(10,2) 
 	, AVG(a1.[Wartość Zamówienia])) 
 	, ' USD') AS [Średnia wartość zamówienia] 
FROM Zamówienia z1 JOIN ( SELECT k2.Kraj [Kraj] 
 	 	 	, z2.IDzamówienia 
 	 	 	, SUM(pz2.CenaJednostkowa * pz2.Ilość) [Wartość zamówienia] 
 	 	FROM Klienci k2 JOIN Zamówienia z2 
 	 	 	ON k2.IDklienta = z2.IDklienta 
 	 	 	JOIN PozycjeZamówienia pz2 
 	 	 	ON z2.IDzamówienia = pz2.IDzamówienia 
 	 	 	JOIN Pracownicy p2 
 	 	 	ON z2.IDpracownika = p2.IDpracownika 
 	 	WHERE p2.Kraj = 'USA' 
 	 	GROUP BY k2.Kraj, z2.IDzamówienia) a1 
 	ON z1.IDzamówienia = a1.IDzamówienia 
GROUP BY a1.Kraj 
UNION 
SELECT a2.Kraj 
 	, CONCAT(CONVERT(DECIMAL(10,2) 
 	, AVG(a2.[Wartość zamówienia])) 
 	, 'EUR') AS [Średnia wartość zamówienia] 
FROM Zamówienia z1 JOIN (SELECT k2.Kraj [Kraj] 
 	 	 	, z2.IDzamówienia 
 	 	 	, SUM(pz2.CenaJednostkowa * pz2.Ilość) [Wartość zamówienia] 
 	 	FROM Klienci k2 JOIN Zamówienia z2 
 	 	 	ON k2.IDklienta = z2.IDklienta 
 	 	 	JOIN PozycjeZamówienia pz2 
 	 	 	ON z2.IDzamówienia = pz2.IDzamówienia 
 	 	 	JOIN Pracownicy p2 
 	 	 	ON z2.IDpracownika = p2.IDpracownika 
 	 	WHERE p2.Kraj <> 'USA' 
 	 	GROUP BY k2.Kraj, z2.IDzamówienia) a2 
 	ON z1.IDzamówienia = a2.IDzamówienia 
GROUP BY a2.Kraj 
-- CPU time = 15 ms,  elapsed time = 19 ms. 
-- zad 5 
SELECT DATEDIFF(DAY, MIN(DataZamówienia), MAX(DataZamówienia)) 
FROM Zamówienia 
-- 6178 dni 
 
-- zad 6 
SELECT AVG(DATEDIFF(DAY, DataZamówienia, DataWysyłki)) 
FROM Zamówienia 
-- średnio 8 dni 
 
-- zad 7 
SELECT MAX(DATEDIFF(DAY, DataWymagana, DataWysyłki)) 
FROM Zamówienia 
-- 23 dni 
 
-- zad 8 
SELECT IDzamówienia, DATEDIFF(DAY, DataWymagana, DataWysyłki) AS [Opoznienie w dniach] FROM Zamówienia 
WHERE DATEDIFF(DAY, DataWymagana, DataWysyłki) > 0 
-- 38 wierszy 
 
-- zad 9 
SELECT COUNT(DATEDIFF(DAY, DataWymagana, DataWysyłki)) AS [Liczba zamówień] 
FROM Zamówienia 
WHERE DATEDIFF(DAY, DataWymagana, DataWysyłki) > 10 
-- 6 zamówień ma opóźnienie w realizacji większe niż 10 dni 
 
-- zad 10 
SELECT DATEDIFF(DAY, b.DataZamówienia, a.DataZamówienia) AS 'Różnice dni między kolejnymi zamówieniami' FROM  
(SELECT ROW_NUMBER() OVER(ORDER BY z.DataZamówienia) AS [Numer zamówienia], z.DataZamówienia 
 	FROM Zamówienia z JOIN Pracownicy p ON z.IDpracownika = p.IDpracownika 
 	WHERE p.Imię LIKE 'Margaret' AND p.Nazwisko LIKE 'Peacock') a 
JOIN  
(SELECT ROW_NUMBER() OVER(ORDER BY z.DataZamówienia) AS [Numer zamówienia], z.DataZamówienia 
 	FROM Zamówienia z JOIN Pracownicy p ON z.IDpracownika = p.IDpracownika 
 	WHERE p.Imię LIKE 'Margaret' AND p.Nazwisko LIKE 'Peacock') b 
ON a.[Numer zamówienia] = (b.[Numer zamówienia] + 1) 
-- 155 wierszy 
 
-- zad 11 
SELECT a.IDpracownika,  
AVG(DATEDIFF(DAY, b.DataZamówienia, a.DataZamówienia)) AS 'Średnia różnica dni między kolejnymi zamówieniami' 
FROM  
 	(SELECT IDpracownika, DataZamówienia, 
 	ROW_NUMBER() OVER(ORDER BY IDPracownika, DataZamówienia) AS [Numer zamówienia] 
 	FROM Zamówienia 
 	WHERE IDpracownika IS NOT NULL) a 
JOIN  
 	(SELECT IDpracownika, DataZamówienia, 
 	ROW_NUMBER() OVER(ORDER BY IDPracownika, DataZamówienia) AS [Numer zamówienia]  
 	FROM Zamówienia 
 	WHERE IDpracownika IS NOT NULL) b 
ON a.[Numer zamówienia] = (b.[Numer zamówienia] + 1) AND a.IDpracownika = b.IDpracownika GROUP BY a.IDpracownika 
-- 9 wierszy 

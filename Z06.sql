-- zad 1 
SELECT Miasto, 'Klienci' [Tabela] 
FROM Klienci 
WHERE Miasto IS NOT NULL 
UNION 
 	SELECT Miasto, 'Pracownicy' [Tabela] 
 	FROM Pracownicy 
 	WHERE Miasto IS NOT NULL 
 	ORDER BY [Tabela], Miasto; 
-- 81 wierszy 
 
-- zad 2 
SELECT Miasto, LEN(Miasto) 'Długość Nazwy' 
FROM Klienci 
WHERE Miasto IS NOT NULL 
UNION 
 	SELECT Miasto, LEN(Miasto) 
 	FROM Pracownicy 
 	WHERE Miasto IS NOT NULL 
UNION 
 	SELECT Miasto, LEN(Miasto) 
 	FROM Dostawcy 
 	WHERE Miasto IS NOT NULL 
ORDER BY LEN(Miasto) DESC; 
-- 107 wierszy 
 
-- zad 3 
SELECT Kraj 
FROM Klienci 
WHERE NazwaFirmy LIKE '[A-D]%' AND Kraj IS NOT NULL 
UNION 
 	SELECT Kraj 
 	From Dostawcy 
 	WHERE Kraj LIKE 'Niemcy' 
 	OR Kraj LIKE 'Polska' 
 	OR Kraj LIKE 'USA' 
ORDER BY Kraj; 
-- 12 wierszy 
 
-- zad 4 
SELECT DataZamówienia 
FROM Zamówienia z 
JOIN Pracownicy p ON z.IDpracownika=p.IDpracownika 
WHERE p.Imię LIKE 'Laura' AND p.Nazwisko LIKE 'CAllahan' 
INTERSECT 
 	SELECT DataZamówienia 
 	FROM Zamówienia z 
 	JOIN Pracownicy p ON z.IDpracownika=p.IDpracownika 
 	WHERE p.Imię LIKE 'Janet' AND p.Nazwisko LIKE 'Leverling' 
INTERSECT 
 	SELECT DataZamówienia 
 	FROM Zamówienia z 
 	JOIN Pracownicy p ON z.IDpracownika=p.IDpracownika 
 	WHERE p.Imię LIKE 'Robert' AND p.Nazwisko LIKE 'King'; 
-- 1 wiersz - 1998-04-27 00:00:00.000 
 
  
-- zad 5 
SELECT Miasto 
FROM Pracownicy 
EXCEPT 
 	SELECT Miasto 
 	FROM Klienci 
EXCEPT 
 	SELECT Miasto 
 	FROM Dostawcy; 
-- 4 wiersze 
 
-- zad 6 
SELECT DataZamówienia 
FROM Zamówienia 
EXCEPT 
 	SELECT DataWymagana 
 	FROM Zamówienia 
EXCEPT 
 	SELECT DataWysyłki 
 	FROM Zamówienia; 
-- 15 wierszy 
 
-- zad 7 
SELECT DISTINCT k.Miasto 
FROM Klienci k, Dostawcy d WHERE k.Miasto = d.Miasto; 
-- 6 wierszy 
 
-- zad 8 
SELECT DISTINCT Miasto 
FROM Pracownicy 
WHERE Miasto NOT IN  
 	(SELECT Miasto 
 	FROM Dostawcy); 
-- 7 wierszy 
 

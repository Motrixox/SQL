-- zad 1
WITH cte_WZ(IDz, wz) AS 
( 
 	SELECT IDzamówienia, SUM(CenaJednostkowa * Ilość) 
 	FROM PozycjeZamówienia 
 	GROUP BY IDzamówienia 
), 
cte_Avg_WZ(avg_wz) AS 
( 
 	SELECT AVG(wz) 
 	FROM cte_WZ 
), 
cte_ZUpA(ID, wartość) AS 
( 
 	SELECT IDz, wz 
 	FROM cte_WZ 
 	WHERE wz > (SELECT avg_wz FROM cte_Avg_WZ) 
) 
SELECT * FROM cte_ZUpA; 
-- 288 wierszy 
 
-- zad 2 a 
SELECT NazwaFirmy, Kraj 
 	FROM Klienci 
 	WHERE IDklienta NOT IN 
 	 	(SELECT DISTINCT IDklienta 
 	 	FROM Zamówienia 
 	 	WHERE IDpracownika = 6); 
-- 53 wiersze 
 
-- zad 2 b 
WITH cte_xxx(IDklienta) AS 
( 
 	SELECT DISTINCT IDklienta 
 	FROM Zamówienia 
 	WHERE IDpracownika = 6 
), 
cte_yyy(NazwaFirmy, Kraj) AS 
( 
 	SELECT NazwaFirmy, Kraj 
 	FROM Klienci 
 	WHERE IDklienta NOT IN (SELECT * FROM cte_xxx) 
) 
SELECT * FROM cte_yyy; 
-- 53 wiersze 
 
-- zad 3 
WITH cte_xxx(Rok, IDzamówienia, Wartość) AS 
( 
 	SELECT YEAR(z.DataZamówienia), z.IDzamówienia, 
 	SUM(pz.CenaJednostkowa * pz.Ilość) 
 	FROM Zamówienia z 
 	JOIN PozycjeZamówienia pz ON z.IDzamówienia = pz.IDzamówienia 
 	GROUP BY YEAR(z.DataZamówienia), z.IDzamówienia 
), 
cte_yyy(Rok, [Średnia Wartość Zamówienia]) AS 
( 
 	SELECT Rok, AVG(Wartość) 
 	FROM cte_xxx 
 	GROUP BY Rok 
) 
SELECT * FROM cte_yyy; 
-- 3 wiersze 

-- zad 4
DROP VIEW IF EXISTS dbo.v_Wartość_pozycji_zamówienia; 
GO 
 
CREATE VIEW v_Wartość_pozycji_zamówienia (IDzamówienia, 
 	 	 	 	 	 	 	 	 	 	NazwaProduktu, 
 	 	 	 	 	 	 	 	 	 	WPZ) AS 
( 
 	SELECT pz.IDzamówienia, p.NazwaProduktu, (pz.CenaJednostkowa * pz.Ilość) 
 	FROM PozycjeZamówienia pz 
 	JOIN Produkty p ON pz.IDproduktu = p.IDproduktu 
); 
GO 
 
SELECT * FROM v_Wartość_pozycji_zamówienia; 
-- 2155 wierszy 
  
-- zad 5 
SELECT z.IDzamówienia, z.DataZamówienia, 
COUNT(wpz.NazwaProduktu) 'LPZ', SUM(wpz.WPZ) 'SWZ' 
FROM Zamówienia z 
JOIN v_Wartość_pozycji_zamówienia wpz ON wpz.IDzamówienia = z.IDzamówienia 
GROUP BY z.IDzamówienia, z.DataZamówienia 
-- 830 wierszy 
  
-- zad 6 
DROP VIEW IF EXISTS dbo.v_Drukuj_Faktury; 
GO 
 
CREATE VIEW v_Drukuj_Faktury (IDzamówienia, 
 	 	 	 	 	 	 	DataZamówienia, 
 	 	 	 	 	 	 	Pracownik, 
 	 	 	 	 	 	 	NazwaFirmy, 
 	 	 	 	 	 	 	Adres, 
 	 	 	 	 	 	 	WZ) AS 
( 
 	SELECT z.IDzamówienia, z.DataZamówienia, CONCAT(p.Imię, ' ', p.Nazwisko),  	k.NazwaFirmy, CONCAT(k.Kraj, '; ', k.Adres), SUM(wpz.WPZ) 
 	FROM v_Wartość_pozycji_zamówienia wpz 
 	JOIN Zamówienia z ON z.IDzamówienia = wpz.IDzamówienia 
 	JOIN Pracownicy p ON p.IDpracownika = z.IDpracownika 
 	JOIN Klienci k ON k.IDklienta = z.IDklienta 
 GROUP BY z.IDzamówienia, z.DataZamówienia, p.Imię, p.Nazwisko, k.NazwaFirmy, k.Kraj, k.Adres 
); 
GO 
 
SELECT * FROM v_Drukuj_Faktury; 
-- 830 wierszy 
 
 
-- zad 7 
DROP TABLE IF EXISTS dbo.Faktury; 
GO 
SELECT IDzamówienia, DataZamówienia, Pracownik, NazwaFirmy, Adres, WZ 
INTO Faktury 
FROM dbo.v_Drukuj_Faktury 
-- 830 rows affected 
  
-- zad 8
DROP VIEW IF EXISTS dbo.v_Faktury; 
GO 
 
CREATE VIEW v_Faktury (IDzamówienia, 
 	 	 	 	 	DataZamówienia, 
 	 	 	 	 	Pracownik, 
 	 	 	 	 	NazwaFirmy, 
 	 	 	 	 	Adres, 
 
( 	 	 	 	 	WZ) AS 
 	SELECT * 		
 
); 	FROM Faktury 		
GO 
 
SELECT * FROM v_Faktury; 
-- 830 wierszy 
 
-- zad 9 a 
SELECT * 
FROM v_Faktury 
WHERE YEAR(DataZamówienia) = 1997 
AND MONTH(DataZamówienia) = 7 
ORDER BY DataZamówienia 
-- 33 wiersze 
 
-- zad 9 b 
SELECT * 
FROM v_Faktury 
WHERE LEFT(Adres, CHARINDEX(';', Adres) - 1) LIKE 'Francja' 
OR LEFT(Adres, CHARINDEX(';', Adres) - 1) LIKE 'USA' 
-- 199 wierszy 
 
-- zad 10 a 
UPDATE v_Faktury 
SET WZ = 0 
WHERE Pracownik LIKE 'Michael Suyama' 
 
SELECT * FROM Faktury 
WHERE Pracownik LIKE 'Michael Suyama' 
-- wiersze zmieniły się zarówno w widoku, jak i w tabeli Faktury 
 
-- zad 10 b 
DELETE FROM v_Faktury 
WHERE WZ < 100 
 
SELECT * FROM Faktury 
WHERE WZ < 100 
-- wiersze usunęły się zarówno z widoku, jak i z tabeli Faktury 

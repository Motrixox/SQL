-- zad 1
 CONCAT(pr.Imię, ' ', pr.Nazwisko) AS Pracownik, 
CONCAT(sz2.Imię, ' ', sz2.Nazwisko) AS Szef 
FROM Pracownicy sz  
 	RIGHT OUTER JOIN Pracownicy pr ON pr.IDpracownika = sz.Szef 
 	JOIN Pracownicy sz2 ON sz2.IDpracownika = pr.Szef 
WHERE sz.IDPracownika IS NULL; 
-- 10 wierszy 
 
-- zad 2 
SELECT p.Miasto AS 'Miasto Pracownika', k.Miasto AS 'Miasto Klienta' 
FROM Pracownicy p  
 	LEFT OUTER JOIN Klienci k ON p.Miasto = k.Miasto 
WHERE k.Miasto IS NULL; 
-- 5 wierszy 
 
-- zad 3 
SELECT DISTINCT d.Kraj AS 'Kraj dostawcy', k.Kraj AS 'Kraj klienta' 
FROM Dostawcy d  
 	FULL OUTER JOIN Klienci k ON d.Kraj = k.Kraj 
WHERE (k.Kraj IS NULL OR d.Kraj IS NULL) 
AND (k.Kraj IS NOT NULL OR d.Kraj IS NOT NULL); 
-- 15 wierszy 
 
-- zad 4 
SELECT DISTINCT p.NazwaProduktu, tab.Kraj 
FROM Produkty p 
 	--JOIN Dostawcy d ON d.IDdostawcy = p.IDdostawcy 
 	LEFT OUTER JOIN 
 	 	(SELECT DISTINCT p.IDproduktu, p.NazwaProduktu, d.Kraj 
 	 	FROM Produkty p 
 	 	JOIN Dostawcy d ON d.IDdostawcy = p.IDdostawcy 
 	 	JOIN PozycjeZamówienia pz ON pz.IDproduktu = p.IDproduktu 
 	 	JOIN Zamówienia z ON z.IDzamówienia = pz.IDzamówienia 
 	 	WHERE YEAR(z.DataZamówienia) = 1996 
 	 	AND Month(z.DataZamówienia) >= 10) AS tab 
 	ON p.IDkategorii = tab.IDproduktu 
WHERE tab.NazwaProduktu IS NULL 
ORDER BY p.NazwaProduktu; 
-- 15 wierszy 
 
-- zad 5 
SELECT DISTINCT pr.Imię, pr.Nazwisko, tab.IDzamówienia 
FROM Pracownicy pr 
 	LEFT JOIN 
 	 	(SELECT DISTINCT pr.Imię, pr.Nazwisko, z.IDzamówienia 
 	 	FROM Pracownicy pr 
 	 	JOIN Zamówienia z ON z.IDpracownika = pr.IDpracownika 
 	 	WHERE YEAR(z.DataZamówienia) = 1997 
 	 	AND Month(z.DataZamówienia) >= 7 
 	 	AND (z.KrajOdbiorcy = 'Kanada' 
 	 	OR z.KrajOdbiorcy = 'Meksyk')) AS tab 
 	ON pr.Imię = tab.Imię AND pr.Nazwisko = tab.Nazwisko 
WHERE tab.IDzamówienia IS NULL 
ORDER BY Nazwisko, Imię 
-- 8 wierszy 
  
-- zad 6
 DISTINCT pr.NazwaProduktu, k.NazwaKategorii 
FROM Produkty pr 
 	JOIN Kategorie k ON k.IDkategorii = pr.IDkategorii 
 	LEFT JOIN 
 	 	(SELECT DISTINCT pr.IDproduktu, pr.NazwaProduktu, k.NazwaKategorii 
 	 	FROM Produkty pr 
 	 	JOIN Kategorie k ON k.IDkategorii = pr.IDkategorii 
 	 	JOIN PozycjeZamówienia pz ON pz.IDproduktu = pr.IDproduktu 
 	 	JOIN Zamówienia z ON z.IDzamówienia = pz.IDzamówienia 
 	 	JOIN Pracownicy p ON p.IDpracownika = z.IDpracownika 
 	 	WHERE z.IDpracownika = 3) AS tab 
 	ON pr.IDproduktu = tab.IDproduktu 
WHERE tab.NazwaProduktu IS NULL 
ORDER BY k.NazwaKategorii, pr.NazwaProduktu; 
-- 8 wierszy 
 
-- zad 7 
SELECT k.NazwaKategorii, COUNT(p.NazwaProduktu) AS [Liczba Produktów] 
FROM Kategorie k 
 	JOIN Produkty p ON p.IDkategorii = k.IDkategorii 
 	LEFT OUTER JOIN 
 	 	(SELECT DISTINCT p.IDproduktu, k.NazwaKategorii, p.NazwaProduktu 
 	 	FROM Kategorie k  
 	 	JOIN Produkty p ON k.IDKategorii = p.IDKategorii 
 	 	JOIN PozycjeZamówienia pz ON pz.IDproduktu = p.IDproduktu 
 	 	JOIN Zamówienia z ON z.IDzamówienia = pz.IDzamówienia 
 	 	WHERE z.KrajOdbiorcy = 'Argentyna' 
 	 	OR z.KrajOdbiorcy = 'Japonia' 
 	 	OR z.KrajOdbiorcy = 'Wielka Brytania') AS tab 
 	ON tab.IDproduktu = p.IDproduktu 
WHERE tab.NazwaProduktu IS NULL 
GROUP BY k.NazwaKategorii 
ORDER BY [Liczba Produktów] DESC 
-- 9 wierszy 
 
-- zad 8 
SELECT p.IDproduktu, p.NazwaProduktu 
FROM Produkty p 
 	LEFT OUTER JOIN 
 	 	(SELECT DISTINCT p.IDproduktu, p.NazwaProduktu 
 	 	FROM Produkty p 
 	 	JOIN PozycjeZamówienia pz ON pz.IDproduktu = p.IDproduktu 
 	 	JOIN Zamówienia z ON z.IDzamówienia = pz.IDzamówienia) AS tab 
 	ON tab.IDproduktu = p.IDproduktu 
WHERE tab.IDproduktu IS NULL 
ORDER BY p.NazwaProduktu 
-- 5 wierszy 
  
 
  
   
  
-- zad 9
 k.IDkategorii, k.NazwaKategorii 
FROM Kategorie k 
 	LEFT OUTER JOIN 
 	 	(SELECT DISTINCT k.IDkategorii, k.NazwaKategorii 
 	 	FROM Kategorie k  
 	 	JOIN Produkty p ON k.IDKategorii = p.IDKategorii 
 	 	JOIN PozycjeZamówienia pz ON pz.IDproduktu = p.IDproduktu 
 	 	JOIN Zamówienia z ON z.IDzamówienia = pz.IDzamówienia 
 	 	WHERE z.KrajOdbiorcy = 'Polska') AS tab 
 	ON tab.IDkategorii = k.IDkategorii 
WHERE tab.IDkategorii IS NULL 
ORDER BY k.NazwaKategorii 
-- 3 wiersze 
 
-- zad 10 
SELECT k.NazwaFirmy, k.Kraj 
FROM Klienci k 
 	LEFT OUTER JOIN 
 	 	(SELECT DISTINCT k.NazwaFirmy 
 	 	FROM Klienci k  
 	 	JOIN Zamówienia z ON z.IDklienta = k.IDklienta 
 	 	WHERE z.IDpracownika = 6) AS tab 
 	ON tab.NazwaFirmy = k.NazwaFirmy 
WHERE tab.NazwaFirmy IS NULL 
ORDER BY k.Kraj, k.NazwaFirmy 
-- 53 wiersze 
 

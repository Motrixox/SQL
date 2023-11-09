-- zad 1 
SELECT p1.Imię, p1.Nazwisko, p1.DataUrodzenia, p2.Imię AS 'Imię szefa', p2.Nazwisko AS 'Nazwisko Szefa' 
FROM Pracownicy p1 JOIN Pracownicy p2 
ON p1.Szef = p2.IDpracownika 
WHERE p2.Imię LIKE 'Andrew' AND p2.Nazwisko LIKE 'Fuller'; 
-- 5 wierszy 
 
-- zad 2 
SELECT p.NazwaProduktu, k.NazwaKategorii, p.CenaJednostkowa 
From Produkty p JOIN Kategorie k 
ON p.IDkategorii = k.IDkategorii; 
-- 82 wiersze 
 
-- zad 3 
SELECT k.NazwaFirmy, z.DataZamówienia, pr.Imię + ' ' + pr.Nazwisko AS 'Pracownik', p.NazwaProduktu, s.NazwaFirmy AS 'Spedytor' 
FROM Produkty p 
JOIN PozycjeZamówienia pz ON pz.IDproduktu = p.IDproduktu 
JOIN Zamówienia z ON z.IDzamówienia = pz.IDzamówienia 
JOIN Spedytorzy s ON z.IDspedytora = s.IDspedytora 
JOIN Pracownicy pr ON z.IDpracownika = pr.IDpracownika 
JOIN Klienci k ON z.IDklienta = k.IDklienta 
WHERE p.NazwaProduktu LIKE 'Konbu' 
AND YEAR(z.DataZamówienia) = 1997 
AND Month(z.DataZamówienia) > 3 
AND Month(z.DataZamówienia) < 7; 
-- 3 wiersze 
 
-- zad 4 
SELECT z.IDzamówienia AS 'Numer Faktury', z.DataZamówienia, 
k.NazwaFirmy AS 'Klient', pr.Imię + ' ' + pr.Nazwisko AS 'Pracownik', p.NazwaProduktu, s.NazwaFirmy AS 'Spedytor' 
FROM Produkty p 
JOIN PozycjeZamówienia pz ON pz.IDproduktu = p.IDproduktu 
JOIN Zamówienia z ON z.IDzamówienia = pz.IDzamówienia 
JOIN Spedytorzy s ON z.IDspedytora = s.IDspedytora 
JOIN Pracownicy pr ON z.IDpracownika = pr.IDpracownika 
JOIN Klienci k ON z.IDklienta = k.IDklienta 
WHERE z.IDzamówienia = 10248; 
-- 3 wiersze 
 
-- zad 5 
SELECT DISTINCT k.NazwaKategorii AS 'Nazwa kategorii', d.NazwaFirmy AS 'Nazwa dostawcy' 
FROM Produkty p 
JOIN Kategorie k ON k.IDkategorii = p.IDkategorii 
JOIN Dostawcy d ON p.IDdostawcy = d.IDdostawcy; 
-- 52 wiersze 
 
-- zad 6 
SELECT DISTINCT k.NazwaKategorii AS 'Nazwa kategorii', d.NazwaFirmy AS 'Nazwa dostawcy', 
d.Kraj FROM Produkty p 
JOIN Kategorie k ON k.IDkategorii = p.IDkategorii 
JOIN Dostawcy d ON p.IDdostawcy = d.IDdostawcy 
WHERE d.Kraj LIKE 'USA' 
AND k.NazwaKategorii LIKE 'Przyprawy'; 
-- 2 wiersze 
 
-- zad 7 
SELECT DISTINCT k.NazwaFirmy AS 'Nazwa Klienta', 
z.IDzamówienia AS 'Numer zamówienia', 
z.DataZamówienia 
FROM Klienci k 
JOIN Zamówienia z ON z.IDklienta = k.IDklienta 
WHERE z.DataZamówienia IS NULL; 
-- 2 wiersze 
 
-- 8 zad 
SELECT d.NazwaFirmy AS 'Nazwa Dostawcy', d.Kraj, 
p.NazwaProduktu FROM Produkty p 
JOIN Dostawcy d ON p.IDdostawcy = d.IDdostawcy; 
-- 82 wiersze 
 
-- 9 zad 
SELECT DISTINCT p2.Imię, p2.Nazwisko 
FROM Pracownicy p1 JOIN Pracownicy p2 
ON p1.Szef = p2.IDpracownika; 
-- 3 wiersze 
 
-- 10 zad 
SELECT z.IDzamówienia, k.NazwaFirmy 
FROM Zamówienia z JOIN Klienci k ON z.IDklienta = k.IDklienta 
JOIN Pracownicy p ON p.IDpracownika = z.IDpracownika 
ORDER BY p.Nazwisko, z.DataZamówienia DESC; 
-- 833 wiersze 
 
-- 11 zad 
SELECT z.IDzamówienia AS 'Numer zamówienia', p.NazwaProduktu, 
d.NazwaFirmy, 
d.Kraj 
FROM Produkty p JOIN Dostawcy d ON d.IDdostawcy = p.IDdostawcy 
JOIN PozycjeZamówienia pz ON pz.IDproduktu = p.IDproduktu 
JOIN Zamówienia z ON z.IDzamówienia = pz.IDzamówienia; 
-- 2155 wierszy 
 
-- 12 zad 
SELECT k.NazwaFirmy, k.Kraj, (p.Imię + ' ' + p.Nazwisko) AS 'Pracownik', p.Kraj 
FROM Klienci k JOIN Zamówienia z ON z.IDklienta = k.IDklienta 
JOIN Pracownicy p ON z.IDpracownika = p.IDpracownika; 
-- 833 wiersze 
 
-- 13 zad  
SELECT z.DataZamówienia, 
k.NazwaFirmy AS 'Klient', 
s.NazwaFirmy AS 'Spedytor', 
z.DataWysyłki FROM Zamówienia z  
JOIN Spedytorzy s ON z.IDspedytora = s.IDspedytora 
JOIN Klienci k ON z.IDklienta = k.IDklienta 
WHERE YEAR(z.DataZamówienia) = 1997  
AND MONTH(z.DataZamówienia) = 9; 
-- 37 wierszy 
 
-- 14 zad 
SELECT DISTINCT p.Miasto 
FROM Pracownicy p JOIN Klienci k ON p.Miasto = k.Miasto; 
-- tak, istnieją 4 takie miasta 
 
-- 15 zad 
SELECT DISTINCT p.Miasto 
FROM Pracownicy p JOIN Klienci k ON p.Miasto = k.Miasto 
JOIN Dostawcy d ON d.Miasto = p.Miasto; 
-- tak, istnieje 1 takie miasto 
 
-- 16 zad  
SELECT DISTINCT d.NazwaFirmy, d.Kraj 
FROM Dostawcy d JOIN Produkty p ON p.IDdostawcy = d.IDdostawcy 
JOIN Kategorie k ON k.IDkategorii = p.IDkategorii 
WHERE k.NazwaKategorii LIKE 'Mięso/Drób'; 
-- 6 wierszy 
 
-- 17 zad 
SELECT p.NazwaProduktu, k.NazwaKategorii, p.CenaJednostkowa, p.StanMagazynu 
FROM Produkty p JOIN Kategorie k ON k.IDkategorii = p.IDkategorii 
WHERE p.CenaJednostkowa >= 55  
AND p.CenaJednostkowa <= 97 
OR p.StanMagazynu = 0; 
-- 11 wierszy 

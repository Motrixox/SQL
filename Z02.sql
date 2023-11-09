USE BD1_21D_3b 
GO 
 
-- zad 1 
SELECT GETDATE(); 
 
-- zad 2 
SELECT ('SELECT * FROM tabela;'); 
 
-- zad 3 
SELECT IDzamówienia, (CenaJednostkowa * Ilość) AS 'Wartość' FROM PozycjeZamówienia; 
 
-- zad 4 
SELECT TOP 1 IDzamówienia, (CenaJednostkowa * Ilość) AS 'Wartość' FROM PozycjeZamówienia 
ORDER BY Wartość DESC; 
 
-- zad 5 
SELECT Nazwisko, Imię, (YEAR(GETDATE()) - YEAR(DataUrodzenia)) AS 'Wiek' FROM Pracownicy 
ORDER BY Wiek; 
 
-- zad 6 
SELECT PI() AS 'Pole koła o promieniu 1m'; 
 
-- zad 7 
SELECT CONCAT(NazwaFirmy, ' (', Kraj, ' ', Miasto, ' ', Adres, ' ', KodPocztowy, ')') FROM 
Dostawcy; 
 
-- zad 8 
SELECT 4*PI(); 
 
-- zad 9 
SELECT * FROM Dostawcy WHERE Kraj = 'Polska' OR Kraj = 'Szwecja'; 
 
-- zad 10 
SELECT * FROM Klienci WHERE Telefon IS NOT NULL AND Faks IS NULL; 
 
-- zad 11 
SELECT * FROM Produkty WHERE (IDdostawcy = 1 OR IDdostawcy = 2 OR IDdostawcy = 4 OR 
IDdostawcy = 5 OR IDdostawcy = 9) AND IDkategorii = 6; 
 
-- zad 12 
SELECT * FROM Produkty WHERE Wycofany = 1 AND StanMagazynu > 0; 
 
-- zad 13 
SELECT * FROM Produkty WHERE Wycofany = 0 AND StanMagazynu = 0;  

-- zad 14 
SELECT * FROM Produkty WHERE IDkategorii = 3 AND CenaJednostkowa <= 15.99;  

-- zad 15 
SELECT * FROM Zamówienia WHERE DataWysyłki BETWEEN '1997-01-01 00:00:00.000' AND '1997-03-
31 23:59:59.999' 
 
-- zad 16 
SELECT * FROM Zamówienia WHERE DataWysyłki > DataWymagana; 
 

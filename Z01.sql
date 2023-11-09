-- zad 1
SELECT * FROM PozycjeZamówienia;

-- zad 2
SELECT NazwaFirmy, Adres, Miasto, Kraj FROM Klienci ORDER BY Kraj, Miasto;

-- zad 3
SELECT TOP 15 PERCENT NazwaProduktu, CenaJednostkowa FROM Produkty ORDER BY
CenaJednostkowa;

-- zad 4
SELECT DISTINCT Kraj FROM Pracownicy;

-- zad 5
SELECT DISTINCT Miasto FROM Klienci;

-- zad 6
SELECT NazwaFirmy, Telefon FROM Klienci ORDER BY Kraj DESC, Miasto;

-- zad 7
SELECT DISTINCT DataZamówienia FROM Zamówienia;

-- zad 8
SELECT DISTINCT Imię FROM Pracownicy ORDER BY Nazwisko; -- nie można

-- zad 9
SELECT DISTINCT Miasto FROM Dostawcy ORDER BY Miasto; -- tak, można

-- zad 10
SELECT DISTINCT NazwaProduktu, CenaJednostkowa FROM Produkty ORDER BY NazwaProduktu;
-- tak, można
-- zad 1 
SELECT NazwaProduktu AS 'Lista produktów', (CenaJednostkowa * StanMagazynu) AS 'Wartości produktów'  FROM Produkty 
WHERE (CenaJednostkowa * StanMagazynu) >= 225 OR (CenaJednostkowa * StanMagazynu) <= 15 
ORDER BY 'Wartości produktów' DESC;  
-- 69 wierszy 
 
-- zad 2 
SELECT NazwaProduktu AS 'Lista produktów', (CenaJednostkowa * StanMagazynu) AS 'Wartości produktów'  FROM Produkty 
WHERE (CenaJednostkowa * StanMagazynu) >= 2 AND (CenaJednostkowa * StanMagazynu) < 25 
OR (CenaJednostkowa * StanMagazynu) > 35 AND (CenaJednostkowa * StanMagazynu) < 100; 
-- 7 wierszy 
 
-- zad 3 a 
SELECT NazwaProduktu AS 'Lista produktów', (CenaJednostkowa * StanMagazynu) AS 'Wartości produktów'  FROM Produkty 
WHERE (CenaJednostkowa * StanMagazynu) < 13.99 OR (CenaJednostkowa * StanMagazynu) > 
75.99; 
-- 75 wierszy 
 
-- zad 3 b 
SELECT NazwaProduktu AS 'Lista produktów', (CenaJednostkowa * StanMagazynu) AS 'Wartości produktów'  FROM Produkty 
WHERE (CenaJednostkowa * StanMagazynu) NOT BETWEEN 13.99 AND 75.99; 
-- 75 wierszy 
 
-- zad 4 
SELECT NazwaProduktu  
FROM Produkty WHERE StanMagazynu = 0 AND IDkategorii != 1 AND IDkategorii != 3 AND IDkategorii != 5; 
-- 5 wierszy 
 
-- zad 5 
SELECT DISTINCT Miasto 
FROM Klienci 
WHERE Miasto LIKE '______' AND Miasto NOT LIKE '%n%'; 
-- 6 wierszy 
 
-- zad 6 
SELECT DISTINCT NazwaProduktu 
FROM Produkty 
WHERE NazwaProduktu LIKE '_____' AND NazwaProduktu LIKE '%a%'; 
-- 3 wiersze 
 
-- zad 7 
SELECT DISTINCT Kraj 
FROM Klienci 
WHERE NazwaFirmy LIKE '% % % %'  
 	AND NazwaFirmy LIKE '%a%a%a%'  
 	AND NazwaFirmy NOT LIKE '% % % % %' 
ORDER BY Kraj; 
-- 3 wiersze 
 
-- zad 8 
SELECT DISTINCT Kraj 
FROM Klienci 
WHERE Miasto LIKE '_____'; 
-- 5 wierszy 
 
-- zad 9 
SELECT NazwaFirmy 
FROM Klienci 
WHERE NazwaFirmy LIKE '% %' AND NazwaFirmy NOT LIKE '% % %'; 
-- 42 wiersze 
 
-- zad 10 
SELECT NazwaFirmy 
FROM Klienci 
WHERE NazwaFirmy LIKE '[a,A,c,C,m,M]%' 
ORDER BY NazwaFirmy; 
-- 15 wierszy 
 
-- zad 11 
SELECT NazwaProduktu 
FROM Produkty 
WHERE NazwaProduktu LIKE '[D-F,X-Z,d-f,x-z]%' 
ORDER BY NazwaProduktu; 
-- 4 wiersze 
 
-- zad 12 
SELECT NazwaFirmy 
FROM Klienci 
WHERE Kraj IS NULL OR Miasto IS NULL OR Adres IS NULL; 
-- tak, jest jedna taka firma 
 
-- zad 13 
SELECT DISTINCT Kraj 
FROM Klienci 
WHERE Adres LIKE 'Av.%' 
ORDER BY Kraj; 
-- 2 wiersze 
 
-- zad 14 
SELECT DISTINCT MONTH(DataZamówienia) AS MIESIAC, YEAR(DataZamówienia) AS ROK FROM Zamówienia 
WHERE DataWysyłki IS NULL AND DataZamówienia IS NOT NULL 
ORDER BY ROK, MIESIAC; 
-- 2 wiersze 
 
-- zad 15 
SELECT IDzamówienia, DAY(DataWysyłki - DataZamówienia) AS 'Liczba Dni', DataWysyłki, DataZamówienia 
FROM Zamówienia 
WHERE YEAR(DataZamówienia) = 1997  
 	AND MONTH(DataZamówienia) % 2 = 0 
 	AND DAY(DataWysyłki - DataZamówienia) <= 14 
ORDER BY DAY(DataWysyłki - DataZamówienia); 
-- 181 wierszów 
 

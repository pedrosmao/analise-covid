--Mortes por país (soma total de mortes por milhão)

CREATE VIEW [Total de Mortes por País] AS
SELECT country AS pais, SUM(new_deaths) AS total_mortes
FROM Deaths_Covid
GROUP BY country;

SELECT * FROM [Total de Mortes por País]
ORDER BY total_mortes DESC;


--Mortes por dia em um país específico

SELECT date, new_deaths
FROM Deaths_Covid
WHERE country = 'Brazil'
ORDER BY date;

--Total de mortes em país e ano específico
SELECT country, SUM(new_deaths) as total_2020
from Deaths_Covid
WHERE country = 'United States' and date BETWEEN '2020-01-01' AND '2020-12-31'
GROUP BY country
ORDER BY total_2020;

--Top 10 países com mais mortes por milhão

SELECT TOP 10 country, SUM(new_deaths) as total_mortes
FROM Deaths_Covid	
GROUP BY country
ORDER BY total_mortes desc;

-- Evolução acumulada por país

SELECT date, country,
       SUM(new_deaths) OVER (
           PARTITION BY country	
           ORDER BY date	
           ROWS UNBOUNDED PRECEDING
       ) AS mortes_acumuladas
FROM Deaths_Covid
ORDER BY country, date;


--Dia com mais mortes em um país específico

SELECT TOP 1 *
FROM Deaths_Covid
WHERE country = 'Brazil'
ORDER BY new_deaths DESC;

--Primeiros 5 países a ter casos de morte

SELECT TOP 5 country AS pais, MIN(date) AS primeiro_dia_com_morte, new_deaths
FROM Deaths_Covid
WHERE new_deaths <> 0
GROUP BY country, new_deaths
ORDER BY primeiro_dia_com_morte;


--Top 5 países com mais mortes

SELECT TOP 5 country, SUM(new_deaths) as pico_morte
FROM Deaths_Covid
GROUP BY country
ORDER BY pico_morte DESC;

--MÉDIA DE MORTE POR PAÍS

SELECT country, AVG(new_deaths) AS média_morte
FROM Deaths_Covid
GROUP BY country
ORDER BY média_morte DESC;

--TOP 10 Paises que não tiveram casos de covid

SELECT TOP 10 country, SUM(new_deaths) as total_morte
FROM Deaths_Covid
GROUP BY country
HAVING SUM(new_deaths) = 0
ORDER BY total_morte ASC;


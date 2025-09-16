--Mortes por pa�s (soma total de mortes por milh�o)
CREATE VIEW [Total de Mortes por Pa�s] AS
SELECT Entity AS pais, SUM(Deaths_per_million) AS total_mortes_por_milhao
FROM DeathsPerMillion
GROUP BY Entity;

SELECT * FROM [Total de Mortes por Pa�s]
ORDER BY total_mortes_por_milhao ASC;

--Mortes por dia em um pa�s espec�fico

SELECT Day, Deaths_per_million
FROM DeathsPerMillion
WHERE Entity = 'Brazil'
ORDER BY Day;

--Top 10 pa�ses com mais mortes por milh�o

SELECT TOP 10 Entity, SUM(Deaths_per_million) as total_mortes
FROM DeathsPerMillion
GROUP BY Entity
ORDER BY total_mortes desc;





-- Evolu��o acumulada por pa�s

SELECT Day AS data, Entity AS pais,
       SUM(Deaths_per_million) OVER (
           PARTITION BY Entity
           ORDER BY Day
           ROWS UNBOUNDED PRECEDING
       ) AS mortes_acumuladas_por_milhao
FROM DeathsPerMillion
ORDER BY Entity, Day;

--Dia com mais mortes em um pais espec�fico

SELECT TOP 1 *
FROM DeathsPerMillion
WHERE Entity = 'Brazil'
ORDER BY Deaths_per_million DESC;


--Primeiros 5 pa�ses a ter casos de morte

SELECT TOP 5 Entity AS pais, MIN(Day) AS primeiro_dia_com_morte, Deaths_per_million
FROM DeathsPerMillion
WHERE Deaths_per_million <> 0
GROUP BY Entity, Deaths_per_million
ORDER BY primeiro_dia_com_morte;


--Top 5 pa�ses com mais mortes

SELECT TOP 5 Entity, MAX(Deaths_per_million) as pico_morte
FROM DeathsPerMillion
GROUP BY Entity
ORDER BY pico_morte DESC;

--M�DIA DE MORTE POR PA�S

SELECT Entity, AVG(Deaths_per_million) AS m�dia_morte
FROM DeathsPerMillion
GROUP BY Entity
ORDER BY m�dia_morte DESC;

--Mortes por país (soma total de mortes por milhão)
CREATE VIEW [Total de Mortes por País] AS
SELECT Entity AS pais, SUM(Deaths_per_million) AS total_mortes_por_milhao
FROM DeathsPerMillion
GROUP BY Entity;

SELECT * FROM [Total de Mortes por País]
ORDER BY total_mortes_por_milhao ASC;

--Mortes por dia em um país específico

SELECT Day, Deaths_per_million
FROM DeathsPerMillion
WHERE Entity = 'Brazil'
ORDER BY Day;

--Top 10 países com mais mortes por milhão

SELECT TOP 10 Entity, SUM(Deaths_per_million) as total_mortes
FROM DeathsPerMillion
GROUP BY Entity
ORDER BY total_mortes desc;





-- Evolução acumulada por país

SELECT Day AS data, Entity AS pais,
       SUM(Deaths_per_million) OVER (
           PARTITION BY Entity
           ORDER BY Day
           ROWS UNBOUNDED PRECEDING
       ) AS mortes_acumuladas_por_milhao
FROM DeathsPerMillion
ORDER BY Entity, Day;

--Dia com mais mortes em um pais específico

SELECT TOP 1 *
FROM DeathsPerMillion
WHERE Entity = 'Brazil'
ORDER BY Deaths_per_million DESC;


--Primeiros 5 países a ter casos de morte

SELECT TOP 5 Entity AS pais, MIN(Day) AS primeiro_dia_com_morte, Deaths_per_million
FROM DeathsPerMillion
WHERE Deaths_per_million <> 0
GROUP BY Entity, Deaths_per_million
ORDER BY primeiro_dia_com_morte;


--Top 5 países com mais mortes

SELECT TOP 5 Entity, MAX(Deaths_per_million) as pico_morte
FROM DeathsPerMillion
GROUP BY Entity
ORDER BY pico_morte DESC;

--MÉDIA DE MORTE POR PAÍS

SELECT Entity, AVG(Deaths_per_million) AS média_morte
FROM DeathsPerMillion
GROUP BY Entity
ORDER BY média_morte DESC;

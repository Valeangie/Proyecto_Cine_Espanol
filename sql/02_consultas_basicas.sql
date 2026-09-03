-- ==================================================

-- PROYECTO CINE ESPAÑOL

-- CONSULTAS SQL BÁSICAS

-- ==================================================
USE cine_espanol;
ALTER TABLE peliculas
MODIFY fecha DATE;
-- ==================================================
-- PREGUNTA 1
-- ¿Cuántas películas tenemos en el dataset?
-- ==================================================
SELECT COUNT(*) AS total_peliculas
FROM peliculas;
-- ==================================================
-- PREGUNTA 2
-- ¿Cuáles son las 10 películas más taquilleras?
-- ==================================================
SELECT titulo,
ROUND(recaudacion / 1000000, 2) AS millones_euros,
anio
FROM peliculas
ORDER BY recaudacion DESC
LIMIT 10;
-- ==================================================
-- PREGUNTA 3
-- ¿Qué distribuidoras generan más ingresos?
-- ==================================================
SELECT distribuidora,
       CONCAT(
           FORMAT(
               ROUND(SUM(recaudacion),0),
               0
           ),
           ' €'
       ) AS recaudacion_total
FROM peliculas
GROUP BY distribuidora
ORDER BY SUM(recaudacion) DESC;
-- ==================================================
-- PREGUNTA 4
-- ¿Qué distribuidoras tienen más películas?
-- ==================================================
SELECT distribuidora,
COUNT(*) AS numero_peliculas
FROM peliculas
GROUP BY distribuidora
ORDER BY numero_peliculas DESC;
-- ==================================================
-- PREGUNTA 5
-- ¿Cuál es la recaudación total por año?
-- ==================================================
SELECT anio,
ROUND(
SUM(recaudacion) / 1000000,
2
) AS recaudacion_total_millones
FROM peliculas
GROUP BY anio
ORDER BY anio;

-- ==================================================
-- PREGUNTA 6
-- ¿Cuántos espectadores hubo por año?
-- ==================================================
SELECT anio,
ROUND(
SUM(espectadores) / 1000000,
2
) AS espectadores_millones
FROM peliculas
GROUP BY anio
ORDER BY anio;
-- ==================================================
-- PREGUNTA 7
-- ¿Cuántas películas se estrenaron por año?
-- ==================================================
SELECT anio,
COUNT(*) AS numero_peliculas
FROM peliculas
GROUP BY anio
ORDER BY anio;
-- ==================================================
-- ==================================================
-- PREGUNTA 8
-- ¿Cuál es la recaudación media por película?
-- ==================================================
SELECT anio,
       CONCAT(
           FORMAT(
               ROUND(AVG(recaudacion),0),
               0
           ),
           ' €'
       ) AS recaudacion_media
FROM peliculas
GROUP BY anio
ORDER BY anio;
-- ==================================================
-- PREGUNTA 9
-- ¿Cuáles son las películas más vistas?
-- ==================================================
SELECT titulo,
ROUND(
espectadores / 1000000,
2
) AS espectadores_millones,
anio
FROM peliculas
ORDER BY espectadores DESC
LIMIT 10;
-- ==================================================
-- PREGUNTA 10
-- ¿Qué distribuidoras atraen más espectadores?
-- ==================================================
SELECT distribuidora,
ROUND(
SUM(espectadores) / 1000000,
2
) AS espectadores_millones
FROM peliculas
GROUP BY distribuidora
ORDER BY SUM(espectadores) DESC;

-- ==================================================
-- PREGUNTA 11
-- ¿Qué distribuidoras son más eficientes?
-- ==================================================
SELECT distribuidora,

       COUNT(*) AS numero_peliculas,

       CONCAT(
           FORMAT(ROUND(AVG(recaudacion),0),0),
           ' €'
       ) AS media_por_pelicula,

       CONCAT(
           FORMAT(ROUND(SUM(recaudacion),0),0),
           ' €'
       ) AS recaudacion_total_euros,

       CONCAT(
           ROUND(SUM(recaudacion)/1000000,2),
           ' M€'
       ) AS recaudacion_total_millones

FROM peliculas

GROUP BY distribuidora

HAVING COUNT(*) >= 5

ORDER BY AVG(recaudacion) DESC;
-- ==================================================
-- PREGUNTA 12
-- ¿Qué año fue el más exitoso para el cine español?
-- ==================================================

SELECT anio,

       CONCAT(
           FORMAT(
               ROUND(SUM(recaudacion),0),
               0
           ),
           ' €'
       ) AS recaudacion_total,

       CONCAT(
           FORMAT(
               ROUND(SUM(espectadores),0),
               0
           ),
           ' espectadores'
       ) AS espectadores_totales,

       COUNT(*) AS numero_peliculas,

       CONCAT(
           FORMAT(
               ROUND(AVG(recaudacion),0),
               0
           ),
           ' €'
       ) AS recaudacion_media

FROM peliculas

GROUP BY anio

ORDER BY anio;
-- ==================================================
-- PREGUNTA 13
-- ¿Qué distribuidoras dominan el mercado cada año?
-- ==================================================

SELECT anio,
       distribuidora,

       CONCAT(
           FORMAT(
               ROUND(SUM(recaudacion),0),
               0
           ),
           ' €'
       ) AS recaudacion_total,

       COUNT(*) AS peliculas

FROM peliculas

GROUP BY anio, distribuidora

ORDER BY anio,
         SUM(recaudacion) DESC;
-- ==================================================
--- ==================================================
-- PREGUNTA 14
-- ¿Qué distribuidoras dominan el Top 50 de películas
-- más taquilleras del cine español?
-- ==================================================

SELECT distribuidora,

       COUNT(*) AS peliculas_en_top50,

       CONCAT(
           FORMAT(
               ROUND(SUM(recaudacion),0),
               0
           ),
           ' €'
       ) AS recaudacion_top50

FROM (

      SELECT distribuidora,
             recaudacion
      FROM peliculas
      ORDER BY recaudacion DESC
      LIMIT 50

) AS top50

GROUP BY distribuidora

ORDER BY peliculas_en_top50 DESC,
         SUM(recaudacion) DESC;
         -- ==================================================
-- ==================================================
-- PREGUNTA 15
-- ¿Qué películas sostienen realmente el mercado?
-- ==================================================

SELECT titulo,

       distribuidora,

       anio,

       CONCAT(
           FORMAT(recaudacion,0),
           ' €'
       ) AS recaudacion,

       CONCAT(
           ROUND(
               (
                   recaudacion /
                   (SELECT SUM(recaudacion)
                    FROM peliculas)
               ) * 100,
               2
           ),
           ' %'
       ) AS cuota_mercado

FROM peliculas

ORDER BY peliculas.recaudacion DESC

LIMIT 20;


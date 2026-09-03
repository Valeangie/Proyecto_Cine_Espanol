-- ==================================================
-- PROYECTO CINE ESPAÑOL
-- CREACIÓN DE BASE DE DATOS
-- ==================================================

CREATE DATABASE cine_espanol;

USE cine_espanol;

CREATE TABLE peliculas (
    rank_pelicula INT,
    titulo VARCHAR(255),
    distribuidora VARCHAR(255),
    fecha DATE,
    recaudacion BIGINT,
    espectadores BIGINT,
    anio INT
);
# Películas - Proyecto Xtend contra una base Neo4J

## Objetivo
Mostrar la integración entre una app hecha en JDK y Neo4J.

Toma la base de películas de ejemplo que viene con Neo4J y permite 

* generar una película nueva
* buscar películas existentes y editarlas
* agregar personajes
* a futuro, permitirá la actualización de actores

## Modelo Neo4J
Existen nodos Movie (Película) y Person (que representan cada Actor), que tienen una relación
ACTED_IN con atributos roles que terminan trasladándose al modelo de objetos como una clase Personaje.

La aplicación necesita descargar el ejemplo de películas (Movies database) que viene con Neo4j.

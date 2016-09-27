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

## Cómo ejecutar el ejemplo

* Instalar la última versión de Neo4j en https://neo4j.com/download/
* Ir a la carpeta bin del directorio de instalación de Neo4J. Levantar el server: 

```
$ ./neo4j start
```

* Ejecutar el script que carga el grafo de películas

[!video](video/crearPelis.gif)

* Bajar el servicio neo4j. Desde la carpeta bin hacer

```
$ ./neo4j stop
```

* Levantar la aplicación

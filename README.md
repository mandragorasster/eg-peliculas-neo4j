# Películas - Proyecto Xtend contra una base Neo4J

[![Build Status](https://travis-ci.org/uqbar-project/eg-peliculas-neo4j.svg?branch=ogm)](https://travis-ci.org/uqbar-project/eg-peliculas-neo4j)

## Objetivo
Mostrar la integración entre una app hecha en JDK, Neo4J y el framework OGM.

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
* Ir a la carpeta bin del directorio de instalación de Neo4J. Levantar el server desde el Neo4J Desktop, por el servicio o bien por línea de comando: 

```
$ ./neo4j start
```

* Abrir el Navegador de Neo4J Desktop o bien ingresar manualmente a la URL: http://localhost:7474
* Ejecutar el script que carga el grafo de películas (viene como ejemplo)

![video](video/crearPelis.gif)

* Bajar el servicio neo4j. Desde la carpeta bin hacer

```
$ ./neo4j stop
```

* En el Eclipse, ingresar al archivo AbstractRepoNeo4J y verificar la configuración

``` Xtend
	Configuration configuration = new Configuration.Builder().uri("bolt://localhost:11002").credentials("neo4j", "laura").
		build()

	SessionFactory sessionFactory = new SessionFactory(configuration, "ar.edu.peliculasNeo4J.domain")
```

En este caso estamos utilizando el puerto 11002 (el default es 7687, no debería ser necesario cambiarlo), el driver bolt (que recomendamos ya que es bastante liviano), y conectándonos como administradores de la base a neo4j y con contraseña "laura" (la que viene por defecto es neo4j pero a veces el Neo4J Desktop te obliga a cambiarla).

El objeto que crea las sesiones de Neo4J para hacer las consultas precisa saber el paquete de Java donde están las clases del dominio (en nuestro caso es "ar.edu.peliculasNeo4J.domain", estén atentos a mayúsculas y minúsculas porque es case-sensitive, de lo contrario les aparecerá un nefasto NullPointerException).

* Botón derecho sobre el archivo "Peliculas Neo4J.launch" y Run, si respetaste el nombre del proyecto: eg-peliculas-neo4j

![video](video/demoApp.gif)

Las modificaciones que hagas impactarán en el grafo de películas (podés hacer consultas luego).

![video](video/grafo2.gif)


> Una ventaja comparativa respecto a la conexión con el Driver nativo de Neo4J es que aquí podés navegar el grafo y utilizar la aplicación sin necesidad de cerrar una ventana u otra


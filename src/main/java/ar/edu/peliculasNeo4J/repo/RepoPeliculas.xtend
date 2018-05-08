package ar.edu.peliculasNeo4J.repo

import ar.edu.peliculasNeo4J.appModel.PeliculaBusqueda
import ar.edu.peliculasNeo4J.domain.Pelicula
import ar.edu.peliculasNeo4J.domain.Personaje
import java.util.ArrayList
import java.util.List
import org.neo4j.ogm.cypher.ComparisonOperator
import org.neo4j.ogm.cypher.Filter
import org.neo4j.ogm.cypher.Filters

class RepoPeliculas extends AbstractRepoNeo4J {

	private static RepoActores instance

	def static RepoActores getInstance() {
		if (instance === null) {
			instance = new RepoActores
		}
		instance
	}

	def static void main(String[] args) {
		new RepoPeliculas => [
			getPeliculas(new PeliculaBusqueda => [
				valorABuscar = "Fros"
			])
		]
	}

	def List<Pelicula> getPeliculas(PeliculaBusqueda peliculaBusqueda) {
		// En getPeliculas queremos hacer la búsqueda con profundidad (depth) = 0
		// para traer únicamente el nodo película sin la relación
		return new ArrayList(session.loadAll(typeof(Pelicula), filtroPeliculas(peliculaBusqueda), PROFUNDIDAD_BUSQUEDA_LISTA))
	}
	
	def Filters filtroPeliculas(PeliculaBusqueda peliculaBusqueda) {
		// Construyo un filtro que no filtra, para que filtroPeliculas devuelva siempre Filters
		var filtroTrue = new Filter("title", ComparisonOperator.MATCHES, ".*")
		val filtroPorTitulo = new Filter("title", ComparisonOperator.MATCHES, ".*(?i)" + peliculaBusqueda.valorABuscar + ".*")
		val filtroPorAnio = new Filter("released", ComparisonOperator.EQUALS, peliculaBusqueda.anioABuscar)
		if (peliculaBusqueda.filtraPorAnio) {
			// Solo busca por año
			if (!peliculaBusqueda.seleccionoConector) {
				return filtroPorAnio.and(filtroTrue)
			}
			if (peliculaBusqueda.hasAnd) {
				return filtroPorTitulo.and(filtroPorAnio)
			}
			if (peliculaBusqueda.hasOr) {
				return filtroPorTitulo.or(filtroPorAnio)
			}
		} 
		filtroPorTitulo.and(filtroTrue)
	}

	def Pelicula getPelicula(Long id) {
		session.load(typeof(Pelicula), id, PROFUNDIDAD_BUSQUEDA_CONCRETA)
	}
	
	def void eliminarPelicula(Pelicula pelicula) {
		session.delete(pelicula)
	}

	/**
	 * Contra, tuve que agregar el eliminarPersonaje porque la actualización en cascada
	 * no detectó la ausencia de una relación, quizás por la forma en que está configurada
	 */
	def void eliminarPersonaje(Personaje personaje) {
		session.delete(personaje)
	}
	
	def void actualizarPelicula(Pelicula pelicula) {
		pelicula.validar
		session.save(pelicula) 
		// ver save(entity, depth). Aquí por defecto depth es -1 que
		// implica hacer una pasada recorriendo todo el grafo en profundidad
	}

}

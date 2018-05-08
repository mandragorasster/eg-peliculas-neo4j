package ar.edu.peliculasNeo4J.repo

import ar.edu.peliculasNeo4J.domain.Pelicula
import ar.edu.peliculasNeo4J.domain.Personaje
import java.util.ArrayList
import java.util.List
import org.neo4j.ogm.cypher.ComparisonOperator
import org.neo4j.ogm.cypher.Filter

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
			getPeliculas("Fros")
		]
	}

	def List<Pelicula> getPeliculas(String valor) {
		val session = sessionFactory.openSession
		val filtroPorTitulo = new Filter("title", ComparisonOperator.MATCHES, ".*" + valor + ".*")
		return new ArrayList(session.loadAll(typeof(Pelicula), filtroPorTitulo))
	}

	def Pelicula getPelicula(Long id) {
		val session = sessionFactory.openSession
		session.load(typeof(Pelicula), id)
	}
	
	def void eliminarPelicula(Pelicula pelicula) {
		val session = sessionFactory.openSession
		session.delete(pelicula)
	}

	/**
	 * Contra, tuve que agregar el eliminarPersonaje porque la actualización en cascada
	 * no detectó la ausencia de una relación, quizás por la forma en que está configurada
	 */
	def void eliminarPersonaje(Personaje personaje) {
		val session = sessionFactory.openSession
		session.delete(personaje)
	}
	
	def void saveOrUpdatePelicula(Pelicula pelicula) {
		pelicula.validar
		val session = sessionFactory.openSession
		session.save(pelicula) 
		// ver save(entity, depth). Aquí por defecto depth es -1 que
		// implica hacer una pasada recorriendo todo el grafo en profundidad
	}

}

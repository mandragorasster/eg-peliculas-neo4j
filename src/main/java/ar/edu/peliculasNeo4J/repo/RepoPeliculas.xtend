package ar.edu.peliculasNeo4J.repo

import ar.edu.peliculasNeo4J.domain.Pelicula
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
		val filtroPorTitulo = new Filter("title", ComparisonOperator.CONTAINING, valor)
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

	def void saveOrUpdatePelicula(Pelicula pelicula) {
		pelicula.validar
		val session = sessionFactory.openSession
		session.save(pelicula)
	}

}

package ar.edu.peliculasNeo4J.repo

import ar.edu.peliculasNeo4J.domain.Actor
import java.util.ArrayList
import java.util.List
import org.neo4j.ogm.cypher.ComparisonOperator
import org.neo4j.ogm.cypher.Filter

class RepoActores extends AbstractRepoNeo4J {

	static RepoActores instance
	
	def static RepoActores getInstance() {
		if (instance === null) {
			instance = new RepoActores
		}
		instance
	}

	def List<Actor> getActores(String valor) {
		val filtroPorNombreActor = 
			new Filter("name", ComparisonOperator.MATCHES, "(?i).*" + valor + ".*")
		return new ArrayList(session.loadAll(Actor, filtroPorNombreActor, PROFUNDIDAD_BUSQUEDA_LISTA))
	}
	
}

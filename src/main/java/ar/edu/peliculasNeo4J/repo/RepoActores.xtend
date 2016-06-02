package ar.edu.peliculasNeo4J.repo

import ar.edu.peliculasNeo4J.domain.Actor
import java.util.Iterator
import java.util.List
import org.neo4j.graphdb.Node
import org.neo4j.graphdb.Result

import static extension ar.edu.peliculasNeo4J.repo.ActorToNodeConverter.*

class RepoActores extends AbstractRepoNeo4J {

	private static RepoActores instance
	
	def static RepoActores getInstance() {
		if (instance == null) {
			instance = new RepoActores
		}
		instance
	}

	def List<Actor> getActores(String valor) {
		val transaction = graphDb.beginTx
		try {
			getNodosActores(valor).map [ Node node |
				node.convertToActor
			].toList
		} finally {
			cerrarTransaccion(transaction)
		}
	}
	
	private def getNodosActores(String valor) {
		basicSearch("actor.name =~ '(?i).*" + valor + ".*'")
	}

	def getNodoActorById(Long id) {
		basicSearch("ID(actor) = " + id).head
	}

	private def basicSearch(String where) {
		val Result result = graphDb.execute("match (actor:Person) where " + where + " return actor")
		val Iterator<Node> peli_column = result.columnAs("actor")
		return peli_column
	}
	
}

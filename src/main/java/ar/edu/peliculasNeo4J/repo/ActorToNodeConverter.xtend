package ar.edu.peliculasNeo4J.repo

import ar.edu.peliculasNeo4J.domain.Actor
import org.neo4j.graphdb.Node

class ActorToNodeConverter {

	def static Actor convertToActor(Node nodeActor) {
		new Actor => [
			id = nodeActor.id
			nombreCompleto = nodeActor.getProperty("name", "") as String
			anioNacimiento = (nodeActor.getProperty("born", 0L) as Long).intValue
		]
	}
}

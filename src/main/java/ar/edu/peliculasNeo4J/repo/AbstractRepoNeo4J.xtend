package ar.edu.peliculasNeo4J.repo

import org.eclipse.xtend.lib.annotations.Accessors
import org.neo4j.graphdb.GraphDatabaseService
import org.neo4j.graphdb.Transaction

@Accessors
class AbstractRepoNeo4J {

	GraphDatabaseService graphDb

	protected new() {
		graphDb = GraphDatabaseProvider.instance.graphDb
	}

	protected def void cerrarTransaccion(Transaction transaction) {
		if (transaction != null) {
			transaction.close
		}
	}

}

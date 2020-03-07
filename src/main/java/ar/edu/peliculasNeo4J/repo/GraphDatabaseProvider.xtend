package ar.edu.peliculasNeo4J.repo

import java.io.File
import org.eclipse.xtend.lib.annotations.Accessors
import org.neo4j.graphdb.GraphDatabaseService
import org.neo4j.graphdb.factory.GraphDatabaseFactory

@Accessors
class GraphDatabaseProvider {
	// Para saber dónde está el archivo graph.db que contiene el grafo 
	// a) descargar Neo4J manualmente y apuntarlo allí
	//static String PATH = "/var/run/neo4j/data"
	// b) desde el Neo4J Desktop, en "My Project", ingresar a "Database" y en la solapa "Logs"
	//    dice dónde está el archivo graph.db
	static String PATH = "/var/lib/neo4j/data/databases"
	
	static GraphDatabaseProvider instance
	
	GraphDatabaseService graphDb
	
	private new() {
		val GraphDatabaseFactory dbFactory = new GraphDatabaseFactory
		graphDb = dbFactory.newEmbeddedDatabase(new File(PATH + "/graph.db"))
	}
	
	def static instance() {
		if (instance === null) {
			instance = new GraphDatabaseProvider		
		}
		instance
	}
	 	
}
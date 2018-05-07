package ar.edu.peliculasNeo4J.repo

import org.eclipse.xtend.lib.annotations.Accessors
import org.neo4j.graphdb.Transaction
import org.neo4j.ogm.config.Configuration
import org.neo4j.ogm.session.SessionFactory

@Accessors
class AbstractRepoNeo4J {

	/**
	 * http://neo4j.com/docs/ogm-manual/current/reference/
	 * 
	 */
	Configuration configuration = new Configuration.Builder().uri("bolt://localhost").credentials("neo4j", "laura").
		build()

	SessionFactory sessionFactory = new SessionFactory(configuration, "ar.edu.peliculasNeo4J.domain")

}

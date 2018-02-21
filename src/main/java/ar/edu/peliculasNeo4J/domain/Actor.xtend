package ar.edu.peliculasNeo4J.domain

import org.eclipse.xtend.lib.annotations.Accessors
import org.neo4j.ogm.annotation.GeneratedValue
import org.neo4j.ogm.annotation.Id
import org.neo4j.ogm.annotation.NodeEntity
import org.uqbar.commons.model.annotations.Observable
import org.neo4j.ogm.annotation.Property

@NodeEntity(label="Person")
@Accessors
@Observable
class Actor {
	@Id @GeneratedValue
	Long id 

	@Property(name="name") // OJO, no es la Property de Xtend sino la de OGM
	String nombreCompleto
	
	@Property(name="born")
	int anioNacimiento
	
	override toString() {
		nombreCompleto
	}
	
}
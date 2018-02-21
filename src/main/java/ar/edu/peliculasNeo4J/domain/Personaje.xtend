package ar.edu.peliculasNeo4J.domain

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.neo4j.ogm.annotation.EndNode
import org.neo4j.ogm.annotation.GeneratedValue
import org.neo4j.ogm.annotation.Id
import org.neo4j.ogm.annotation.RelationshipEntity
import org.neo4j.ogm.annotation.StartNode
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.exceptions.UserException

@RelationshipEntity(type="ACTED_IN")
@Accessors
@Observable
class Personaje {
	@Id @GeneratedValue
	Long id
	
	List<String> roles
	
	@StartNode Actor actor
	@EndNode Pelicula pelicula
	
	def getRolesMostrables() {
		if (roles.isEmpty) {
			return ""
		}
		val rolesAsString = roles.toString
		rolesAsString.substring(1, rolesAsString.length - 1)	
	}
	
	override toString() {
		rolesMostrables + " por " + actor.toString
	}
	
	def void validar() {
		if (this.roles === null || this.roles.isEmpty) {
			throw new UserException("Debe ingresar al menos un rol para el personaje")
		}
		if (this.actor === null) {
			throw new UserException("Debe ingresar qué actor cumple ese personaje")
		}
	}
	
}
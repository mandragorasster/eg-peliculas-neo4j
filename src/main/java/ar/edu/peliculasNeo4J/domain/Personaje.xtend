package ar.edu.peliculasNeo4J.domain

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class Personaje {
	Long id
	List<String> roles
	Actor actor = new Actor
	
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
		if (this.roles.isEmpty) {
			throw new UserException("Debe ingresar al menos un rol para el personaje")
		}
		if (this.actor == null) {
			throw new UserException("Debe ingresar qué actor cumple ese personaje")
		}
	}
}
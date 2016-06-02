package ar.edu.peliculasNeo4J.domain

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class Actor {
	Long id
	String nombreCompleto
	int anioNacimiento
	
	override toString() {
		nombreCompleto
	}
	
}
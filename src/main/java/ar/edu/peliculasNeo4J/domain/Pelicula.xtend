package ar.edu.peliculasNeo4J.domain

import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.neo4j.ogm.annotation.GeneratedValue
import org.neo4j.ogm.annotation.Id
import org.neo4j.ogm.annotation.NodeEntity
import org.neo4j.ogm.annotation.Relationship
import org.uqbar.commons.model.annotations.Observable
import org.uqbar.commons.model.exceptions.UserException
import org.neo4j.ogm.annotation.Property

import static org.uqbar.commons.model.utils.ObservableUtils.*

@NodeEntity(label="Movie")
@Observable
@Accessors
class Pelicula {
	static int MINIMO_VALOR_ANIO = 1900
	
	@Id @GeneratedValue
	Long id

	@Property(name="title") // OJO, no es la property de xtend sino la de OGM
	String titulo
	
	@Property(name="tagline")
	String frase
	
	@Property(name="released")
	int anio
	
	@Relationship(type = "ACTED_IN", direction = "INCOMING")
	List<Personaje> personajes = new ArrayList<Personaje>
	
	override toString() {
		titulo + " (" + anio + ")" 
	}
	
	def agregarPersonaje(String _roles, Actor _actor) {
		val personaje = new Personaje => [
					roles = #[_roles]
					actor = _actor
					// OGM necesita relacional ambos nodos
					pelicula = this
				]
		personaje.validar
		personajes.add(personaje)
		firePropertyChanged(this, "personajes")
	}
	
	def eliminarPersonaje(Personaje personaje) {
		personajes.remove(personaje)
		personaje.pelicula = null
		firePropertyChanged(this, "personajes")
	}
	
	def void validar() {
		if (this.titulo === null || this.titulo.trim.equals("")) {
			throw new UserException("Debe ingresar un título")
		}
		if (this.anio <= MINIMO_VALOR_ANIO) {
			throw new UserException("El año debe ser mayor a " + MINIMO_VALOR_ANIO)
		}
		personajes.forEach [ personaje | personaje.validar ]
	}
}
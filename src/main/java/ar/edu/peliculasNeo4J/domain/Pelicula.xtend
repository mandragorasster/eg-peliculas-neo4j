package ar.edu.peliculasNeo4J.domain

import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Observable

import static org.uqbar.commons.model.ObservableUtils.*

@Observable
@Accessors
class Pelicula {
	static int MINIMO_VALOR_ANIO = 1900
	
	Long id
	String titulo
	String frase
	int anio
	List<Personaje> personajes = new ArrayList<Personaje>
	
	override toString() {
		titulo + " (" + anio + ")" 
	}
	
	def agregarPersonaje(String _roles, Actor _actor) {
		val personaje = new Personaje => [
					roles = #[_roles]
					actor = _actor
				]
		personaje.validar
		personajes.add(personaje)
		firePropertyChanged(this, "personajes")
	}
	
	def eliminarPersonaje(Personaje personaje) {
		personajes.remove(personaje)
		firePropertyChanged(this, "personajes")
	}
	
	def void validar() {
		if (this.titulo == null || this.titulo.trim.equals("")) {
			throw new UserException("Debe ingresar un título")
		}
		if (this.anio <= MINIMO_VALOR_ANIO) {
			throw new UserException("El año debe ser mayor a " + MINIMO_VALOR_ANIO)
		}
		personajes.forEach [ personaje | personaje.validar ]
	}
}
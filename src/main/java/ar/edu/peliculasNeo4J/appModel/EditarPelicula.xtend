package ar.edu.peliculasNeo4J.appModel

import ar.edu.peliculasNeo4J.domain.Pelicula
import ar.edu.peliculasNeo4J.domain.Personaje
import ar.edu.peliculasNeo4J.repo.RepoPeliculas
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.ApplicationContext
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class EditarPelicula {
	Pelicula pelicula
	boolean modoAlta
	RepoPeliculas repoPeliculas
	Personaje personajeSeleccionado
	
	
	new() {
		repoPeliculas = ApplicationContext.instance.getSingleton(typeof(RepoPeliculas))
	}
	
	def void aceptar() {
		repoPeliculas.saveOrUpdatePelicula(pelicula)
	}
	
	def static EditarPelicula modoAlta() {
		new EditarPelicula => [
			modoAlta = true
			pelicula = new Pelicula
		]
	}
	
	def static EditarPelicula modoEdicion(Pelicula _pelicula) {
		new EditarPelicula => [
			modoAlta = false
			pelicula = repoPeliculas.getPelicula(_pelicula.id)
		]
	}

	def void eliminarPersonaje() {
		pelicula.eliminarPersonaje(personajeSeleccionado)
	}
	
}

package ar.edu.peliculasNeo4J.appModel

import ar.edu.peliculasNeo4J.domain.Actor
import ar.edu.peliculasNeo4J.domain.Pelicula
import ar.edu.peliculasNeo4J.repo.RepoActores
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.applicationContext.ApplicationContext
import org.uqbar.commons.model.annotations.Observable

@Observable
@Accessors
class AgregarPersonaje {
	RepoActores repoActores
	String rol
	Pelicula pelicula
	Actor actorSeleccionado
	List<Actor> actores
	String actorBusqueda

	new(Pelicula _pelicula) {
		pelicula = _pelicula
		repoActores = ApplicationContext.instance.getSingleton(RepoActores)
	}

	def void aceptar() {
		pelicula.agregarPersonaje(rol, actorSeleccionado)
	}
	
	def void buscarActor() {
		actores = repoActores.getActores(actorBusqueda)	
	}

}

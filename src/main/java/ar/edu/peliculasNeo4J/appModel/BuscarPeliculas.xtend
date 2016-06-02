package ar.edu.peliculasNeo4J.appModel

import ar.edu.peliculasNeo4J.domain.Pelicula
import ar.edu.peliculasNeo4J.repo.RepoPeliculas
import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.ApplicationContext
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class BuscarPeliculas {
	
	List<Pelicula> peliculas
	String valorABuscar
	RepoPeliculas repoPeliculas
	Pelicula peliculaSeleccionada
	
	new() {
		init()
		repoPeliculas = ApplicationContext.instance.getSingleton(typeof(RepoPeliculas))
	}
	
	def init() {
		peliculas = new ArrayList<Pelicula>
		valorABuscar = ""
	}
	
	def void buscar() {
		peliculas = repoPeliculas.getPeliculas(valorABuscar)
	}
	
	def void limpiar() {
		init()
	}
	
	def void eliminarPeliculaSeleccionada() {
		repoPeliculas.eliminarPelicula(peliculaSeleccionada)
		buscar	
	}

}
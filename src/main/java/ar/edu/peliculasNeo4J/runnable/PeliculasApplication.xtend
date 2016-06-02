package ar.edu.peliculasNeo4J.runnable

import ar.edu.peliculasNeo4J.appModel.BuscarPeliculas
import ar.edu.peliculasNeo4J.repo.RepoActores
import ar.edu.peliculasNeo4J.repo.RepoPeliculas
import ar.edu.peliculasNeo4J.ui.BuscarPeliculasWindow
import org.uqbar.arena.Application
import org.uqbar.commons.utils.ApplicationContext

class PeliculasApplication extends Application {
	
	static def void main(String[] args) {
		ApplicationContext.instance.configureSingleton(typeof(RepoPeliculas), new RepoPeliculas)
		ApplicationContext.instance.configureSingleton(typeof(RepoActores), RepoActores.instance) 
		new PeliculasApplication().start()
	}

	override createMainWindow() {
		new BuscarPeliculasWindow(this, new BuscarPeliculas())
	}
	
}
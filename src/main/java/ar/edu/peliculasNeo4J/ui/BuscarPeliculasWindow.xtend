package ar.edu.peliculasNeo4J.ui

import ar.edu.peliculasNeo4J.appModel.BuscarPeliculas
import ar.edu.peliculasNeo4J.appModel.EditarPelicula
import ar.edu.peliculasNeo4J.domain.Pelicula
import java.awt.Color
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class BuscarPeliculasWindow extends SimpleWindow<BuscarPeliculas> {
	
	new(WindowOwner parent, BuscarPeliculas model) {
		super(parent, model)
	}

	override def createMainTemplate(Panel mainPanel) {
		title = "Buscador de Películas"
		taskDescription = "Ingrese los parámetros de búsqueda"

		super.createMainTemplate(mainPanel)
		this.createResultsGrid(mainPanel)
		this.createGridActions(mainPanel)
	}
		
	override protected addActions(Panel actionsPanel) {
		new Button(actionsPanel) => [
			caption = "Agregar una película"
			onClick [ | this.crearPelicula ]
			setAsDefault
		]
		new Button(actionsPanel) => [
			caption = "Buscar"
			onClick [ | modelObject.buscar ]
			setAsDefault
		]
		new Button(actionsPanel) => [
			caption = "Limpiar"
			onClick [ | modelObject.limpiar ]
		]
	}
	
	override protected createFormPanel(Panel mainPanel) {
		new Label(mainPanel) => [
			text = "Ingrese el valor a buscar"
			foreground = Color.BLUE
		]
		new TextBox(mainPanel) => [
			width = 150
			value <=> "valorABuscar"
		]
	}

	// *************************************************************************
	// ** RESULTADOS DE LA BUSQUEDA
	// *************************************************************************
	/**
	 * Se crea la grilla en el panel de abajo El binding es: el contenido de la grilla en base a los
	 * resultados de la búsqueda Cuando el usuario presiona Buscar, se actualiza el model, y éste a su vez
	 * dispara la notificación a la grilla que funciona como Observer
	 */
	def protected createResultsGrid(Panel mainPanel) {
		var table = new Table<Pelicula>(mainPanel, typeof(Pelicula)) => [
			numberVisibleRows = 10
			width = 650
			items <=> "peliculas"
			value <=> "peliculaSeleccionada"
		]
		this.describeResultsGrid(table)
	}

	/**
	 * Define las columnas de la grilla Cada columna se puede bindear 1) contra una propiedad del model, como
	 * en el caso del número o el nombre 2) contra un transformer que recibe el model y devuelve un tipo
	 * (generalmente String), como en el caso de Recibe Resumen de Cuenta
	 *
	 * @param table
	 */
	def void describeResultsGrid(Table<Pelicula> table) {
		new Column<Pelicula>(table) => [
			title = "Título"
			fixedSize = 150
			bindContentsToProperty("titulo")
		]

		new Column<Pelicula>(table) => [
			title = "Frase"
			fixedSize = 200
			bindContentsToProperty("frase")
		]

		new Column<Pelicula>(table) => [
			title = "Año"
			fixedSize = 150
			bindContentsToProperty("anio")
		]

	}

	def void createGridActions(Panel mainPanel) {
		val actionsPanel = new Panel(mainPanel)
		actionsPanel.setLayout(new HorizontalLayout)
		val elementSelected = new NotNullObservable("peliculaSeleccionada")
		
		new Button(actionsPanel) => [
			caption = "Editar"
			onClick [ | this.modificarPelicula]
			bindEnabled(elementSelected)
		]

		new Button(actionsPanel) => [
			caption = "Borrar"
			onClick [ | modelObject.eliminarPeliculaSeleccionada]
			bindEnabled(elementSelected)
		]
	}
	
	
	def void crearPelicula() {
		this.openDialog(new EditarPeliculaWindow(this, EditarPelicula.modoAlta))
	}

	def void modificarPelicula() {
		this.openDialog(new EditarPeliculaWindow(this, EditarPelicula.modoEdicion(modelObject.peliculaSeleccionada)))
	}

	def openDialog(Dialog<?> dialog) {
		dialog.onAccept[|modelObject.buscar]
		dialog.open
	}
		
}
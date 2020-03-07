package ar.edu.peliculasNeo4J.ui

import ar.edu.peliculasNeo4J.appModel.AgregarPersonaje
import ar.edu.peliculasNeo4J.appModel.EditarPelicula
import ar.edu.peliculasNeo4J.domain.Pelicula
import ar.edu.peliculasNeo4J.domain.Personaje
import ar.edu.peliculasNeo4J.repo.RepoPeliculas
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.NumericField
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.commons.applicationContext.ApplicationContext

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class EditarPeliculaWindow extends Dialog<EditarPelicula> {

	new(WindowOwner owner, EditarPelicula editarPelicula) {
		super(owner, editarPelicula)
		if (editarPelicula.modoAlta) {
			title = "Nueva pelicula"
		} else {
			title = "Editar datos de la pelicula"
		}
	}

	override createMainTemplate(Panel mainPanel) {
		val panelIzquierdo = new Panel(mainPanel)
		super.createMainTemplate(panelIzquierdo)
		this.createResultsGrid(mainPanel)
	}

	override protected createFormPanel(Panel panelIzquierdo) {
		val form = new Panel(panelIzquierdo)
		form.layout = new ColumnLayout(2)
		new Label(form).text = "Título"
		new TextBox(form) => [
			value <=> "pelicula.titulo"
			width = 250
		]

		new Label(form).text = "Frase"
		new TextBox(form) => [
			value <=> "pelicula.frase"
			width = 250
		]
		new Label(form).text = "Año"
		new NumericField(form) => [
			value <=> "pelicula.anio"
			width = 90
		]
	}

	override protected addActions(Panel actionsPanel) {
		val botonera = new Panel(actionsPanel)
		botonera.layout = new HorizontalLayout
		actionsPanel.width = 250
		new Button(botonera) => [
			caption = "Aceptar"
			onClick [|
				modelObject.aceptar
				this.accept
			]
			setAsDefault
//			disableOnError
		]

		new Button(botonera) => [
			caption = "Agregar personaje"
			onClick [|this.agregarPersonaje]
		]

		new Button(botonera) => [
			caption = "Cancelar"
			onClick [|
				this.cancel
			]
		]

	}

	def protected createResultsGrid(Panel mainPanel) {
		val panelDerecho = new Panel(mainPanel)

		// Llevar a otra pantalla los personajes
		val table = new Table<Personaje>(panelDerecho, Personaje) => [
			numberVisibleRows = 5
			width = 650
			items <=> "pelicula.personajes"
			value <=> "personajeSeleccionado"
		]
		TableColumnBuilder.buildColumn(table, "Roles", 250, "rolesMostrables")
		TableColumnBuilder.buildColumn(table, "Actor", 250, "actor.nombreCompleto")

		this.createGridActions(panelDerecho)
	}

	def getRepoPeliculas() {
		ApplicationContext.instance.getSingleton(Pelicula) as RepoPeliculas
	}

	def void createGridActions(Panel mainPanel) {
		val actionsPanel = new Panel(mainPanel)
		actionsPanel.setLayout(new HorizontalLayout)
		val elementSelected = new NotNullObservable("personajeSeleccionado")

		new Button(actionsPanel) => [
			caption = "Eliminar personaje"
			onClick [|modelObject.eliminarPersonaje]
			bindEnabled(elementSelected)
		]
	}

	def void agregarPersonaje() {
		this.openDialog(new AgregarPersonajeDialog(this, new AgregarPersonaje(modelObject.pelicula)))
	}

	def openDialog(Dialog<?> dialog) {
		dialog.open
	}

}

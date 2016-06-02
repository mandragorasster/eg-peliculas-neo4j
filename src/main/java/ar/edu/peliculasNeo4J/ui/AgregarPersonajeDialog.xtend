package ar.edu.peliculasNeo4J.ui

import ar.edu.peliculasNeo4J.appModel.AgregarPersonaje
import ar.edu.peliculasNeo4J.domain.Actor
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.GroupPanel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class AgregarPersonajeDialog extends Dialog<AgregarPersonaje> {

	new(WindowOwner owner, AgregarPersonaje model) {
		super(owner, model)
		title = "Agregar un personaje a la película " + model.pelicula
	}

	override protected createFormPanel(Panel mainPanel) {
		val panelRoles = new Panel(mainPanel) => [
			layout = new ColumnLayout(1)
		]
		new Label(panelRoles) => [
			text = "Roles que cumple el actor en la película"
		]
		new TextBox(panelRoles) => [
			width = 300
			value <=> "rol"
		]
		
		val panelActor = new GroupPanel(mainPanel, this.modelObject) => [
			title = "Actor"
		] 
		val panelValoresBusqueda = new Panel(panelActor)
		panelValoresBusqueda.layout = new HorizontalLayout
		new TextBox(panelValoresBusqueda) => [
			value <=> "actorBusqueda"
			width = 300
		]
		new Button(panelValoresBusqueda) => [
			caption = "Buscar"
			onClick [ | modelObject.buscarActor ]
		]
		
		val table = new Table<Actor>(panelActor, typeof(Actor)) => [
			numberVisibleRows = 10
			width = 650
			items <=> "actores"
			value <=> "actorSeleccionado"
		]
		TableColumnBuilder.buildColumn(table, "Actor", 550, "nombreCompleto")
		TableColumnBuilder.buildColumn(table, "Año nac.", 100, "anioNacimiento")
		
		val filaAgregar = new Panel(mainPanel)
		new Button(filaAgregar) => [
			caption = "Agregar personaje"
			onClick [|
				modelObject.aceptar
				// TODO: Validar
				this.close
			]
		]
	}

}

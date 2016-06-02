package ar.edu.peliculasNeo4J.repo

import ar.edu.peliculasNeo4J.domain.Pelicula
import ar.edu.peliculasNeo4J.domain.Personaje
import java.util.ArrayList
import java.util.Iterator
import java.util.List
import org.neo4j.graphdb.Label
import org.neo4j.graphdb.Node
import org.neo4j.graphdb.Result

import static extension ar.edu.peliculasNeo4J.repo.ActorToNodeConverter.*

class RepoPeliculas extends AbstractRepoNeo4J {

	private static RepoActores instance
	
	def static RepoActores getInstance() {
		if (instance == null) {
			instance = new RepoActores
		}
		instance
	}

	def static void main(String[] args) {
		new RepoPeliculas => [
			getPeliculas("Fros")
		]
	}

	def List<Pelicula> getPeliculas(String valor) {
		val transaction = graphDb.beginTx
		try {
			getNodosPeliculas(valor).map [ Node node |
				convertToPelicula(node, false)
			].toList
		} finally {
			cerrarTransaccion(transaction)
		}
	}

	def Pelicula getPelicula(Long id) {
		val transaction = graphDb.beginTx
		try {
			convertToPelicula(getNodoPelicula(id), true)
		} finally {
			cerrarTransaccion(transaction)
		}
	}
	
	def convertToPelicula(Node nodePelicula, boolean deep) {
		new Pelicula => [
			id = nodePelicula.id
			titulo = nodePelicula.getProperty("title") as String
			frase = nodePelicula.getProperty("tagline", "") as String
			val released = nodePelicula.getProperty("released", null) as Long
			if (released != null) {
				anio = released.intValue
			}
			if (deep) { 
				val rel_actuaron = nodePelicula.getRelationships(RelacionesPelicula.ACTED_IN)
				personajes = rel_actuaron.map [
					rel | new Personaje => [
						id = rel.id
						val rolesPersonaje = rel.getProperty("roles", []) as String[]
						roles = new ArrayList(rolesPersonaje)
						val nodeActor = rel.startNode // hay que saber como navegar
						actor = nodeActor.convertToActor
					]
				].toList
			}			
		]
	}

	def void eliminarPelicula(Pelicula pelicula) {
		val transaction = graphDb.beginTx
		try {
			getNodoPelicula(pelicula.id).delete
			transaction.success
		} finally {
			cerrarTransaccion(transaction)
		}
	}

	def void saveOrUpdatePelicula(Pelicula pelicula) {
		pelicula.validar
		val transaction = graphDb.beginTx
		try {
			var Node nodoPelicula = null
			if (pelicula.id == null) {
				nodoPelicula = graphDb.createNode
				nodoPelicula.addLabel(labelPelicula)
			} else {
				nodoPelicula = getNodoPelicula(pelicula.id)
			}
			actualizarPelicula(pelicula, nodoPelicula)
			transaction.success
			pelicula.id = nodoPelicula.id
		} finally {
			cerrarTransaccion(transaction)
		}
	}

	private def getNodosPeliculas(String valor) {
		basicSearch("peli.title =~ '(?i).*" + valor + ".*'")
	}

	private def Node getNodoPelicula(Long id) {
		basicSearch("ID(peli) = " + id).head
	}
	
	private def basicSearch(String where) {
		val Result result = graphDb.execute("match (peli:Movie) where " + where + " return peli")
		val Iterator<Node> peli_column = result.columnAs("peli")
		return peli_column
	}

	private def void actualizarPelicula(Pelicula pelicula, Node nodePelicula) {
		nodePelicula => [
			setProperty("title", pelicula.titulo)
			setProperty("tagline", pelicula.frase)
			setProperty("released", new Long(pelicula.anio))
			// Borro las relaciones que tenga ese nodo
			relationships.forEach [it.delete ]
			// Creo relaciones nuevas
			pelicula.personajes.forEach [ personaje |
				val Node nodoActor = RepoActores.instance.getNodoActorById(personaje.actor.id)
				val relPersonaje = nodoActor.createRelationshipTo(it, RelacionesPelicula.ACTED_IN)
				
				// Manganeta para usar arrays porque el [] se confunde con el bloque
				val roles = personaje.roles		
				var String[] _roles = #[]
				_roles = roles.toArray(_roles)
				relPersonaje.setProperty("roles", _roles)	
			]
		]
	}

	private def Label labelPelicula() {
		Label.label("Movie")
	}
}

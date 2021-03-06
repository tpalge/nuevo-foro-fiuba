package nuevo_foro_fiuba

class Opcion {

	String nombre
	Set <Voto> votos = []

	static hasMany = [
		votos: Voto
	]

  static constraints = {
  	nombre blank:false, nullable: false
    votos nullable: false
  }

// ------------------------------------------------------------------------- //
  Opcion(String nombre){
  	this.nombre = nombre
  }

// ------------------------------------------------------------------------- //
	def agregarVoto(Voto voto){
		this.votos << voto
	}

}

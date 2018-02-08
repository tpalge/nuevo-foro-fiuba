package nuevo_foro_fiuba


class Publicacion {

	enum EstadoPublicacion {
		cerrada, abierta
	}

	String texto
	Usuario usuarioCreador
	Materia materiaRelacionada
	Catedra catedraRelacionada
	Integer promedioRequeridoParaComentar
	Set <Materia> materiasNecesariasParaComentar
	Set <Comentario> comentarios
	Archivo archivoAdjunto
	EstadoPublicacion estado
	Encuesta encuesta
	Set <Calificacion> calificaciones

	static hasMany = [
		comentarios: Comentario,
		materiasNecesariasParaComentar: Materia,
		calificaciones: Calificacion
	]

	static constraints = {
		texto blank: true, nullable:false
		usuarioCreador blank: false, nullable:false
		materiaRelacionada blank:false, nullable:true
		catedraRelacionada blank:false, nullable:true
		promedioRequeridoParaComentar blank:false, nullable:false
		materiasNecesariasParaComentar blank:false, nullable:false
		comentarios blank:false, nullable:false
		archivoAdjunto blank:false, nullable:true
		estado blank: false, nullable:false
		encuesta blank:false, nullable:true
		calificaciones blank:false, nullable:false
    }

	Publicacion (String texto, Usuario usuarioCreador, Materia materiaRelacionada, Catedra catedraRelacionada){
		this.texto = texto
		this.usuarioCreador = usuarioCreador
		this.materiaRelacionada = materiaRelacionada
		this.catedraRelacionada = catedraRelacionada
		this.promedioRequeridoParaComentar = 0
		this.materiasNecesariasParaComentar = []
		this.comentarios = []
		this.archivoAdjunto = null
		this.estado = EstadoPublicacion.abierta
		this.encuesta = null
		this.calificaciones = []
	}

	String obtenerVista(Usuario usuario){
		if (usuario.id == this.id){
			return "verPublicacion"
		}
		return "verPublicacion2"
	}

	Integer estaCerrada(){
		if (this.estado==EstadoPublicacion.cerrada)
			return 1
		return 0
	}

	Integer obtenerPromedioRequeridoParaComentar(){
		return this.promedioRequeridoParaComentar
	}

	def cerrar(){
		this.estado=EstadoPublicacion.cerrada
	}

	def abrir(){
		this.estado=EstadoPublicacion.abierta
	}

	def agregarCalificacion(Calificacion calificacion){
		this.calificaciones += [calificacion]
	}

}
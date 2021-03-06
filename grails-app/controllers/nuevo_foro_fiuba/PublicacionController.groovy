package nuevo_foro_fiuba

class PublicacionController {

  def publicacionService
  def usuarioService
  def materiaService
  def catedraService
  def archivoService

  def index() {}

  def listaPublicaciones(long idUsuario, long idCatedra) {
    def publicacionesNoEliminadas = publicacionService.obtenerPublicacionesNoEliminadas()
    def publicaciones = (!idCatedra) ? publicacionesNoEliminadas : publicacionService.filtrarPublicacionesPorCatedra(publicacionesNoEliminadas, idCatedra)
    def usuarioInstance = usuarioService.getUsuarioById(idUsuario)
    [publicacionInstanceList: publicaciones, usuarioInstance: usuarioInstance, materias: materiaService.getAllMaterias(), catedras: catedraService.getAllCatedras()]
  }

  def crearPublicacion (long idUsuario) {
    def usuarioInstance = usuarioService.getUsuarioById(idUsuario)
    [usuario: usuarioInstance, catedras: catedraService.getAllCatedras(), materias: materiaService.getAllMaterias()]
  }

  def verPublicacion (long idPublicacion, long idUsuario){
    def publicacionInstance = publicacionService.getPublicacionById(idPublicacion)
    def usuarioInstance = usuarioService.getUsuarioById(idUsuario)
    def esDueño = usuarioService.usuarioEsDueñoDeLaPublicacion(usuarioInstance, publicacionInstance)
    def comentarios = publicacionService.obtenerComentariosNoEliminados(publicacionInstance).sort { it.fechaHoraCreacion }
    [publicacion: publicacionInstance, materias: materiaService.getAllMaterias(), catedras: catedraService.getAllCatedras(), usuario: usuarioInstance, modificar:esDueño, comentarios:comentarios]
  }

  def formarPublicacion (String texto, long idUsuario, long idCatedra, Float promedioCalificacionesMinimoParaComentar, String nombreEncuesta, String nombreOpciones) {
    final def file = request.getFile('archivo')
    if (! promedioCalificacionesMinimoParaComentar)
      promedioCalificacionesMinimoParaComentar = 0
    def publicacion = publicacionService.formarPublicacion(idUsuario, texto, idCatedra, params.idsMateriasRequeridas, nombreEncuesta, nombreOpciones, promedioCalificacionesMinimoParaComentar, file)
    def idPublicacion = publicacion.getId()
    redirect(action: "listaPublicaciones", params:[idUsuario:idUsuario])
  }

  def cambiarEstado (long idPublicacion, long idUsuario){
    publicacionService.cambiarEstado(idPublicacion)
    redirect(action: "verPublicacion", params: [idUsuario:idUsuario, idPublicacion:idPublicacion])
  }

  def modificarTextoPublicacion(long idPublicacion, String nuevoTexto, long idUsuario){
    publicacionService.modificarTextoPublicacion(idPublicacion, nuevoTexto)
    redirect(action: "verPublicacion", params: [idUsuario:idUsuario, idPublicacion:idPublicacion])
  }

  def modificarMateria(long idPublicacion, long idMateria, long idUsuario){
    publicacionService.modificarMateriaPublicacion(idPublicacion, idMateria)
    redirect(action: "verPublicacion", params: [idUsuario:idUsuario, idPublicacion:idPublicacion])
  }

  def modificarCatedra(long idPublicacion, long idCatedra, long idUsuario){
    publicacionService.modificarCatedraPublicacion(idPublicacion, idCatedra)
    redirect(action: "verPublicacion", params: [idUsuario:idUsuario, idPublicacion:idPublicacion])
  }

  def modificarPromedioRequeridoParaComentar (long idPublicacion, long idUsuario, Float promedio){
    publicacionService.modificarPromedioRequeridoParaComentar(idPublicacion, promedio)
    redirect(action: "verPublicacion", params: [idUsuario:idUsuario, idPublicacion:idPublicacion])
  }

  def eliminarPublicacion(long idPublicacion, long idUsuario){
    publicacionService.eliminarPublicacion(idPublicacion)
    redirect(action: "listaPublicaciones", params: [idUsuario:idUsuario])
  }

  def calificarPositivo(long idPublicacion, long idUsuario){
    calificarPublicacion(Puntaje.TipoPuntaje.ME_GUSTA, idPublicacion, idUsuario)
  }

  def calificarNegativo(long idPublicacion, long idUsuario){
    calificarPublicacion(Puntaje.TipoPuntaje.NO_ME_GUSTA, idPublicacion, idUsuario)
  }

  def calificarPublicacion(Puntaje.TipoPuntaje tipo, long idPublicacion, long idUsuario){
    try{
      publicacionService.calificarPublicacion(idUsuario, idPublicacion, tipo)
    }
    catch (UsuarioYaCalificoException e){
      flash.message = e.MENSAJE
    }
    redirect(action: "verPublicacion", params: [idUsuario:idUsuario, idPublicacion:idPublicacion])
  }

  def comentar(long idPublicacion, long idUsuario, String textoComentario){
    try{
      publicacionService.comentarPublicacion(idUsuario, textoComentario, idPublicacion)
    }
    catch (PromedioInsuficienteException e){
      flash.message = e.MENSAJE
    }
    catch (PublicacionCerradaException e){
      flash.message = e.MENSAJE
    }
    catch (UsuarioNoPoseeMateriasNecesariasException e){
      flash.message = e.MENSAJE
    }
    redirect(controller:"publicacion", action: "verPublicacion", params: [idUsuario:idUsuario, idPublicacion:idPublicacion])
  }

  def agregarMateriaRequeridaParaComentar(long idPublicacion, long idUsuario, long idMateria){
    publicacionService.agregarMateriaRequeridaParaComentar(idPublicacion, idMateria)
    redirect(controller:"publicacion", action: "verPublicacion", params: [idUsuario:idUsuario, idPublicacion:idPublicacion])
  }

  def votarOpcionEncuesta(long idPublicacion, long idUsuario, long idOpcion){
    try{
      usuarioService.votarOpcionEncuesta(idPublicacion, idUsuario, idOpcion)
    }
    catch(PublicacionCerradaException e){
      flash.message = e.MENSAJE
    }
    catch(CreadorEncuestaNoPuedeVotarException e){
      flash.message = e.MENSAJE
    }
    catch(UsuarioYaVotoException e){
      flash.message = e.MENSAJE
    }
    redirect(controller:"publicacion", action: "verPublicacion", params: [idUsuario:idUsuario, idPublicacion:idPublicacion])
  }

  def descargarArchivoAdjunto(long idArchivo) {
    Archivo archivoInstance = archivoService.getArchivoById(idArchivo)
    response.setContentType("APPLICATION/OCTET-STREAM")
    response.setHeader("Content-Disposition", "Attachment;Filename=\"${archivoInstance.nombre}\"")
    def file = new File(archivoInstance.path)
    def fileInputStream = new FileInputStream(file)
    def outputStream = response.getOutputStream()
    byte[] buffer = new byte[4096];
    int len;
    while ((len = fileInputStream.read(buffer)) > 0) {
        outputStream.write(buffer, 0, len);
    }
    outputStream.flush()
    outputStream.close()
    fileInputStream.close()
  }

}

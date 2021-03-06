<!doctype html>
<html>

  <head>
    <meta name="layout" content="mainPantallas" />
    <title>Publicacion</title>
  </head>

  <body>
    <div class="container">

      <div class="row">
        <div class="col-md-12">
          <div class="navbar navbar-inverse">
            <div class="container-fluid">
              <ul class="nav navbar-nav">
                <li>
                  <a class="home navbar-brand" href="${createLink(controller : 'usuario' ,action : 'inicioUsuario', params: [idUsuario : usuario.id])}">
                    Volver al inicio
                  </a>
                </li>
                <li> <g:link action="listaPublicaciones" params="[idUsuario:"${usuario.id}"]">${"Volver al listado"}</g:link> </li>
                <li> <g:link controller="${"usuario"}">Cerrar sesi&oacute;n</g:link> </li>
              </ul>
            </div>
          </div>
        </div>
      </div>

      <g:if test="${flash.message}">
        <div class="row">
          <div class="col-md-12">
            <div class="message" role="status">${flash.message}</div>
          </div>
        </div>
      </g:if>

      <div class="row">
        <div class="col-md-12">
          <h1>
            <span>
              Ver publicaci&oacute;n
            </span>
          </h1>
        </div>
      </div>

      <br/>

      <g:form controller="publicacion" action="modificarTextoPublicacion" params="[idUsuario:"${usuario.id}", idPublicacion:"${publicacion.id}"]">
        <div class="row">
          <div class="col-md-12">
            <div class="col-md-7" style="padding-right:0px; padding-left:0px">
              <div class="col-md-2">
                <h3>
                  <span class="label label-default">Texto:</span>
                </h3>
              </div>
              <div class="col-md-10" style="padding-right:0px">
                <g:textArea style="height:150px" class="form-control" name="nuevoTexto" value="${publicacion.texto}" />
                <div class="row">
                  <div class="col-md-12">
                    <div class="col-md-3 col-md-offset-1" style="padding-right:0px">
                      <g:if test="${modificar}">
                        <g:submitButton name="Modificar" value="Modificar" class="btn btn-danger" style="margin-top:10px;" />
                      </g:if>
                    </div>
                    <div class="col-md-4">
                      <g:if test="${!modificar}">
                        <g:form action="calificarPublicacion" params="[idUsuario:"${usuario.id}", idPublicacion:"${publicacion.id}"]">
                          <g:actionSubmit action="calificarNegativo" value="No me gusta" class="btn btn-danger pull-right" style="margin-top:10px;" />
                        </g:form>
                      </g:if>
                      <g:else>
                        <g:form action="eliminarPublicacion" params="[idUsuario:"${usuario.id}", idPublicacion:"${publicacion.id}"]">
                          <g:actionSubmit action="eliminarPublicacion" value="Eliminar publicaci&oacute;n" class="btn btn-danger" style="margin-top:10px;" />
                        </g:form>
                      </g:else>
                    </div>
                    <div class="col-md-4">
                      <g:if test="${modificar}">
                        <g:form action="cambiarEstado" params="[idUsuario:"${usuario.id}", idPublicacion:"${publicacion.id}"]">
                          <g:actionSubmit action="cambiarEstado" value="Cambiar estado" class="btn btn-danger " style="margin-top:10px; margin-left:5px" />
                        </g:form>
                      </g:if>
                      <g:else>
                        <g:form action="calificarPublicacion" params="[idUsuario:"${usuario.id}", idPublicacion:"${publicacion.id}"]">
                          <g:actionSubmit action="calificarPositivo" value="Me gusta" class="btn btn-danger pull-right" style="margin-top:10px;" />
                        </g:form>
                      </g:else>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="col-md-5" style="padding-left:0px;padding-right:0px">
              <div class="col-md-3">
                <h3>
                  <span class="label label-default">Datos:</span>
                </h3>
              </div>
              <div class="col-md-9" style="padding-left:0px; padding-right:0px">
                <ul class="list-group">
                  <li class="list-group-item">
                    Promedio de calificaciones m&iacute;nimo para comentar:
                      <g:if test="${modificar}">
                        <g:form action="modificarPromedioRequeridoParaComentar" params="[idUsuario:"${usuario.id}", idPublicacion:"${publicacion.id}"]">
                          <g:field type="number" step="0.01" name="promedio" value="${publicacion.promedioRequeridoParaComentar}" min="0" max="5"/>
                            <button type="submit" title="Guardar" style="background-color: Transparent;border: none;">
                              <span class="glyphicon glyphicon-ok"></span>
                            </button>
                        </g:form>
                      </g:if>
                      <g:else>
                        ${publicacion.promedioRequeridoParaComentar}
                      </g:else>
                  </li>
                  <li class="list-group-item">
                    Usuario Creador:
                    <span class="label label-info">
                      ${publicacion.usuarioCreador.nombre}
                    </span>
                  </li>
                  <li class="list-group-item">
                      Materia:
                      <g:if test="${modificar}">
                        <g:form controller="publicacion" action="modificarCatedra" params="[idUsuario:"${usuario.id}", idPublicacion:"${publicacion.id}"]">
                          <g:if test="${publicacion.catedraRelacionada}">
                            <g:select name="idCatedra" from="${catedras}" optionValue="${{it.materia.nombre + ", " + "catedra " + it.profesor.nombre}}" optionKey="id" value="${publicacion.catedraRelacionada.id}"/>
                          </g:if>
                          <g:else>
                            <g:select name="idCatedra" from="${catedras}" optionValue="${{it.materia.nombre + ", " + "catedra " + it.profesor.nombre}}" optionKey="id"/>
                          </g:else>
                          <button type="submit" title="Guardar" style="background-color: Transparent;border: none;">
                            <span class="glyphicon glyphicon-ok"></span>
                          </button>
                        </g:form>
                      </g:if>
                      <g:else>
                        <g:if test="${publicacion.catedraRelacionada}">
                          ${publicacion.catedraRelacionada.materia.nombre}, catedra ${publicacion.catedraRelacionada.profesor.nombre}
                        </g:if>
                        <g:else>
                          Ninguna
                        </g:else>
                      </g:else>
                  </li>
                  <li class="list-group-item">
                    Estado:
                    <span class="label label-info">
                       ${publicacion.estado}
                    </span>
                  </li>
                  <li class="list-group-item">
                    Promedio de calificaciones del usuario creador:
                    <span class="label label-info">
                      ${publicacion.usuarioCreador.promedioCalificaciones.round(2)}
                    </span>
                  </li>
                  <g:if test="${modificar}">
                    <li class="list-group-item">
                      Agregar materia necesaria para comentar:
                      <g:form action="agregarMateriaRequeridaParaComentar" params="[idUsuario:"${usuario.id}", idPublicacion:"${publicacion.id}"]">
                        <g:select name="idMateria" from="${materias}" optionValue="${{it.nombre}}" optionKey="id" />
                        <button type="submit" title="Guardar" style="background-color: Transparent;border: none;">
                          <span class="glyphicon glyphicon-ok"></span>
                        </button>
                      </g:form>
                    </li>
                  </g:if>
                  <li class="list-group-item">
                    Fecha y hora de creaci&oacute;n:
                    <span class="label label-info">
                      ${publicacion.fechaHoraCreacion}
                    </span>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </g:form>

      <g:if test="${publicacion.archivoAdjunto}">
        <div class="row">
          <div class="col-md-11 col-md-offset-1" >
            <h3>
              <span class="label label-default">Archivo adjunto:</span>
            </h3>
          </div>
        </div>
        <div class="row" style="padding-top:5px">
          <div class="col-md-11 col-md-offset-1">
              <g:link action="descargarArchivoAdjunto" params="[idArchivo:"${publicacion.archivoAdjunto.id}"]"> Descargar ${publicacion.archivoAdjunto.nombre} </g:link>
          </div>
        </div>
        <br/>
      </g:if>

      <g:if test="${publicacion.encuesta}">
        <div class="row">
          <div class="col-md-11 col-md-offset-1">
            <h3>
              <span class="label label-default">Encuesta: ${publicacion.encuesta.nombre}</span>
            </h3>
          </div>
        </div>
        <div class="row">
            <div class="col-md-6 col-md-offset-3">
              <table class="table table-bordered">
                <thead>
                  <tr>
                    <th>Opciones</th>
                    <th>Cantidad de votos</th>
                    <th>Acciones</th>
                  </tr>
                </thead>
                <tbody>
                  <g:each in="${publicacion.encuesta.opciones.sort { it.nombre }}" var="opcion">
                    <tr>
                      <td>${opcion.nombre}</td>
                      <td>${opcion.votos.size()}</td>
                      <td>
                        <g:form action="votarOpcionEncuesta" params="[idUsuario:"${usuario.id}", idOpcion:"${opcion.id}", idPublicacion:"${publicacion.id}"]" >
    											<button type="submit" title="Votar" style="background-color: Transparent;border: none;font-size: 20px;">
    												<span class="glyphicon glyphicon-thumbs-up" ></span>
    											</button>
    										</g:form>

                        <!-- <g:form action="votarOpcionEncuesta" params="[idUsuario:"${usuario.id}", idOpcion:"${opcion.id}", idPublicacion:"${publicacion.id}"]" >
                          <g:submitButton name="Votar" value="Votar"/>
                        </g:form> -->
                      </td>
                    </tr>
                  </g:each>
                </tbody>
              </table>
            </div>
          </div>

      </g:if>

      <div class="row">
        <div class="col-md-12 col-md-offset-1">

            <h3>
                <span class="label label-default">Materias necesarias para comentar:</span>
            </h3>
          </div>
        </div>

        <div class="row">
            <div class="col-md-4 col-md-offset-4">
            <table class="table table-bordered">
              <thead>
                <tr>
                  <th>Nombre de la materia</th>
                </tr>
              </thead>
              <tbody>
                <g:each in="${publicacion.materiasNecesariasParaComentar.sort { it.nombre }}" var="materia">
                  <tr>
                    <td>${materia.nombre}</td>
                  </tr>
                </g:each>
              </tbody>
            </table>
          </div>
        </div>


      <div class="row">
        <div class="col-md-11 col-md-offset-1">

            <h3>
                <span class="label label-default">Calificaciones:</span>
            </h3>
          </div>
        </div>
        <div class="row">
          <div class="col-md-8 col-md-offset-2">
            <table class="table table-bordered">
              <thead>
                <tr>
                  <th>Usuario que calific&oacute;</th>
                  <th>Tipo de calificaci&oacute;n</th>
                  <th>Promedio de calificaciones del usuario que calific&oacute;</th>
                </tr>
              </thead>
              <tbody>
                <g:each in="${publicacion.calificaciones.sort { it.fechaHoraCreacion }}" var="calificacion">
                  <tr>
                    <td>${calificacion.usuario.nombre}</td>
                    <td>${calificacion.puntaje.tipo.toString().replace("_", " ")}</td>
                    <td>${calificacion.usuario.promedioCalificaciones.round(2)}</td>
                  </tr>
                </g:each>
              </tbody>
            </table>
          </div>
        </div>

      <div class="row">
        <div class="col-md-11 col-md-offset-1">
          <h3>
            <span class="label label-default">Comentarios:</span>
          </h3>
        </div>
      </div>
      <div class="row">
        <div class="col-md-6 col-md-offset-3">
          <table class="table table-bordered">
            <thead>
              <tr>
                <th>Nombre usuario</th>
                <th>Mensaje</th>
                <th>Fecha y hora de creaci&oacute;n</th>
                <th>Acciones</th>
              </tr>
            </thead>
            <tbody>
              <g:each in="${comentarios}" var="comentario">
                <tr>
                  <td>${comentario.usuarioCreador.nombre}</td>
                  <td>${comentario.texto}</td>
                  <td>${comentario.fechaHoraCreacion}</td>
                  <td>
                    <g:form controller="comentario" action="verComentario" params="[idUsuario:"${usuario.id}", idComentario:"${comentario.id}"]">
  										<button type="submit" title="Ver" style="background-color: Transparent;border: none;font-size: 20px;">
  											<span class="glyphicon glyphicon-zoom-in" ></span>
  										</button>
  									</g:form>
                  </td>
                </tr>
              </g:each>
            </tbody>
          </table>
        </div>
      </div>

      <br/>

      <div class="row">
        <div class="col-md-5 col-md-offset-3">
          <g:form action="comentar" params="[idUsuario:"${usuario.id}", idPublicacion:"${publicacion.id}"]">
            <g:textArea name="textoComentario" style="height:50px" class="form-control" placeHolder="Ingrese un comentario" />
            <g:submitButton name="Comentar" class="btn btn-danger pull-right" style="margin-top:5px;" />
          </g:form>
        </div>
      </div>

      <br/>
      <br/>
      <br/>

    </div>
  </body>
  </html>

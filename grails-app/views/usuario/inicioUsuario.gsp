<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Nuevo foro fiuba</title>

    <asset:link rel="icon" href="favicon.ico" type="image/x-ico" />
</head>
<body>
    <content tag="nav">

      <a><li>Hola, ${usuarioInstance.nombreUsuario}</li></a>
      <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Sitios<span class="caret"></span></a>
          <ul class="dropdown-menu">
              <li> <g:link controller="${"prueba"}" id="${usuarioInstance.id}">${"[ZONA PRUEBA]"}</g:link> </li>
              <li> <g:link controller="publicacion" action="listaPublicaciones" max="10" id="${usuarioInstance.id}">${"Ver publicaciones"}</g:link> </li>
              <li> <g:link controller="${"crearMensaje"}" id="${usuarioInstance.id}">${"Chat"}</g:link> </li>
              <li> <g:link controller="${"usuario"}" action="listaUsuarios" id="${usuarioInstance.id}">${"Buscar usuarios"}</g:link> </li>
              <li> <g:link controller="${"usuario"}">${"Cerrar sesion"}</g:link> </li>
          </ul>
      </li>
    </content>

    <div class="svg" role="presentation">
        <div class="grails-logo-container">
            <asset:image src="Logo.jpg" class="grails-logo"/>
        </div>
    </div>

    <div id="content" role="main">
        <section class="row colset-2-its">
            <h1>Bienvenido al nuevo foro fiuba</h1>
        </section>
    </div>

</body>
</html>
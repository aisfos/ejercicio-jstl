<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%--
    EJERCICIO 3 - Etiqueta c:if
    ---------------------------------------------------------------------------
    <c:if test="${condicion}"> ... </c:if>
    Ejecuta su cuerpo solo cuando la expresion de test devuelve verdadero.
    No tiene rama "else": si la condicion es falsa, simplemente no se imprime nada.

    Este archivo es el que DECIDE. No hay JavaScript de por medio: la validacion
    ocurre en el servidor, y si algo falta se responde con una redireccion.
    ---------------------------------------------------------------------------
    <c:redirect url="pagina.jsp">
        <c:param name="clave" value="valor"/>
    </c:redirect>
    Manda al navegador a otra pagina del sitio. Como sustituye por completo el
    contenido de esta respuesta, no puede ejecutarse en medio del HTML: por eso
    todo el bloque de control esta aqui arriba, antes de escribir una sola
    etiqueta. Los <c:param> anaden pares clave=valor a la URL de destino.
--%>

<%--
    1) Regla de negocio: el nombre y el primer apellido no pueden faltar.
       "empty" devuelve true si el valor es null, "" o cualquier objeto vacio,
       asi que cubre tanto el campo en blanco como el parametro no enviado.
--%>
<c:if test="${empty param.nombre or empty param.apellido1}">

    <%-- 2) Se compone el mensaje de error en una variable para no repetirlo --%>
    <c:set var="mensajeError" value="El nombre y el primer apellido son datos obligatorios."/>

    <%--
        3) Redireccion de vuelta al formulario.
           Al no declarar bufferedOutput="false" se mantiene el buffer por omision,
           pero como aun no se escribio nada el problema no llega a aparecer.
    --%>
    <c:redirect url="ejercicio3.jsp">
        <%-- El mensaje viaja como parametro "error" y se pinta con c:if en ejercicio3.jsp --%>
        <c:param name="error" value="${mensajeError}"/>
        <%-- Se devuelven tambien los datos ya escritos para no obligar a teclearlos de nuevo --%>
        <c:param name="nombre" value="${param.nombre}"/>
        <c:param name="apellido1" value="${param.apellido1}"/>
        <c:param name="apellido2" value="${param.apellido2}"/>
    </c:redirect>

    <%--
        4) Esta linea nunca se ejecuta. <c:redirect> lanza una excepcion interna
           que el contenedor despacha, de modo que la pagina se corta aqui.
           Aun asi se documenta: si el formulario llega completo, la respuesta
           que se genera a continuacion es la que el usuario vera.
    --%>
</c:if>

<%-- 5) Datos ya validados: se guardan en variables para poder imprimirlos --%>
<c:set var="nombre" value="${param.nombre}"/>
<c:set var="apellido1" value="${param.apellido1}"/>
<c:set var="apellido2" value="${param.apellido2}"/>

<%-- 6) El segundo apellido es opcional: se decide con un c:if distinto --%>
<c:set var="mostrarApellido2" value="${not empty param.apellido2}"/>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ejercicio 3 - Resultado</title>

    <!-- Bootstrap 5.1.0 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome 5.15.4 -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <!-- Hoja de estilos propia -->
    <link href="css/estilo.css" rel="stylesheet">
</head>

<body class="pagina">

    <!-- ============ ENCABEZADO ============ -->
    <header class="encabezado">
        <div class="container d-flex align-items-center justify-content-between">
            <!-- Logotipo -->
            <a href="index.jsp" class="logo text-decoration-none">
                <i class="fas fa-code"></i>
                <span>Gu&iacute;a JSTL</span>
            </a>

            <!-- Boton Inicio -->
            <a href="index.jsp" class="btn btn-outline-light btn-sm boton-inicio">
                <i class="fas fa-house me-1"></i> Inicio
            </a>
        </div>
    </header>

    <!-- ============ CONTENIDO PRINCIPAL ============ -->
    <main class="contenido">

        <div class="container">

            <div class="row justify-content-center">
                <div class="col-12 col-md-9 col-lg-7">

                    <!-- Tarjeta de resultado -->
                    <div class="tarjeta-resultado">

                        <!-- Encabezado de la tarjeta -->
                        <div class="tarjeta-resultado__header text-center">
                            <i class="fas fa-circle-check"></i>
                            <h2 class="h4 mb-0">Datos validados correctamente</h2>
                        </div>

                        <!-- Cuerpo de la tarjeta -->
                        <div class="tarjeta-resultado__cuerpo">

                            <p class="etiqueta">Campos obligatorios</p>

                            <ul class="list-group list-group-flush lista-valores mb-4">
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <span><i class="fas fa-circle-check"></i> Nombre</span>
                                    <span class="valor"><c:out value="${nombre}"/></span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <span><i class="fas fa-circle-check"></i> Primer apellido</span>
                                    <span class="valor"><c:out value="${apellido1}"/></span>
                                </li>
                            </ul>

                            <p class="etiqueta">Campo opcional</p>

                            <ul class="list-group list-group-flush lista-valores mb-4">
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <span><i class="fas fa-circle-question"></i> Segundo apellido</span>
                                    <%--
                                        c:if NO tiene rama else. Para tener un "si / sino" hay que
                                        escribir dos c:if con condiciones opuestas. Es exactamente
                                        el problema que viene a resolver <c:choose> en el ejercicio 4.
                                    --%>
                                    <c:if test="${mostrarApellido2}">
                                        <span class="valor"><c:out value="${apellido2}"/></span>
                                    </c:if>
                                    <c:if test="${not mostrarApellido2}">
                                        <span class="valor">(sin segundo apellido)</span>
                                    </c:if>
                                </li>
                            </ul>

                            <p class="etiqueta">Nombre completo</p>

                            <div class="total text-center">
                                <span class="total__operacion">
                                    <c:out value="${nombre}"/> <c:out value="${apellido1}"/>
                                </span>
                                <span class="total__valor">
                                    <c:out value="${nombre} ${apellido1} ${mostrarApellido2 ? apellido2 : ''}"/>
                                </span>
                            </div>

                            <p class="form-text mt-3 mb-0 text-center">
                                Si esta pagina aparece, el <code>c:if</code> evaluo la condicion como falsa y no hubo redireccion.
                            </p>

                            <!-- Accion para volver al formulario -->
                            <div class="text-center mt-4 d-flex gap-2 justify-content-center">
                                <a href="ejercicio3.jsp" class="btn btn-outline-rosa">
                                    <i class="fas fa-arrow-left me-1"></i> Volver al formulario
                                </a>
                                <%-- Enlace directo: permite comprobar la validacion sin pasar por el formulario --%>
                                <a href="resultado3.jsp" class="btn btn-outline-rosa">
                                    <i class="fas fa-bug me-1"></i> Probar sin datos
                                </a>
                            </div>

                        </div>
                    </div>

                    <!-- ============ CODIGO JSTL UTILIZADO ============ -->
                    <div class="tarjeta-codigo mt-4">
                        <div class="tarjeta-codigo__header">
                            <i class="fas fa-code"></i> C&oacute;digo JSTL utilizado
                        </div>
                        <pre class="bloque-codigo"><code>&lt;c:if test="\${empty param.nombre or empty param.apellido1}"&gt;
    &lt;c:redirect url="ejercicio3.jsp"&gt;
        &lt;c:param name="error" value="\${mensajeError}"/&gt;
    &lt;/c:redirect&gt;
&lt;/c:if&gt;

&lt;c:set var="mostrarApellido2" value="\${not empty param.apellido2}"/&gt;

&lt;c:if test="\${mostrarApellido2}"&gt;
    &lt;span class="valor"&gt;&lt;c:out value="\${apellido2}"/&gt;&lt;/span&gt;
&lt;/c:if&gt;
&lt;c:if test="\${not mostrarApellido2}"&gt;
    &lt;span class="valor"&gt;(sin segundo apellido)&lt;/span&gt;
&lt;/c:if&gt;</code></pre>
                    </div>

                    <!-- ============ VOLVER AL MENU ============ -->
                    <div class="text-center mt-4">
                        <a href="index.jsp" class="btn btn-enviar">
                            <i class="fas fa-house me-1"></i> Volver al men&uacute;
                        </a>
                    </div>

                </div>
            </div>

        </div>
    </main>

    <!-- ============ PIE DE PAGINA ============ -->
    <footer class="pie">
        <div class="container text-center">
            <p class="mb-0">&copy; 2026 | Todos los derechos reservados</p>
        </div>
    </footer>

    <!-- Bootstrap 5.1.0 (JS) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

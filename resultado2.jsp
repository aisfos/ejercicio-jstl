<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%--
    EJERCICIO 2 - Etiqueta c:set
    ---------------------------------------------------------------------------
    <c:set var="nombreDeVariable" value="${expresionEL}"/>
    Crea (o reescribe) una variable en el ambito de la pagina y le asigna el
    resultado de evaluar la expresion EL. Gracias a esta etiqueta el codigo deja
    de leer param.xxx repetidamente y pasa a usar nombres propios y legibles.
    Los <c:set> se colocaron aqui arriba, antes de cualquier salida HTML, para que
    las variables ya existan cuando se empiece a construir el documento.
--%>

<%-- 1) Se guarda cada parametro recibido en su propia variable JSTL --%>
<c:set var="nombre" value="${param.nombre}"/>
<c:set var="apellido1" value="${param.apellido1}"/>
<c:set var="apellido2" value="${param.apellido2}"/>

<%--
    2) Se arma el nombre completo concatenando las tres variables.
       En un atributo value de <c:set> se pueden mezclar texto y varias
       expresiones EL: el resultado final es una cadena de texto.
--%>
<c:set var="nombreCompleto" value="${nombre} ${apellido1} ${apellido2}"/>

<%--
    3) c:out se encarga de imprimir. Por omision escapa el HTML, de modo que si
       alguien escribiera <b>texto</b> en el formulario se mostraria literally
       y no se ejecutaria como una etiqueta.
       <c:out value="${variable}"/>            -> imprime el valor escapado
       <c:out value="${variable}">texto</c:out> -> imprime el cuerpo de la etiqueta
--%>

<%-- 4) Variables auxiliares para el pie de la pagina --%>
<c:set var="titulo" value="Ejercicio 2 - Resultado"/>
<c:set var="numeroCampos" value="3"/>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${titulo}"/></title>

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
                            <i class="fas fa-floppy-disk"></i>
                            <h2 class="h4 mb-0">Variables guardadas con <code>c:set</code></h2>
                        </div>

                        <!-- Cuerpo de la tarjeta -->
                        <div class="tarjeta-resultado__cuerpo">

                            <p class="etiqueta">Valores recibidos en los parametros</p>

                            <ul class="list-group list-group-flush lista-valores mb-4">
                                <!-- Mismo dato, leido de dos formas distintas -->
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <span><i class="fas fa-1"></i> param.nombre</span>
                                    <span class="valor"><c:out value="${param.nombre}"/></span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <span><i class="fas fa-2"></i> param.apellido1</span>
                                    <span class="valor"><c:out value="${param.apellido1}"/></span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <span><i class="fas fa-3"></i> param.apellido2</span>
                                    <span class="valor"><c:out value="${param.apellido2}"/></span>
                                </li>
                            </ul>

                            <p class="etiqueta">Valores leidos desde las variables de <code>c:set</code></p>

                            <ul class="list-group list-group-flush lista-valores mb-4">
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <span><i class="fas fa-1"></i> <code>${nombre}</code></span>
                                    <span class="valor"><c:out value="${nombre}"/></span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <span><i class="fas fa-2"></i> <code>${apellido1}</code></span>
                                    <span class="valor"><c:out value="${apellido1}"/></span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <span><i class="fas fa-3"></i> <code>${apellido2}</code></span>
                                    <span class="valor"><c:out value="${apellido2}"/></span>
                                </li>
                            </ul>

                            <!-- Nombre completo, construido con Expression Language -->
                            <p class="etiqueta">Nombre completo</p>

                            <div class="total text-center">
                                <span class="total__operacion">
                                    <c:out value="${nombre}"/> <c:out value="${apellido1}"/> <c:out value="${apellido2}"/>
                                </span>
                                <span class="total__valor"><c:out value="${nombreCompleto}"/></span>
                            </div>

                            <p class="form-text mt-3 mb-0 text-center">
                                Se guardaron <c:out value="${numeroCampos}"/> variables con <code>&lt;c:set&gt;</code>.
                            </p>

                            <!-- Accion para volver al formulario -->
                            <div class="text-center mt-4">
                                <a href="ejercicio2.jsp" class="btn btn-outline-rosa">
                                    <i class="fas fa-arrow-left me-1"></i> Volver al formulario
                                </a>
                            </div>

                        </div>
                    </div>

                    <!-- ============ CODIGO JSTL UTILIZADO ============ -->
                    <div class="tarjeta-codigo mt-4">
                        <div class="tarjeta-codigo__header">
                            <i class="fas fa-code"></i> C&oacute;digo JSTL utilizado
                        </div>
                        <pre class="bloque-codigo"><code>&lt;c:set var="nombre" value="\${param.nombre}"/&gt;
&lt;c:set var="apellido1" value="\${param.apellido1}"/&gt;
&lt;c:set var="apellido2" value="\${param.apellido2}"/&gt;

&lt;c:set var="nombreCompleto" value="\${nombre} \${apellido1} \${apellido2}"/&gt;

&lt;c:out value="\${nombreCompleto}"/&gt;</code></pre>
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

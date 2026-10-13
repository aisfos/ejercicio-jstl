<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%--
    EJERCICIO 7 - Etiqueta c:forTokens
    ---------------------------------------------------------------------------
    <c:forTokens items="${texto}" delims="${delimitadores}" var="palabra">
        ...
    </c:forTokens>

    Es un c:forEach que no recorre una coleccion sino un texto: lo parte usando
    los caracteres indicados en "delims" y entrega cada trozo por separado.

    - items    : el texto a separar (debe ser una cadena)
    - delims   : los caracteres separadores. OJO: se toman uno a uno, asi que
                 delims=",;" parte por coma y por punto y coma, no por la cadena ",;"
    - var      : donde se guarda cada trozo
    - varStatus: funciona igual que en c:forEach (first, last, count, index)

    Ventaja frente a String.split(): no hay que escribir "\\s+" ni escapar
    caracteres especiales, y nunca falla por una expresion regular mal escrita.

    NOTA IMPORTANTE sobre la estructura de la pagina:
    el <ul> tiene que estar abierto ANTES de empezar el bucle, porque cada vuelta
    escribe un <li> dentro de el. Por eso aqui el bucle vive dentro del HTML y no
    al principio del archivo, que es donde se suele poner el resto de ejercicios.
--%>

<%-- 1) Se recogen los dos parametros del formulario --%>
<c:set var="texto" value="${param.texto}"/>
<c:set var="delim" value="${param.delim}"/>

<%-- 2) Bandera para saber si hay algo que separar --%>
<c:set var="hayTexto" value="${not empty texto}"/>
<c:set var="hayDelim" value="${not empty delim}"/>
<c:set var="totalPalabras" value="0"/>

<%--
    3) Conteo de palabras, recorre el texto caracter a caracter con c:forEach
       (que sobre un String tambien sirve de contador) y cuenta cuantas veces
       aparece el delimitador. El numero de palabras es esa cuenta mas uno.
       Se calcula aparte para poder mostrarlo aunque el texto no se separe.
--%>
<c:forEach items="${texto}" var="caracter">
    <c:if test="${caracter == delim}">
        <c:set var="totalPalabras" value="${totalPalabras + 1}"/>
    </c:if>
</c:forEach>
<c:if test="${hayTexto}">
    <c:set var="totalPalabras" value="${totalPalabras + 1}"/>
</c:if>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ejercicio 7 - Resultado</title>

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
                            <i class="fas fa-scissors"></i>
                            <h2 class="h4 mb-0">Palabras separadas</h2>
                        </div>

                        <!-- Cuerpo de la tarjeta -->
                        <div class="tarjeta-resultado__cuerpo">

                            <p class="etiqueta">Datos usados en <code>c:forTokens</code></p>

                            <ul class="list-group list-group-flush lista-valores mb-4">
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <span><i class="fas fa-align-left"></i> <code>items</code></span>
                                    <span class="valor"><c:out value="${texto}"/></span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <span><i class="fas fa-code"></i> <code>delims</code></span>
                                    <c:choose>
                                        <c:when test="${hayDelim}">
                                            <span class="valor"><c:out value="${delim}"/></span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="valor">(vacio)</span>
                                        </c:otherwise>
                                    </c:choose>
                                </li>
                            </ul>

                            <p class="etiqueta">Resultado de la separacion</p>

                            <%--
                                Si falta el texto o el delimitador no se ejecuta el bucle:
                                c:forTokens con delims vacio devolveria el texto entero
                                como un unico token, que no es lo que se quiere mostrar.
                            --%>
                            <c:choose>
                                <c:when test="${not hayTexto or not hayDelim}">
                                    <div class="total text-center">
                                        <span class="total__operacion">
                                            <i class="fas fa-circle-info me-1"></i> No hay nada que separar
                                        </span>
                                        <span class="total__valor" style="font-size: 1.25rem;">
                                            Vuelve al formulario y escribe un texto y un delimitador.
                                        </span>
                                    </div>
                                </c:when>

                                <c:otherwise>
                                    <%-- ---- BUCLE PRINCIPAL DEL EJERCICIO ---- --%>
                                    <ul class="list-group list-group-flush lista-valores">
                                        <c:forTokens items="${texto}" delims="${delim}" var="palabra" varStatus="status">

                                            <%-- Mensaje especial en la PRIMERA palabra separada --%>
                                            <c:if test="${status.first}">
                                                <li class="pista-iteracion">
                                                    <i class="fas fa-play me-1"></i>
                                                    <strong>status.first = true</strong> en la primera palabra separada
                                                </li>
                                            </c:if>

                                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                                <span>
                                                    <i class="fas fa-quote-right me-1"></i>
                                                    <span class="text-muted small">palabra <c:out value="${status.count}"/></span>
                                                </span>
                                                <span class="valor"><c:out value="${palabra}"/></span>
                                            </li>

                                            <%-- Mensaje especial en la ULTIMA palabra separada --%>
                                            <c:if test="${status.last}">
                                                <li class="pista-iteracion">
                                                    <i class="fas fa-flag me-1"></i>
                                                    <strong>status.last = true</strong> en la ultima palabra separada
                                                </li>
                                            </c:if>

                                        </c:forTokens>
                                    </ul>
                                </c:otherwise>
                            </c:choose>

                            <p class="etiqueta mt-4">Resumen</p>

                            <div class="total text-center">
                                <span class="total__operacion">
                                    <c:choose>
                                        <c:when test="${hayTexto and hayDelim}">
                                            Se separaron <c:out value="${totalPalabras}"/> palabra(s) usando
                                            &quot;<c:out value="${delim}"/>&quot; como delimitador
                                        </c:when>
                                        <c:otherwise>
                                            No se realizo ninguna separacion
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                                <span class="total__valor"><c:out value="${totalPalabras}"/></span>
                            </div>

                            <p class="form-text mt-3 mb-0 text-center">
                                Cada trozo se imprimo con <code>&lt;c:out&gt;</code> y los separadores quedaron fuera del resultado.
                            </p>

                            <!-- Accion para volver al formulario -->
                            <div class="text-center mt-4">
                                <a href="ejercicio7.jsp" class="btn btn-outline-rosa">
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
                        <pre class="bloque-codigo"><code>&lt;c:set var="texto" value="\${param.texto}"/&gt;
&lt;c:set var="delim" value="\${param.delim}"/&gt;

&lt;ul class="list-group"&gt;
    &lt;c:forTokens items="\${texto}" delims="\${delim}" var="palabra" varStatus="status"&gt;

        &lt;c:if test="\${status.first}"&gt;
            &lt;li class="pista-iteracion"&gt;status.first = true en la primera palabra&lt;/li&gt;
        &lt;/c:if&gt;

        &lt;li class="list-group-item"&gt;
            palabra &lt;c:out value="\${status.count}"/&gt;: &lt;c:out value="\${palabra}"/&gt;
        &lt;/li&gt;

        &lt;c:if test="\${status.last}"&gt;
            &lt;li class="pista-iteracion"&gt;status.last = true en la ultima palabra&lt;/li&gt;
        &lt;/c:if&gt;

    &lt;/c:forTokens&gt;
&lt;/ul&gt;</code></pre>
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

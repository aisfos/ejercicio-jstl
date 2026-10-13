<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ejercicio 6 - Etiqueta c:forEach</title>

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

            <!-- Titulo del ejercicio -->
            <div class="text-center mb-4">
                <h1 class="titulo">Ejercicio 6: Etiqueta <code>c:forEach</code></h1>
                <p class="subtitulo">Recorrido del 1 al 20 y mensajes especiales en la primera y en la quinta iteraci&oacute;n.</p>
            </div>

            <div class="row justify-content-center">
                <div class="col-12 col-md-10 col-lg-8">

                    <!-- Tarjeta de resultado -->
                    <div class="tarjeta-resultado">

                        <!-- Encabezado de la tarjeta -->
                        <div class="tarjeta-resultado__header text-center">
                            <i class="fas fa-list-ol"></i>
                            <h2 class="h4 mb-0">Del 1 al 20 con <code>varStatus</code></h2>
                        </div>

                        <!-- Cuerpo de la tarjeta -->
                        <div class="tarjeta-resultado__cuerpo">

                            <%--
                                ---- BUCLE PRINCIPAL ----
                                <c:forEach begin="1" end="20" step="1" var="i" varStatus="status">
                                    ...
                            </c:forEach>
                            </div>


                                Cuando no se indica "items", c:forEach se comporta como un
                                contador y usa begin / end / step para recorrer un rango de
                                enteros. El valor de la vuelta va a "var" y el estado de la
                                vuelta va a "varStatus".

                                Atributos de varStatus usados aqui:
                                    first  -> true solo en la primera vuelta
                                    last   -> true solo en la ultima vuelta
                                    count  -> posicion de la vuelta, empezando en 1
                                    index  -> posicion de la vuelta, empezando en 0
                            --%>
                            <div class="lista-numeros">
                            <c:forEach begin="1" end="20" step="1" var="i" varStatus="status">

                                <%-- PRIMERA ITERACION: status.first vale true unicamente aqui --%>
                                <c:if test="${status.first}">
                                    <div class="pista-iteracion">
                                        <i class="fas fa-flag-checkered me-1"></i>
                                        <strong>status.first = true</strong> en el numero
                                        <c:out value="${i}"/> (primera vuelta del bucle).
                                    </div>
                                </c:if>

                                <%-- QUINTA ITERACION: status.count empieza en 1, asi que 5 es el quinto --%>
                                <c:if test="${status.count == 5}">
                                    <div class="pista-iteracion">
                                        <i class="fas fa-star me-1"></i>
                                        <strong>status.count = 5</strong> en el numero
                                        <c:out value="${i}"/> (quinta vuelta del bucle).
                                    </div>
                                </c:if>

                                <%-- Chip con el numero actual --%>
                                <span class="numero-chip">
                                    <c:out value="${i}"/>
                                    <%-- Etiquetas ocultas con los atributos de varStatus, visibles al pasar el raton --%>
                                    <span class="numero-chip__dato">count=<c:out value="${status.count}"/></span>
                                </span>

                                <%-- ULTIMA ITERACION: status.last cierra la serie --%>
                                <c:if test="${status.last}">
                                    <div class="pista-iteracion">
                                        <i class="fas fa-flag me-1"></i>
                                        <strong>status.last = true</strong> en el numero
                                        <c:out value="${i}"/> (ultima vuelta del bucle).
                                    </div>
                                </c:if>

                            </c:forEach>

                            <%--
                                Resumen calculado a partir del propio bucle.
                                No se cuenta a mano: se acumulan los valores al final de
                                cada vuelta, ya convertidos a numero por Expression Language.
                            --%>
                            <c:set var="suma" value="0"/>
                            <c:forEach begin="1" end="20" step="1" var="n">
                                <c:set var="suma" value="${suma + n}"/>
                            </c:forEach>

                            <p class="etiqueta mt-4">Resumen de la serie</p>

                            <div class="total text-center">
                                <span class="total__operacion">
                                    Cantidad de iteraciones: 20 &nbsp;|&nbsp;
                                    Suma acumulada: <c:out value="${suma}"/>
                                </span>
                                <span class="total__valor">
                                    1 &rarr; 2 &rarr; 3 &hellip; 20
                                </span>
                            </div>

                        </div>
                    </div>

                    <!-- ============ CODIGO JSTL UTILIZADO ============ -->
                    <div class="tarjeta-codigo mt-4">
                        <div class="tarjeta-codigo__header">
                            <i class="fas fa-code"></i> C&oacute;digo JSTL utilizado
                        </div>
                        <pre class="bloque-codigo"><code>&lt;c:forEach begin="1" end="20" step="1" var="i" varStatus="status"&gt;
    &lt;c:if test="\${status.first}"&gt;
        status.first = true en la primera vuelta: &lt;c:out value="\${i}"/&gt;
    &lt;/c:if&gt;
    &lt;c:if test="\${status.count == 5}"&gt;
        status.count = 5 en la quinta vuelta: &lt;c:out value="\${i}"/&gt;
    &lt;/c:if&gt;
    &lt;span class="numero-chip"&gt;&lt;c:out value="\${i}"/&gt;&lt;/span&gt;
    &lt;c:if test="\${status.last}"&gt;
        status.last = true en la ultima vuelta: &lt;c:out value="\${i}"/&gt;
    &lt;/c:if&gt;
&lt;/c:forEach&gt;

&lt;c:set var="suma" value="0"/&gt;
&lt;c:forEach begin="1" end="20" var="n"&gt;
    &lt;c:set var="suma" value="\${suma + n}"/&gt;
&lt;/c:forEach&gt;</code></pre>
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

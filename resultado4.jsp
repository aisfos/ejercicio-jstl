<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%--
    EJERCICIO 4 - Etiquetas c:choose, c:when y c:otherwise
    ---------------------------------------------------------------------------
    <c:choose>
        <c:when test="${condicion1}"> ... </c:when>
        <c:when test="${condicion2}"> ... </c:when>
        <c:otherwise> ... </c:otherwise>
    </c:choose>

    Es un "si / si no / sino" clasico:
      - los <c:when> se prueban de arriba abajo,
      - en cuanto uno devuelve true se imprime su cuerpo y se saltan los demas,
      - si ninguno se cumple, se imprime el unico <c:otherwise>.

    Ventaja frente a dos <c:if>: la condicion opuesta no se escribe nunca, asi que
    no se puede equivocar uno al invertirla.
--%>

<%-- Se guarda el parametro del desplegable en una variable legible --%>
<c:set var="tema" value="${param.tema}"/>
<c:set var="comentario" value="${param.comentario}"/>

<%--
    Se prepara el encabezado de la tarjeta con un c:choose anidado, para que el
    icono y el titulo tambien cambien segun el tema. Asi se ve que el patron
    sirve tanto para un texto pequeno como para el bloque principal de la pagina.
--%>
<c:choose>
    <c:when test="${tema == 'lenguajes'}">
        <c:set var="icono" value="fa-code"/>
        <c:set var="titulo" value="Lenguajes de programacion"/>
    </c:when>
    <c:when test="${tema == 'mascotas'}">
        <c:set var="icono" value="fa-paw"/>
        <c:set var="titulo" value="Mascotas"/>
    </c:when>
    <c:when test="${tema == 'deportes'}">
        <c:set var="icono" value="fa-futbol"/>
        <c:set var="titulo" value="Deportes"/>
    </c:when>
    <c:otherwise>
        <c:set var="icono" value="fa-circle-question"/>
        <c:set var="titulo" value="Ningun tema seleccionado"/>
    </c:otherwise>
</c:choose>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ejercicio 4 - Resultado</title>

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

                        <!-- Encabezado: el icono y el titulo ya se resolvieron con el c:choose de arriba -->
                        <div class="tarjeta-resultado__header text-center">
                            <i class="fas ${icono}"></i>
                            <h2 class="h4 mb-0"><c:out value="${titulo}"/></h2>
                        </div>

                        <!-- Cuerpo de la tarjeta -->
                        <div class="tarjeta-resultado__cuerpo">

                            <p class="etiqueta">Valor recibido en <code>param.tema</code></p>

                            <div class="total text-center mb-4">
                                <span class="total__operacion">
                                    <c:choose>
                                        <c:when test="${empty tema}">(vacio)</c:when>
                                        <c:otherwise><c:out value="${tema}"/></c:otherwise>
                                    </c:choose>
                                </span>
                                <span class="total__valor" style="font-size: 1.75rem;">
                                    <c:out value="${titulo}"/>
                                </span>
                            </div>

                            <p class="etiqueta">Respuesta seleccionada con <code>c:choose</code></p>

                            <%--
                                ---- MENSAJE PRINCIPAL DEL EJERCICIO ----
                                Un unico c:choose con tres c:when y un c:otherwise.
                                Solo uno de los cuatro bloques llega a imprimirse.
                            --%>
                            <c:choose>

                                <%-- Rama 1: el tema es lenguajes de programacion --%>
                                <c:when test="${tema == 'lenguajes'}">
                                    <div class="total">
                                        <span class="total__operacion">
                                            <i class="fas fa-code me-1"></i> <code>c:when</code> n&uacute;mero 1 -&gt; lenguajes
                                        </span>
                                        <span class="total__valor" style="font-size: 1.25rem;">
                                            Java, JavaScript, Python, PHP, SQL y muchos m&aacute;s.
                                        </span>
                                    </div>
                                </c:when>

                                <%-- Rama 2: el tema es mascotas --%>
                                <c:when test="${tema == 'mascotas'}">
                                    <div class="total">
                                        <span class="total__operacion">
                                            <i class="fas fa-paw me-1"></i> <code>c:when</code> n&uacute;mero 2 -&gt; mascotas
                                        </span>
                                        <span class="total__valor" style="font-size: 1.25rem;">
                                            Perros, gatos, peces, p&aacute;jaros y hámsters.
                                        </span>
                                    </div>
                                </c:when>

                                <%-- Rama 3: el tema es deportes --%>
                                <c:when test="${tema == 'deportes'}">
                                    <div class="total">
                                        <span class="total__operacion">
                                            <i class="fas fa-futbol me-1"></i> <code>c:when</code> n&uacute;mero 3 -&gt; deportes
                                        </span>
                                        <span class="total__valor" style="font-size: 1.25rem;">
                                            F&uacute;tbol, b&aacute;squetbol, nataci&oacute;n, ciclismo y tenis.
                                        </span>
                                    </div>
                                </c:when>

                                <%--
                                    Rama 4: c:otherwise.
                                    Se ejecuta cuando ningun c:when resulto verdadero, es decir,
                                    cuando el desplegable se dejo en la opcion "-- Sin seleccion --".
                                    Si se olvida esta rama y ningun c:when coincide, la tarjeta
                                    se mostraria vacia sin avisar de nada.
                                --%>
                                <c:otherwise>
                                    <div class="total">
                                        <span class="total__operacion">
                                            <i class="fas fa-circle-question me-1"></i> <code>c:otherwise</code> -&gt; no se eligio tema
                                        </span>
                                        <span class="total__valor" style="font-size: 1.25rem;">
                                            Todav&iacute;a no has seleccionado ning&uacute;n tema. Vuelve al formulario y elige uno.
                                        </span>
                                    </div>
                                </c:otherwise>

                            </c:choose>

                            <%-- El comentario del usuario solo se muestra si se escribio algo --%>
                            <c:if test="${not empty param.comentario}">
                                <p class="etiqueta mt-4">Tu comentario</p>
                                <div class="total">
                                    <span class="total__valor" style="font-size: 1.05rem;">
                                        <c:out value="${comentario}"/>
                                    </span>
                                </div>
                            </c:if>

                            <!-- Accion para volver al formulario -->
                            <div class="text-center mt-4 d-flex gap-2 justify-content-center flex-wrap">
                                <a href="ejercicio4.jsp" class="btn btn-outline-rosa">
                                    <i class="fas fa-arrow-left me-1"></i> Volver al formulario
                                </a>
                                <%-- Atajo para ver la rama c:otherwise sin usar el formulario --%>
                                <a href="resultado4.jsp" class="btn btn-outline-rosa">
                                    <i class="fas fa-bug me-1"></i> Probar sin elegir
                                </a>
                            </div>

                        </div>
                    </div>

                    <!-- ============ CODIGO JSTL UTILIZADO ============ -->
                    <div class="tarjeta-codigo mt-4">
                        <div class="tarjeta-codigo__header">
                            <i class="fas fa-code"></i> C&oacute;digo JSTL utilizado
                        </div>
                        <pre class="bloque-codigo"><code>&lt;c:set var="tema" value="\${param.tema}"/&gt;

&lt;c:choose&gt;
    &lt;c:when test="\${tema == 'lenguajes'}"&gt;
        Java, JavaScript, Python, PHP, SQL y muchos más.
    &lt;/c:when&gt;
    &lt;c:when test="\${tema == 'mascotas'}"&gt;
        Perros, gatos, peces, pájaros y hámsters.
    &lt;/c:when&gt;
    &lt;c:when test="\${tema == 'deportes'}"&gt;
        Fútbol, básquetbol, natación, ciclismo y tenis.
    &lt;/c:when&gt;
    &lt;c:otherwise&gt;
        Todavía no has seleccionado ningún tema. Vuelve al formulario.
    &lt;/c:otherwise&gt;
&lt;/c:choose&gt;</code></pre>
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

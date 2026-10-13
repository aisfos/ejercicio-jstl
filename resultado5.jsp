<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%--
    EJERCICIO 5 - Etiqueta c:catch
    ---------------------------------------------------------------------------
    <c:catch var="nombreDeVariable"> ... </c:catch>
    Envuelve un bloque de codigo y, si en ese bloque se lanza una excepcion,
    la intercepta en lugar de dejar que reviente la pagina con un error 500.

    - Si el bloque termina bien, la variable "var" queda vacia (empty).
    - Si el bloque falla, la variable recibe el objeto Throwable con el detalle.
    - A diferencia de try/catch de Java, no hay que declarar el tipo de excepcion
      ni escribirla, y el bloque "recuperado" se decide despues con un c:if
      o un c:choose, dejando el HTML separado de la logica.

    Ojo: c:catch captura Exception, no Error. Y si el codigo de la pagina no
    compila, la compilacion falla igualmente: c:catch no es un sustituto de
    revisar la sintaxis.
--%>

<%-- 1) Texto tal cual llego, para poder mostrarlo siempre (bueno o malo) --%>
<c:set var="valorRecibido" value="${empty param.numero ? '(el parametro no fue enviado)' : param.numero}"/>
<c:set var="llegoParametro" value="${not empty param.numero}"/>

<%--
    2) Bloque protegido. Aqui se intenta la conversion pedida en el enunciado.

    El cuerpo es JSTL + Expression Language: no hay scriptlets. La expresion
    resuelve la clase java.lang.Integer (paquete importado por omision en EL)
    y llama a su metodo parseInt, de modo que sigue siendo Integer.parseInt()
    el que convierte el texto que llega en param.numero.

    Integer.parseInt() lanza NumberFormatException en dos situaciones:
        - el texto no es un entero  ("no soy un numero" -> error)
        - el parametro no llego      (null             -> error)
    En ambos casos la excepcion se guarda en la variable "error" y la pagina sigue.
--%>
<c:catch var="error">
    <c:set var="numeroConvertido" value="${Integer.parseInt(param.numero)}"/>
</c:catch>

<%--
    3) Se decide que mostrar. <c:choose> lee "error": si esta vacia la conversion
       salio bien; si tiene contenido, la excepcion fue capturada.
       (Aqui se podria usar tambien un simple <c:if test="${empty error}">,
        pero hace falta una rama "sino", y eso es justo lo que aporta c:choose.)
--%>
<c:set var="conversionExitosa" value="${empty error}"/>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ejercicio 5 - Resultado</title>

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

                        <!--
                            Encabezado: el icono y el titulo dependen de si hubo error.
                            Se resuelve con c:if + c:if (sin c:choose) para no repetir
                            la estructura completa dos veces.
                        -->
                        <c:if test="${conversionExitosa}">
                            <div class="tarjeta-resultado__header text-center">
                                <i class="fas fa-circle-check"></i>
                                <h2 class="h4 mb-0">Conversion correcta</h2>
                            </div>
                        </c:if>
                        <c:if test="${not conversionExitosa}">
                            <div class="tarjeta-resultado__header text-center">
                                <i class="fas fa-bug"></i>
                                <h2 class="h4 mb-0">Excepcion capturada con <code>c:catch</code></h2>
                            </div>
                        </c:if>

                        <!-- Cuerpo de la tarjeta -->
                        <div class="tarjeta-resultado__cuerpo">

                            <p class="etiqueta">Valor recibido en <code>param.numero</code></p>

                            <ul class="list-group list-group-flush lista-valores mb-4">
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <span><i class="fas fa-inbox"></i> Texto enviado</span>
                                    <span class="valor"><c:out value="${valorRecibido}"/></span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <span><i class="fas fa-hashtag"></i> Tipo en Java</span>
                                    <c:choose>
                                        <c:when test="${llegoParametro}">String</c:when>
                                        <c:otherwise>null</c:otherwise>
                                    </c:choose>
                                </li>
                            </ul>

                            <p class="etiqueta">Resultado de <code>Integer.parseInt()</code></p>

                            <%--
                                ---- BLOQUE CENTRAL DEL EJERCICIO ----
                                Solo una de las dos ramas llega a pintarse.
                            --%>
                            <c:choose>

                                <%-- Conversion correcta: la variable error quedo vacia --%>
                                <c:when test="${conversionExitosa}">
                                    <div class="total text-center">
                                        <span class="total__operacion">
                                            <c:out value="${valorRecibido}"/> es un entero valido
                                        </span>
                                        <span class="total__valor"><c:out value="${numeroConvertido}"/></span>
                                    </div>
                                    <p class="form-text text-center mt-3 mb-0">
                                        Tipo del resultado en memoria: <code><c:out value="${numeroConvertido['class'].simpleName}"/></code>
                                    </p>
                                </c:when>

                                <%-- Conversion fallida: error contiene la excepcion capturada --%>
                                <c:otherwise>
                                    <div class="alert alert-danger alerta-error d-flex align-items-start" role="alert">
                                        <i class="fas fa-circle-exclamation me-2 mt-1"></i>
                                        <div>
                                            <strong class="d-block">No se pudo convertir el valor a entero</strong>
                                            <span><c:out value="${error.message}"/></span>
                                        </div>
                                    </div>

                                    <%-- Se muestran tambien los datos tecnicos de la excepcion --%>
                                    <ul class="list-group list-group-flush lista-valores mt-3">
                                        <li class="list-group-item d-flex justify-content-between align-items-center">
                                            <span><i class="fas fa-code"></i> Clase de la excepcion</span>
                                            <span class="valor"><c:out value="${error['class'].simpleName}"/></span>
                                        </li>
                                        <li class="list-group-item d-flex justify-content-between align-items-center">
                                            <span><i class="fas fa-align-left"></i> Mensaje</span>
                                            <span class="valor"><c:out value="${error.message}"/></span>
                                        </li>
                                    </ul>
                                </c:otherwise>

                            </c:choose>

                            <%--
                                Demostracion extra: el mismo fallo se puede provocar sin Java.
                                Expression Language tambien lanza NumberFormatException al
                                intentar sumar texto, y c:catch lo intercepta igual.
                            --%>
                            <c:if test="${llegoParametro}">
                                <p class="etiqueta mt-4">Mismo error pero provocado con Expression Language</p>

                                <c:catch var="errorEl">
                                    <%-- Esta suma es la que revienta si "numero" no es un numero --%>
                                    <c:set var="doble" value="${param.numero * 2}"/>
                                </c:catch>

                                <c:choose>
                                    <c:when test="${empty errorEl}">
                                        <div class="total text-center">
                                            <span class="total__operacion">
                                                <c:out value="${valorRecibido}"/> &times; 2
                                            </span>
                                            <span class="total__valor"><c:out value="${doble}"/></span>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="total">
                                            <span class="total__operacion">
                                                <i class="fas fa-circle-exclamation me-1"></i>
                                                Excepcion capturada por el segundo <code>c:catch</code>
                                            </span>
                                            <span class="total__valor" style="font-size: 1.05rem;">
                                                <c:out value="${errorEl.message}"/>
                                            </span>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>

                            <!-- Accion para volver al formulario -->
                            <div class="text-center mt-4">
                                <a href="ejercicio5.jsp" class="btn btn-outline-rosa">
                                    <i class="fas fa-arrow-left me-1"></i> Volver a los botones de prueba
                                </a>
                            </div>

                        </div>
                    </div>

                    <!-- ============ CODIGO JSTL UTILIZADO ============ -->
                    <div class="tarjeta-codigo mt-4">
                        <div class="tarjeta-codigo__header">
                            <i class="fas fa-code"></i> C&oacute;digo JSTL utilizado
                        </div>
                        <pre class="bloque-codigo"><code>&lt;c:catch var="error"&gt;
    &lt;c:set var="numeroConvertido" value="\${Integer.parseInt(param.numero)}"/&gt;
&lt;/c:catch&gt;

&lt;c:set var="conversionExitosa" value="\${empty error}"/&gt;

&lt;c:choose&gt;
    &lt;c:when test="\${conversionExitosa}"&gt;
        &lt;c:out value="\${numeroConvertido}"/&gt;
    &lt;/c:when&gt;
    &lt;c:otherwise&gt;
        &lt;c:out value="\${error.message}"/&gt;
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

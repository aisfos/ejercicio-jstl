<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%--
    Se guardan los tres parametros recibidos en variables JSTL.
    Al no aplicar value con <c:out>, las variables conservan el valor
    numerico original del parametro y pueden sumarse con Expression Language.
--%>
<c:set var="num1" value="${param.num1}"/>
<c:set var="num2" value="${param.num2}"/>
<c:set var="num3" value="${param.num3}"/>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ejercicio 1 - Resultado</title>

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
                            <h2 class="h4 mb-0">Resultado de la suma</h2>
                        </div>

                        <!-- Cuerpo de la tarjeta -->
                        <div class="tarjeta-resultado__cuerpo">

                            <!-- Valores ingresados -->
                            <p class="etiqueta">Valores ingresados</p>

                            <ul class="list-group list-group-flush lista-valores mb-4">
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <span><i class="fas fa-1"></i> N&uacute;mero 1</span>
                                    <span class="valor"><c:out value="${num1}"/></span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <span><i class="fas fa-2"></i> N&uacute;mero 2</span>
                                    <span class="valor"><c:out value="${num2}"/></span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <span><i class="fas fa-3"></i> N&uacute;mero 3</span>
                                    <span class="valor"><c:out value="${num3}"/></span>
                                </li>
                            </ul>

                            <!-- Resultado de la suma, calculado con Expression Language -->
                            <p class="etiqueta">Resultado</p>

                            <div class="total text-center">
                                <span class="total__operacion">
                                    <c:out value="${num1}"/> + <c:out value="${num2}"/> + <c:out value="${num3}"/> =
                                </span>
                                <span class="total__valor"><c:out value="${num1 + num2 + num3}"/></span>
                            </div>

                            <!-- Accion para volver al formulario -->
                            <div class="text-center mt-4">
                                <a href="ejercicio1.jsp" class="btn btn-outline-rosa">
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
                        <pre class="bloque-codigo"><code>&lt;c:set var="num1" value="\${param.num1}"/&gt;
&lt;c:set var="num2" value="\${param.num2}"/&gt;
&lt;c:set var="num3" value="\${param.num3}"/&gt;

&lt;c:out value="\${num1}"/&gt; + &lt;c:out value="\${num2}"/&gt; + &lt;c:out value="\${num3}"/&gt; =
&lt;c:out value="\${num1 + num2 + num3}"/&gt;</code></pre>
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

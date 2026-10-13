<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ejercicio 3 - Etiqueta c:if</title>

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
                <h1 class="titulo">Ejercicio 3: Etiqueta <code>c:if</code></h1>
                <p class="subtitulo">El nombre y el primer apellido son obligatorios. Si falta alguno, el servidor redirige con <code>&lt;c:redirect&gt;</code>.</p>
            </div>

            <div class="row justify-content-center">
                <div class="col-12 col-md-8 col-lg-6">

                    <!--
                        Mensaje de error mostrado solo cuando existe el parametro "error".
                        Ese parametro lo envia resultado3.jsp usando &lt;c:redirect&gt; + &lt;c:param&gt;,
                        de modo que al recargar la pagina el aviso se conserva.
                    -->
                    <c:if test="${not empty param.error}">
                        <div class="alert alert-danger alerta-error d-flex align-items-start" role="alert">
                            <i class="fas fa-circle-exclamation me-2 mt-1"></i>
                            <div>
                                <strong class="d-block">No se pudo continuar</strong>
                                <span><c:out value="${param.error}"/></span>
                            </div>
                        </div>
                    </c:if>

                    <!--
                        La validacion real NO esta aqui: para esto existe c:if en el servidor.
                        El atributo required y la clase needs-validation son solo una ayuda
                        visual para el usuario. Prueba a desactivar JavaScript o a llamar
                        directamente a resultado3.jsp sin enviar nada y veras que el
                        formulario igual se rechaza desde el servidor.
                    -->
                    <form action="resultado3.jsp" method="post" class="tarjeta-formulario needs-validation" novalidate>

                        <!-- Nombre: obligatorio (validado con c:if en el servidor) -->
                        <div class="mb-3">
                            <label for="nombre" class="form-label">Nombre <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="nombre" name="nombre"
                                   value="<c:out value="${param.nombre}"/>" required>
                            <div class="invalid-feedback">Ingresa tu nombre.</div>
                        </div>

                        <!-- Primer apellido: obligatorio -->
                        <div class="mb-3">
                            <label for="apellido1" class="form-label">Primer apellido <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="apellido1" name="apellido1"
                                   value="<c:out value="${param.apellido1}"/>" required>
                            <div class="invalid-feedback">Ingresa tu primer apellido.</div>
                        </div>

                        <!-- Segundo apellido: NO se valida, puede venir vacio -->
                        <div class="mb-4">
                            <label for="apellido2" class="form-label">Segundo apellido</label>
                            <input type="text" class="form-control" id="apellido2" name="apellido2"
                                   value="<c:out value="${param.apellido2}"/>">
                            <div class="form-text">Opcional: si lo dejas vacio se imprime (sin segundo apellido).</div>
                        </div>

                        <!-- Botones -->
                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-enviar flex-grow-1">
                                <i class="fas fa-check me-1"></i> Validar
                            </button>
                            <button type="reset" class="btn btn-outline-rosa">
                                <i class="fas fa-eraser me-1"></i> Limpiar
                            </button>
                        </div>

                    </form>

                    <!-- Aviso: como provocar el error a proposito -->
                    <p class="form-text text-center mt-3 mb-0">
                        <i class="fas fa-circle-info me-1"></i>
                        Envia solo el nombre (o solo el apellido) para ver el <code>c:redirect</code> en accion.
                    </p>

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
    <script>
        // Activar la validacion del formulario de Bootstrap 5
        (function () {
            'use strict';
            var formulario = document.querySelector('.needs-validation');
            if (formulario) {
                formulario.addEventListener('submit', function (evento) {
                    if (!this.checkValidity()) {
                        evento.preventDefault();
                        evento.stopPropagation();
                    }
                    this.classList.add('was-validated');
                }, false);
            }
        })();
    </script>
</body>
</html>

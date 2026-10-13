<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ejercicio 2 - Etiqueta c:set</title>

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
                <h1 class="titulo">Ejercicio 2: Etiqueta <code>c:set</code></h1>
                <p class="subtitulo">Los parametros se guardan en variables JSTL con <code>&lt;c:set&gt;</code> y se muestran con <code>&lt;c:out&gt;</code>.</p>
            </div>

            <!-- Formulario -->
            <div class="row justify-content-center">
                <div class="col-12 col-md-8 col-lg-6">

                    <form action="resultado2.jsp" method="post" class="tarjeta-formulario needs-validation" novalidate>

                        <!-- Nombre: atributo name -> se recibira como param.nombre -->
                        <div class="mb-3">
                            <label for="nombre" class="form-label">Nombre</label>
                            <input type="text" class="form-control" id="nombre" name="nombre" required>
                            <div class="invalid-feedback">Ingresa tu nombre.</div>
                        </div>

                        <!-- Primer apellido -->
                        <div class="mb-3">
                            <label for="apellido1" class="form-label">Primer apellido</label>
                            <input type="text" class="form-control" id="apellido1" name="apellido1" required>
                            <div class="invalid-feedback">Ingresa tu primer apellido.</div>
                        </div>

                        <!-- Segundo apellido: en el ejercicio 3 es opcional -->
                        <div class="mb-4">
                            <label for="apellido2" class="form-label">Segundo apellido</label>
                            <input type="text" class="form-control" id="apellido2" name="apellido2">
                            <div class="form-text">Este dato es opcional.</div>
                        </div>

                        <!-- Botones -->
                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-enviar flex-grow-1">
                                <i class="fas fa-floppy-disk me-1"></i> Guardar
                            </button>
                            <button type="reset" class="btn btn-outline-rosa">
                                <i class="fas fa-eraser me-1"></i> Limpiar
                            </button>
                        </div>

                    </form>

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

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ejercicio 8 - Etiquetas SQL</title>

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
                <h1 class="titulo">Ejercicio 8: Etiquetas SQL</h1>
                <p class="subtitulo">El registro se inserta con <code>&lt;sql:update&gt;</code> y a continuaci&oacute;n se listan todos los empleados con <code>&lt;sql:query&gt;</code>.</p>
            </div>

            <div class="row justify-content-center">
                <div class="col-12 col-md-8 col-lg-6">

                    <form action="resultado8.jsp" method="post" class="tarjeta-formulario needs-validation" novalidate>

                        <!-- Nombre: se envia a la columna "nombres" de la tabla empleados -->
                        <div class="mb-3">
                            <label for="nombre" class="form-label">Nombre <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="nombre" name="nombre" required>
                            <div class="invalid-feedback">Ingresa un nombre.</div>
                        </div>

                        <!-- Primer apellido -->
                        <div class="mb-3">
                            <label for="apellido1" class="form-label">Primer apellido <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="apellido1" name="apellido1" required>
                            <div class="invalid-feedback">Ingresa el primer apellido.</div>
                        </div>

                        <!-- Segundo apellido: la columna admite NULL, asi que es opcional -->
                        <div class="mb-3">
                            <label for="apellido2" class="form-label">Segundo apellido</label>
                            <input type="text" class="form-control" id="apellido2" name="apellido2">
                            <div class="form-text">Opcional: se guardara como NULL si lo dejas vacio.</div>
                        </div>

                        <!-- Edad -->
                        <div class="mb-4">
                            <label for="edad" class="form-label">Edad <span class="text-danger">*</span></label>
                            <input type="number" class="form-control" id="edad" name="edad" min="0" max="120" required>
                            <div class="invalid-feedback">Ingresa una edad valida.</div>
                        </div>

                        <!-- Botones -->
                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-enviar flex-grow-1">
                                <i class="fas fa-database me-1"></i> Guardar en MySQL
                            </button>
                            <button type="reset" class="btn btn-outline-rosa">
                                <i class="fas fa-eraser me-1"></i> Limpiar
                            </button>
                        </div>

                    </form>

                    <div class="tarjeta-formulario mt-4">
                        <p class="etiqueta mb-2">Base de datos</p>
                        <ul class="list-group list-group-flush lista-valores">
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                <span><i class="fas fa-server"></i> Servidor</span>
                                <span class="valor">localhost:3306</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                <span><i class="fas fa-database"></i> Esquema</span>
                                <span class="valor">empleados</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                <span><i class="fas fa-table"></i> Tabla</span>
                                <span class="valor">empleados</span>
                            </li>
                        </ul>
                        <p class="form-text mb-0 mt-3">
                            <i class="fas fa-circle-info me-1"></i>
                            El alta no se des-hace desde la pagina: cada envio anade una fila nueva.
                        </p>
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

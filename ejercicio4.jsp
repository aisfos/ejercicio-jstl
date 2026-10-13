<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ejercicio 4 - Etiqueta c:choose</title>

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
                <h1 class="titulo">Ejercicio 4: <code>c:choose</code></h1>
                <p class="subtitulo">Elige un tema y la pagina mostrara un mensaje distinto para cada opcion con <code>c:when</code> y <code>c:otherwise</code>.</p>
            </div>

            <!-- Formulario -->
            <div class="row justify-content-center">
                <div class="col-12 col-md-8 col-lg-6">

                    <form action="resultado4.jsp" method="post" class="tarjeta-formulario">

                        <!--
                            Desplegable con tres temas. La primera opcion tiene value=""
                            a proposito: es la que se envia si el usuario no elige nada,
                            y es la que dispara el &lt;c:otherwise&gt; del ejercicio.
                        -->
                        <div class="mb-4">
                            <label for="tema" class="form-label">Selecciona un tema</label>
                            <select class="form-select" id="tema" name="tema">
                                <option value="">-- Sin seleccion --</option>
                                <option value="lenguajes">Lenguajes de programacion</option>
                                <option value="mascotas">Mascotas</option>
                                <option value="deportes">Deportes</option>
                            </select>
                            <div class="form-text">La opcion vacia sirve para probar la rama <code>&lt;c:otherwise&gt;</code>.</div>
                        </div>

                        <!-- Campo libre para que la respuesta tenga algo personal -->
                        <div class="mb-4">
                            <label for="comentario" class="form-label">Comentario (opcional)</label>
                            <input type="text" class="form-control" id="comentario" name="comentario">
                        </div>

                        <!-- Botones -->
                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-enviar flex-grow-1">
                                <i class="fas fa-check me-1"></i> Enviar
                            </button>
                            <button type="reset" class="btn btn-outline-rosa">
                                <i class="fas fa-eraser me-1"></i> Limpiar
                            </button>
                        </div>

                    </form>

                    <p class="form-text text-center mt-3 mb-0">
                        <i class="fas fa-circle-info me-1"></i>
                        <code>c:choose</code> evalua sus <code>c:when</code> en orden y se detiene en el primero que sea verdadero.
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
</body>
</html>

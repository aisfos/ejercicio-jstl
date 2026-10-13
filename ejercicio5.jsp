<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ejercicio 5 - Etiqueta c:catch</title>

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
                <h1 class="titulo">Ejercicio 5: Etiqueta <code>c:catch</code></h1>
                <p class="subtitulo">El servidor intenta convertir el texto con <code>Integer.parseInt()</code>. Si el valor no es numerico, la excepcion se captura y se muestra como un mensaje.</p>
            </div>

            <div class="row justify-content-center">
                <div class="col-12 col-md-8 col-lg-6">

                    <!--
                        ---------- FORMULARIO PRINCIPAL ----------
                        El campo se deja como type="text" y no como type="number" a proposito:
                        el navegador debe permitir escribir letras para que la conversion
                        en el servidor sea la que falle y se pueda demostrar c:catch.
                    -->
                    <form action="resultado5.jsp" method="post" class="tarjeta-formulario mb-4">

                        <div class="mb-4">
                            <label for="numero" class="form-label">Numero a convertir</label>
                            <input type="text" class="form-control" id="numero" name="numero"
                                   placeholder="por ejemplo: 42" maxlength="20">
                            <div class="form-text">
                                Escribe cualquier texto. Si no es un entero, <code>Integer.parseInt()</code> lanza
                                <code>NumberFormatException</code> y <code>&lt;c:catch&gt;</code> la intercepta.
                            </div>
                        </div>

                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-enviar flex-grow-1">
                                <i class="fas fa-code me-1"></i> Convertir
                            </button>
                            <button type="reset" class="btn btn-outline-rosa">
                                <i class="fas fa-eraser me-1"></i> Limpiar
                            </button>
                        </div>

                    </form>

                    <!--
                        ---------- BOTONES DE PRUEBA ----------
                        Cada boton esta dentro de su propio formulario para poder decidir
                        de forma independiente si se envia el parametro "numero" o no:

                          1) formulario POST + <input hidden numero="42">  -> numero=42
                          2) formulario POST + <input hidden numero="abc"> -> numero=abc
                          3) formulario GET  sin ningun campo             -> no existe param.numero

                        Si los tres estuvieran en el mismo formulario, el campo de texto
                        se sumaria al parametro y el caso 3 no seria reproducible.
                    -->
                    <div class="tarjeta-formulario">
                        <p class="etiqueta">Botones de prueba</p>

                        <div class="d-grid gap-2">

                            <%-- 1) Valor numerico valido --%>
                            <form action="resultado5.jsp" method="post" class="m-0">
                                <input type="hidden" name="numero" value="42">
                                <button type="submit" class="btn btn-outline-rosa w-100">
                                    <i class="fas fa-circle-check me-1"></i> 1. Valor valido (numero=42)
                                </button>
                            </form>

                            <%-- 2) Texto no numerico: aqui Integer.parseInt() explota --%>
                            <form action="resultado5.jsp" method="post" class="m-0">
                                <input type="hidden" name="numero" value="no soy un numero">
                                <button type="submit" class="btn btn-outline-rosa w-100">
                                    <i class="fas fa-circle-xmark me-1"></i> 2. Texto no numerico (numero=no soy un numero)
                                </button>
                            </form>

                            <%-- 3) Sin enviar el parametro: GET vacio, param.numero llega como null --%>
                            <form action="resultado5.jsp" method="get" class="m-0">
                                <button type="submit" class="btn btn-outline-rosa w-100">
                                    <i class="fas fa-circle-minus me-1"></i> 3. Sin enviar el parametro
                                </button>
                            </form>

                        </div>
                    </div>

                    <p class="form-text text-center mt-3 mb-0">
                        <i class="fas fa-circle-info me-1"></i>
                        El boton n&uacute;mero 3 pide la pagina por GET sin campos, por eso <code>param.numero</code> llega en <code>null</code>.
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

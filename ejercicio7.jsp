<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ejercicio 7 - Etiqueta c:forTokens</title>

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
                <h1 class="titulo">Ejercicio 7: Etiqueta <code>c:forTokens</code></h1>
                <p class="subtitulo">Escribe una frase y el car&aacute;cter que la separa: la pagina la partir&aacute; en palabras.</p>
            </div>

            <!-- Formulario -->
            <div class="row justify-content-center">
                <div class="col-12 col-md-8 col-lg-6">

                    <form action="resultado7.jsp" method="post" class="tarjeta-formulario">

                        <!--
                            Texto a separar. Se escribe SIN el delimitador en un caso
                            y CON el delimitador en el otro a proposito: c:forTokens
                            parte el texto usando "delims" y descarta el separador, asi
                            que da igual si la coma viene o no, el resultado es el mismo.
                        -->
                        <div class="mb-3">
                            <label for="texto" class="form-label">Texto a separar</label>
                            <textarea class="form-control" id="texto" name="texto" rows="3"
                                      placeholder="manzana, pera, uva">manzana,pera,uva</textarea>
                            <div class="form-text">Por ejemplo: <code>manzana,pera,uva</code></div>
                        </div>

                        <!--
                            Caracter delimitador. Se pone la coma como valor por omision
                            para que el ejercicio funcione al instante sin teclear nada.
                        -->
                        <div class="mb-3">
                            <label for="delim" class="form-label">Car&aacute;cter delimitador</label>
                            <input type="text" class="form-control" id="delim" name="delim"
                                   value="," maxlength="1" size="1" required>
                            <div class="form-text">Un solo car&aacute;cter. Prueba tambi&eacute;n con <code>|</code>, <code>;</code> o un espacio.</div>
                        </div>

                        <!--
                            Casos prefabricados para probar la separacion con distintos
                            delimitadores sin teclear nada. Son type="button" y no submit:
                            un boton submit con name="texto" se sumaria al valor del
                            textarea y param.texto devolveria el primero de los dos.
                        -->
                        <div class="mb-4">
                            <p class="etiqueta mb-2">Ejemplos rapidos</p>
                            <div class="d-flex gap-2 flex-wrap">
                                <button type="button" class="btn btn-outline-rosa btn-sm btn-ejemplo"
                                        data-texto="manzana,pera,uva" data-delim=",">Comas</button>
                                <button type="button" class="btn btn-outline-rosa btn-sm btn-ejemplo"
                                        data-texto="rojo|verde|azul" data-delim="|">Barras</button>
                                <button type="button" class="btn btn-outline-rosa btn-sm btn-ejemplo"
                                        data-texto="uno;dos;tres;cuatro" data-delim=";">Punto y coma</button>
                                <button type="button" class="btn btn-outline-rosa btn-sm btn-ejemplo"
                                        data-texto="Juan Perez Lopez" data-delim=" ">Espacios</button>
                            </div>
                            <div class="form-text">
                                Rellenan los dos campos con el ejemplo y luego hay que pulsar <strong>Separar</strong>.
                            </div>
                        </div>

                        <!-- Botones -->
                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-enviar flex-grow-1">
                                <i class="fas fa-scissors me-1"></i> Separar
                            </button>
                            <button type="reset" class="btn btn-outline-rosa">
                                <i class="fas fa-eraser me-1"></i> Limpiar
                            </button>
                        </div>

                    </form>

                    <p class="form-text text-center mt-3 mb-0">
                        <i class="fas fa-circle-info me-1"></i>
                        Si el delimitador no aparece en el texto, <code>c:forTokens</code> devuelve una sola palabra.
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
        // Los botones de ejemplo rellenan el texto y el delimitador.
        // Se hacen con JavaScript aqui porque la separacion en si la hace
        // &lt;c:forTokens&gt; en el servidor, no este script.
        (function () {
            'use strict';
            var botones = document.querySelectorAll('.btn-ejemplo');
            var campoTexto = document.getElementById('texto');
            var campoDelim = document.getElementById('delim');
            for (var i = 0; i < botones.length; i++) {
                botones[i].addEventListener('click', function () {
                    campoTexto.value = this.getAttribute('data-texto');
                    campoDelim.value = this.getAttribute('data-delim');
                }, false);
            }
        })();
    </script>
</body>
</html>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Guía JSTL - Menú de Ejercicios</title>

<!-- Bootstrap 5.1.0 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css">
<!-- Font Awesome 5.15.4 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<!-- Hoja de estilos propia -->
<link rel="stylesheet" href="css/estilo.css">

<style>
  :root{
    --morado: #6b2d8c;
    --morado-oscuro: #52216c;
    --rosa-pastel: #f7d6e0;
    --rosa-borde: #e9a9c2;
    --blanco: #ffffff;
    --gris-claro: #f5f2f8;
  }
  body{
    background-color: var(--gris-claro);
    font-family: 'Segoe UI', sans-serif;
  }
  .encabezado{
    background-color: var(--morado);
    padding: 14px 30px;
  }
  .logo{
    color: #fff;
    font-weight: 700;
    font-size: 1.3rem;
    text-decoration: none;
  }
  .btn-inicio{
    border-color: #fff;
    color: #fff;
    border-radius: 6px;
  }
  .btn-inicio:hover{
    background-color: #fff;
    color: var(--morado);
  }
  .titulo-menu{
    color: var(--morado);
    font-weight: 800;
    text-align: center;
    margin-top: 40px;
  }
  .subtitulo-menu{
    text-align:center;
    color:#6b6b6b;
    margin-bottom: 40px;
  }
  .card-ejercicio{
    background: var(--blanco);
    border: 1px solid var(--rosa-borde);
    border-radius: 14px;
    padding: 24px;
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    transition: transform .15s ease, box-shadow .15s ease;
  }
  .card-ejercicio:hover{
    transform: translateY(-4px);
    box-shadow: 0 10px 20px rgba(107,45,140,0.12);
  }
  .numero-ejercicio{
    display:inline-block;
    background: var(--rosa-pastel);
    color: var(--morado);
    font-weight: 700;
    border-radius: 999px;
    width: 36px;
    height: 36px;
    line-height: 36px;
    text-align:center;
    margin-bottom: 12px;
  }
  .card-ejercicio h5{
    color: var(--morado-oscuro);
    font-weight: 700;
  }
  .card-ejercicio p{
    color: #666;
    font-size: 0.92rem;
    min-height: 42px;
  }
  .btn-ver{
    border: 1px solid var(--morado);
    color: var(--morado);
    border-radius: 8px;
    font-weight: 600;
  }
  .btn-ver:hover{
    background-color: var(--morado);
    color: #fff;
  }
  .pie{
    background-color: var(--morado);
    color: #fff;
    text-align: center;
    padding: 16px;
    margin-top: 60px;
  }
</style>
</head>
<body>

  <!-- ============ ENCABEZADO ============ -->
  <header class="encabezado d-flex align-items-center justify-content-between">
    <a href="index.jsp" class="logo"><i class="fas fa-code"></i> Guía JSTL</a>
    <a href="index.jsp" class="btn btn-outline-light btn-inicio btn-sm">Inicio</a>
  </header>

  <!-- ============ TÍTULO ============ -->
  <div class="container">
    <h1 class="titulo-menu">Ejercicios JSTL</h1>
    <p class="subtitulo-menu">Selecciona un ejercicio para ver su formulario, resultado y el código JSTL utilizado.</p>

    <!-- ============ GRID DE TARJETAS ============ -->
    <div class="row g-4 mb-5">

      <div class="col-12 col-md-6 col-lg-4">
        <div class="card-ejercicio">
          <div>
            <span class="numero-ejercicio">1</span>
            <h5>Etiqueta c:out</h5>
            <p>Suma tres valores numéricos y muestra el resultado con la etiqueta c:out.</p>
          </div>
          <a href="ejercicio1.jsp" class="btn btn-ver btn-sm">Ver ejercicio</a>
        </div>
      </div>

      <div class="col-12 col-md-6 col-lg-4">
        <div class="card-ejercicio">
          <div>
            <span class="numero-ejercicio">2</span>
            <h5>Etiqueta c:set</h5>
            <p>Guarda datos personales en variables JSTL y los imprime en pantalla.</p>
          </div>
          <a href="ejercicio2.jsp" class="btn btn-ver btn-sm">Ver ejercicio</a>
        </div>
      </div>

      <div class="col-12 col-md-6 col-lg-4">
        <div class="card-ejercicio">
          <div>
            <span class="numero-ejercicio">3</span>
            <h5>Condicional c:if</h5>
            <p>Valida campos obligatorios de un formulario usando la etiqueta c:if.</p>
          </div>
          <a href="ejercicio3.jsp" class="btn btn-ver btn-sm">Ver ejercicio</a>
        </div>
      </div>

      <div class="col-12 col-md-6 col-lg-4">
        <div class="card-ejercicio">
          <div>
            <span class="numero-ejercicio">4</span>
            <h5>c:choose / c:when / c:otherwise</h5>
            <p>Selecciona un tema y muestra un mensaje distinto según la opción elegida.</p>
          </div>
          <a href="ejercicio4.jsp" class="btn btn-ver btn-sm">Ver ejercicio</a>
        </div>
      </div>

      <div class="col-12 col-md-6 col-lg-4">
        <div class="card-ejercicio">
          <div>
            <span class="numero-ejercicio">5</span>
            <h5>Captura de excepciones c:catch</h5>
            <p>Captura errores de conversión numérica sin detener la ejecución de la página.</p>
          </div>
          <a href="ejercicio5.jsp" class="btn btn-ver btn-sm">Ver ejercicio</a>
        </div>
      </div>

      <div class="col-12 col-md-6 col-lg-4">
        <div class="card-ejercicio">
          <div>
            <span class="numero-ejercicio">6</span>
            <h5>c:forEach</h5>
            <p>Recorre un rango de números mostrando mensajes especiales en ciertas iteraciones.</p>
          </div>
          <a href="ejercicio6.jsp" class="btn btn-ver btn-sm">Ver ejercicio</a>
        </div>
      </div>

      <div class="col-12 col-md-6 col-lg-4">
        <div class="card-ejercicio">
          <div>
            <span class="numero-ejercicio">7</span>
            <h5>c:forTokens</h5>
            <p>Divide un texto en partes según un delimitador ingresado por el usuario.</p>
          </div>
          <a href="ejercicio7.jsp" class="btn btn-ver btn-sm">Ver ejercicio</a>
        </div>
      </div>

      <div class="col-12 col-md-6 col-lg-4">
        <div class="card-ejercicio">
          <div>
            <span class="numero-ejercicio">8</span>
            <h5>Conexión SQL</h5>
            <p>Inserta y consulta registros de una base de datos MySQL usando sql:query y sql:update.</p>
          </div>
          <a href="ejercicio8.jsp" class="btn btn-ver btn-sm">Ver ejercicio</a>
        </div>
      </div>

    </div>
  </div>

  <!-- ============ PIE DE PÁGINA ============ -->
  <footer class="pie">
    <p class="mb-0">&copy; 2026 | Todos los derechos reservados</p>
  </footer>

</body>
</html>

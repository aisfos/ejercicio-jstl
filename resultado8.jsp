<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%--
    Etiquetas SQL de JSTL. El prefijo "sql" se declara en esta misma pagina,
    ANTES de la primera etiqueta sql: no hay archivos .jspf ni inclusiones.
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<%--
    CONEXION A MYSQL - declarada dentro de la propia pagina.

    <sql:setDataSource var="bd" driver="..." url="..." user="..." password=""/>
    Crea el DataSource y lo guarda en la variable "bd" del ambito de pagina,
    sin registrar ningun recurso en la configuracion del servidor. Por eso
    cada <sql:query> y <sql:update> tiene que indicar explicitamente de donde
    leer la conexion:
        dataSource="${bd}"
--%>
<sql:setDataSource var="bd"
    driver="com.mysql.cj.jdbc.Driver"
    url="jdbc:mysql://localhost:3306/empleados?useSSL=false&serverTimezone=UTC"
    user="root"
    password="" />

<%--
    EJERCICIO 8 - Etiquetas SQL
    ===========================================================================
    SETUP DE LA BASE DE DATOS (ejecutar una sola vez en phpMyAdmin o en consola):
        CREATE DATABASE empleados;
        USE empleados;
        CREATE TABLE empleados (
            id        INT AUTO_INCREMENT PRIMARY KEY,
            nombres   VARCHAR(100) NOT NULL,
            apellido1 VARCHAR(100) NOT NULL,
            apellido2 VARCHAR(100),
            edad      INT
        );
    (La columna del nombre se llama "nombres" en plural porque asi quedo creada
     en la base de datos de la gu&iacute;a. Si prefieres "nombre", ejecuta
     ALTER TABLE empleados CHANGE nombres nombre VARCHAR(100) NOT NULL;
     y ajusta los nombres en las dos consultas de esta pagina.)

    sql:update  -> ejecuta INSERT, UPDATE o DELETE. var = filas afectadas.
    sql:param   -> asigna un valor a un marcador "?" de la consulta.
                   Enviando los datos como parametros y no como texto pegado en
                   el INSERT, la base de datos los trata como DATOS y no como
                   SQL. Asi un apellido con comillas o con palabra reservada
                   "DROP TABLE" no puede romper la consulta.
    sql:query   -> ejecuta un SELECT. var = una estructura Result con:
                       .rows      -> lista de filas (cada fila, un objeto)
                       .rowCount  -> numero de filas devueltas
                       .rowsByIndex / .rowsById -> acceso individual a una fila
    ---------------------------------------------------------------------------
    Todo el bloque SQL va envuelto en <c:catch> por el mismo motivo que en el
    ejercicio 5: si MySQL esta apagado, el usuario ve un mensaje claro en lugar
    de una pagina de error 500 del contenedor.
--%>

<%-- 1) Datos del formulario: se validan antes de tocar la base de datos --%>
<c:set var="nombre" value="${param.nombre}"/>
<c:set var="apellido1" value="${param.apellido1}"/>
<c:set var="apellido2" value="${param.apellido2}"/>
<c:set var="edad" value="${param.edad}"/>

<%--
    fn:trim recorta los espacios sobrantes. La etiqueta &lt;c:set&gt; NO acepta
    el atributo "trim", asi que la limpieza se hace con la funcion fn:trim
    de la libreria de funciones de JSTL:
        fn:trim(texto) -> el mismo texto sin espacios al inicio ni al final.
--%>
<c:set var="nombreLimpio" value="${fn:trim(nombre)}"/>
<c:set var="apellido1Limpio" value="${fn:trim(apellido1)}"/>
<c:set var="apellido2Limpio" value="${fn:trim(apellido2)}"/>

<c:set var="datosCompletos" value="${not empty nombreLimpio and not empty apellido1Limpio}"/>
<c:set var="edadValida" value="${not empty edad}"/>

<%-- 2) Variables donde se guardaran los resultados de las etiquetas sql --%>
<c:set var="filasInsertadas" value="0"/>
<c:set var="consulta" value="0"/>
<c:set var="errorBD" value=""/>

<%--
    3) ALTA en la tabla. Solo se intenta si los datos obligatorios llegaron bien.
       dataSource="${bd}" indica que conexion usa; sin ese atributo la etiqueta
       intentaria pedirle una al contenedor y fallaria con un NullPointerException.
       <sql:update var="filasInsertadas" dataSource="${bd}"> guarda en la
       variable el numero de filas afectadas, que debe ser 1 en un INSERT
       correcto.
--%>
<c:if test="${datosCompletos and edadValida}">
    <c:catch var="errorBD">
        <sql:update var="filasInsertadas" dataSource="${bd}">
            INSERT INTO empleados (nombres, apellido1, apellido2, edad)
            VALUES (?, ?, ?, ?)
            <%-- Los "?" de arriba se rellenan en este mismo orden con sql:param --%>
            <sql:param value="${nombreLimpio}"/>
            <sql:param value="${apellido1Limpio}"/>
            <%--
                Un <c:choose> para el segundo apellido: la columna admite NULL,
                asi que si no se escribio nada se manda el valor nulo.
                En MySQL, NULL debe escribirse sin comillas, y <sql:param>
                cumple esa regla cuando el value es "${null}".
            --%>
            <c:choose>
                <c:when test="${empty apellido2Limpio}">
                    <sql:param value="${null}"/>
                </c:when>
                <c:otherwise>
                    <sql:param value="${apellido2Limpio}"/>
                </c:otherwise>
            </c:choose>
            <sql:param value="${edad}"/>
        </sql:update>
        <c:set var="consulta" value="1"/>
    </c:catch>
</c:if>

<%--
    4) CONSULTA de todos los registros.
       dataSource="${bd}" es el mismo atributo que en sql:update: le dice a la
       etiqueta que use el DataSource declarado arriba con sql:setDataSource.
       sql:query guarda en "listaEmpleados" un ResultSet completo. El ORDER BY
       por id mantiene el orden en que se fueron insertando los empleados.
--%>
<c:if test="${empty errorBD}">
    <c:catch var="errorBD">
        <sql:query var="listaEmpleados" dataSource="${bd}">
            SELECT id, nombres, apellido1, apellido2, edad
            FROM empleados
            ORDER BY id
        </sql:query>
    </c:catch>
</c:if>

<%--
    5) Recorrido del ResultSet con c:forEach.
       items="${listaEmpleados.rows}"  -> la lista de filas
       var="fila"                       -> cada fila es un objeto con las columnas
       <c:out value="${fila.nombres}"/> -> se accede a una columna por su nombre
    Ademas se acumula la suma de las edades para mostrar la media al final.
--%>
<c:set var="sumaEdades" value="0"/>
<c:set var="totalRegistros" value="0"/>
<c:forEach items="${listaEmpleados.rows}" var="fila">
    <c:set var="totalRegistros" value="${totalRegistros + 1}"/>
    <c:set var="sumaEdades" value="${sumaEdades + fila.edad}"/>
</c:forEach>

<%-- Media de edad. Si no hay filas, la division daria cero y se muestra "sin datos" --%>
<c:set var="edadMedia" value="${totalRegistros > 0 ? sumaEdades / totalRegistros : 0}"/>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ejercicio 8 - Resultado</title>

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
                <div class="col-12 col-lg-10">

                    <!-- ================= AVISO DE ERROR ================= -->
                    <%-- La base de datos no respondio: se explica sin mostrar un error 500 --%>
                    <c:if test="${not empty errorBD}">
                        <div class="alert alert-danger alerta-error d-flex align-items-start" role="alert">
                            <i class="fas fa-database me-2 mt-1"></i>
                            <div>
                                <strong class="d-block">No se pudo comunicar con MySQL</strong>
                                <span><c:out value="${errorBD.message}"/></span>
                                <span class="d-block mt-1">
                                    Revisa que el servicio este encendido y que los datos de
                                    <code>&lt;sql:setDataSource&gt;</code> de esta pagina
                                    (driver, url, user y password) sean correctos.
                                </span>
                            </div>
                        </div>
                    </c:if>

                    <%-- Faltaron datos obligatorios: no se intento el INSERT --%>
                    <c:if test="${not datosCompletos or not edadValida}">
                        <div class="alert alert-danger alerta-error d-flex align-items-start" role="alert">
                            <i class="fas fa-circle-exclamation me-2 mt-1"></i>
                            <div>
                                <strong class="d-block">No se guardo nada</strong>
                                <span>
                                    <c:choose>
                                        <c:when test="${empty nombreLimpio}">Falta el nombre. </c:when>
                                        <c:when test="${empty apellido1Limpio}">Falta el primer apellido. </c:when>
                                        <c:when test="${not edadValida}">Falta la edad. </c:when>
                                    </c:choose>
                                    Esos campos son obligatorios en la tabla.
                                </span>
                            </div>
                        </div>
                    </c:if>

                    <!-- ================= TARJETA DE RESULTADO ================= -->
                    <div class="tarjeta-resultado">

                        <!-- Encabezado de la tarjeta -->
                        <div class="tarjeta-resultado__header text-center">
                            <i class="fas fa-database"></i>
                            <h2 class="h4 mb-0">Empleados registrados</h2>
                        </div>

                        <!-- Cuerpo de la tarjeta -->
                        <div class="tarjeta-resultado__cuerpo">

                            <!-- ---------- Resultado del INSERT ---------- -->
                            <c:if test="${consulta == 1}">
                                <div class="total text-center mb-4">
                                    <span class="total__operacion">
                                        <i class="fas fa-check me-1"></i>
                                        <code>&lt;sql:update&gt;</code> inserto
                                        <c:out value="${filasInsertadas}"/> fila(s)
                                    </span>
                                    <span class="total__valor" style="font-size: 1.5rem;">
                                        <c:out value="${filasInsertadas}"/> registro guardado
                                    </span>
                                </div>
                            </c:if>

                            <!--
                                ---------- TABLA CON TODOS LOS REGISTROS ----------
                                Si no hay filas, &lt;c:forEach&gt; no ejecuta su cuerpo ni una sola
                                vez y la tabla queda con la cabecera y el mensaje de vacio.
                            -->
                            <p class="etiqueta">Tabla <code>empleados</code> (<code>&lt;sql:query&gt;</code> + <code>&lt;c:forEach&gt;</code>)</p>

                            <div class="table-responsive">
                                <table class="table tabla-datos align-middle mb-0">
                                    <thead>
                                        <tr>
                                            <th scope="col">#</th>
                                            <th scope="col">Nombres</th>
                                            <th scope="col">Apellido 1</th>
                                            <th scope="col">Apellido 2</th>
                                            <th scope="col" class="text-center">Edad</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%--
                                            ---- RECORRIDO DEL RESULTSET ----
                                            Una vuelta por cada fila devuelta por el SELECT.
                                        --%>
                                        <c:forEach items="${listaEmpleados.rows}" var="fila" varStatus="status">
                                            <tr>
                                                <%-- status.count empieza en 1: se usa como numero de fila --%>
                                                <th scope="row"><c:out value="${status.count}"/></th>
                                                <td><c:out value="${fila.nombres}"/></td>
                                                <td><c:out value="${fila.apellido1}"/></td>
                                                <%--
                                                    La columna admite NULL, asi que puede venir
                                                    vacia: se comprueba antes de imprimir.
                                                --%>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${empty fila.apellido2}">
                                                            <span class="texto-vacio">sin segundo apellido</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:out value="${fila.apellido2}"/>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <%--
                                                    fmt:formatNumber da formato local a la edad
                                                    (separador de miles y decimales). maxFractionDigits
                                                    deja la edad como un numero entero limpio.
                                                --%>
                                                <td class="text-center">
                                                    <c:choose>
                                                        <c:when test="${empty fila.edad}">
                                                            <span class="texto-vacio">-</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <fmt:formatNumber value="${fila.edad}" type="number" maxFractionDigits="0"/>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>

                                        <%-- Mensaje cuando la consulta no devolvio ninguna fila --%>
                                        <c:if test="${empty listaEmpleados.rows}">
                                            <tr>
                                                <td colspan="5" class="text-center texto-vacio py-4">
                                                    Todav&iacute;a no hay ningun empleado en la base de datos.
                                                </td>
                                            </tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>

                            <!-- ---------- Resumen con datos de MySQL y con fmt ---------- -->
                            <p class="etiqueta mt-4">Resumen</p>

                            <div class="row g-3">
                                <div class="col-12 col-md-4">
                                    <div class="total text-center h-100">
                                        <span class="total__operacion">
                                            <c:choose>
                                                <c:when test="${not empty listaEmpleados}">
                                                    <c:out value="${listaEmpleados.rowCount}"/>
                                                </c:when>
                                                <c:otherwise>0</c:otherwise>
                                            </c:choose>
                                            filas (rowCount)
                                        </span>
                                        <span class="total__valor" style="font-size: 1.75rem;">
                                            <c:out value="${totalRegistros}"/>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-12 col-md-4">
                                    <div class="total text-center h-100">
                                        <span class="total__operacion">Edad media</span>
                                        <span class="total__valor" style="font-size: 1.75rem;">
                                            <c:choose>
                                                <c:when test="${totalRegistros > 0}">
                                                    <fmt:formatNumber value="${edadMedia}" type="number" maxFractionDigits="2"/>
                                                </c:when>
                                                <c:otherwise>-</c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-12 col-md-4">
                                    <div class="total text-center h-100">
                                        <span class="total__operacion">Suma de edades</span>
                                        <span class="total__valor" style="font-size: 1.75rem;">
                                            <c:choose>
                                                <c:when test="${totalRegistros > 0}">
                                                    <fmt:formatNumber value="${sumaEdades}" type="number"/>
                                                </c:when>
                                                <c:otherwise>-</c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                </div>
                            </div>

                            <p class="form-text mt-3 mb-0 text-center">
                                <c:out value="${totalRegistros}"/> iteraciones de <code>&lt;c:forEach&gt;</code> sobre
                                <code>listaEmpleados.rows</code>.
                            </p>

                            <!-- Accion para volver al formulario -->
                            <div class="text-center mt-4 d-flex gap-2 justify-content-center flex-wrap">
                                <a href="ejercicio8.jsp" class="btn btn-outline-rosa">
                                    <i class="fas fa-arrow-left me-1"></i> Anadir otro empleado
                                </a>
                                <a href="resultado8.jsp" class="btn btn-outline-rosa">
                                    <i class="fas fa-table-list me-1"></i> Solo listar
                                </a>
                            </div>

                        </div>
                    </div>

                    <!-- ============ CODIGO JSTL UTILIZADO ============ -->
                    <div class="tarjeta-codigo mt-4">
                        <div class="tarjeta-codigo__header">
                            <i class="fas fa-code"></i> C&oacute;digo JSTL utilizado
                        </div>
                        <pre class="bloque-codigo"><code>&lt;sql:setDataSource var="bd"
    driver="com.mysql.cj.jdbc.Driver"
    url="jdbc:mysql://localhost:3306/empleados?useSSL=false&amp;serverTimezone=UTC"
    user="root"
    password=""/&gt;

&lt;sql:update var="filasInsertadas" dataSource="\${bd}"&gt;
    INSERT INTO empleados (nombres, apellido1, apellido2, edad)
    VALUES (?, ?, ?, ?)
    &lt;sql:param value="\${nombreLimpio}"/&gt;
    &lt;sql:param value="\${apellido1Limpio}"/&gt;
    &lt;c:choose&gt;
        &lt;c:when test="\${empty apellido2Limpio}"&gt;
            &lt;sql:param value="\${null}"/&gt;
        &lt;/c:when&gt;
        &lt;c:otherwise&gt;
            &lt;sql:param value="\${apellido2Limpio}"/&gt;
        &lt;/c:otherwise&gt;
    &lt;/c:choose&gt;
    &lt;sql:param value="\${edad}"/&gt;
&lt;/sql:update&gt;

&lt;sql:query var="listaEmpleados" dataSource="\${bd}"&gt;
    SELECT id, nombres, apellido1, apellido2, edad
    FROM empleados
    ORDER BY id
&lt;/sql:query&gt;

&lt;c:forEach items="\${listaEmpleados.rows}" var="fila" varStatus="status"&gt;
    &lt;c:out value="\${fila.nombres}"/&gt;
    &lt;c:out value="\${fila.apellido1}"/&gt;
    &lt;c:out value="\${fila.apellido2}"/&gt;
    &lt;c:out value="\${fila.edad}"/&gt;
&lt;/c:forEach&gt;</code></pre>
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

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Nosotros</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" 
    rel="stylesheet" 
    integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" 
    crossorigin="anonymous">
    <link rel="stylesheet" href="Encabezado.css">
    <link rel="stylesheet" href="Style-body.css">
    <link rel="stylesheet" href="Nosotros.css">
    <link rel="stylesheet" href="Footer.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
    <header class="encabezado">
        <div class="logoET">
            <a href="index.jsp">
                <img href="Productos.jsp" src="SRC/Logo.png" alt="Logo Empresa">
            </a>
        </div>
        <nav>
            <ul class="nav_links">
                <li><a href="Index.jsp">Inicio</a></li>
                <li><a href="Servicios.jsp">Servicios</a></li>
                <li><a href="Nosotros.jsp">Nosotros</a></li>
                <li><a href="CheckDay.jsp">Marcar Asistencia</a></li>
            </ul>
        </nav>
        <a href="login.jsp" class="boton_ingresar_registrarse"><button>Iniciar Sesión</button></a>
        <a onclick="openNav()" href="#" class="boton-menu"><button>Menu</button></a>
        
        <div class="overlay" id="mobile-menu">
            <a onclick="closeNav()" href="#" class="close">&times;</a>
            <div class="overlay-content">
                <a href="Index.jsp">Inicio</a>
                <a href="Servicios.jsp">Servicios</a>
                <a href="Nosotros.jsp">Nosotros</a>

                <div class="boton-nosotros">
                    <a href="PHP/index.php"><button>Iniciar SesiÃ³n</button></a>
                </div>
            </div>
        </div>

    </header>
    <!-- <div class="banner-carrusel">
        <img src="/SRC/Banner1.png" class="img-banner">
    </div> -->
    
    <div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-inner">
        <div class="carousel-item active">
            <img src="SRC/CalendarioOficial.png" class="d-block w-100" alt="..">
        </div>
        <div class="carousel-item">
            <img src="SRC/CalendarioOficial2.png" class="d-block w-100" alt="..">
        </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
        </button>
    </div>

    </header>
    <section>
        <div class="nosotros">
            <h2>ASISTENCIA Y PAGOS</h2>
            <p>La asistencia puntual y regular al trabajo es fundamental para el buen funcionamiento de nuestra empresa. 
                Valoramos profundamente la dedicaciÃ³n y el compromiso de nuestros empleados, ya que su presencia constante y puntual no solo contribuye al desarrollo eficiente de nuestras operaciones, sino que tambiÃ©n fortalece el espÃ­ritu de equipo y la cohesiÃ³n en nuestro lugar de trabajo. 
                Entendemos que las ausencias son a veces inevitables debido a circunstancias imprevistas, pero es esencial mantener una comunicaciÃ³n abierta y transparente en caso de ausencia programada o inesperada.
                AdemÃ¡s, para mantener la equidad y la consistencia en nuestras polÃ­ticas, aplicamos descuentos por inasistencias no justificadas. 
                Este proceso se lleva a cabo con total transparencia y se aplica de manera justa a todos los empleados, incentivando asÃ­ la responsabilidad individual y promoviendo un ambiente laboral en el que cada miembro del equipo cumple con sus compromisos laborales.
                Agradecemos la colaboraciÃ³n de todos nuestros empleados y confiamos en que juntos podemos mantener un entorno de trabajo productivo y armonioso.</p>
        </div>
        <div class="mv_nosotros">
            <div class="mision">
                <h2>DESCUENTOS</h2>
                <p>Para garantizar la equidad y la consistencia en nuestras polÃ­ticas de asistencia, hemos establecido un sistema de descuento por inasistencias no justificadas. 
                En caso de ausencia no programada o sin justificaciÃ³n vÃ¡lida, se aplicarÃ¡ un descuento del 2% al salario del empleado por cada dÃ­a de inasistencia.
                Esta medida se toma para incentivar la puntualidad y la presencia constante, lo que contribuye significativamente a nuestro Ã©xito colectivo. 
                Apreciamos la comprensiÃ³n y la colaboraciÃ³n de todos nuestros empleados en este esfuerzo por mantener un ambiente laboral productivo y positivo para todos.</p>
            </div>
            <div class="vision">
                <h2>MÃTODOS DE PAGO</h2>
                <p>En nuestra empresa, nos esforzamos por garantizar un proceso de pago preciso y puntual para todos nuestros empleados. 
                Sin embargo, en casos excepcionales, como retrasos bancarios o problemas tÃ©cnicos imprevistos, puede ocurrir un retraso de un dÃ­a en el procesamiento de los pagos. 
                Es importante tener en cuenta que estos retrasos pueden depender del banco emisor de la tarjeta a la que se realizarÃ¡ el depÃ³sito.
                Nos comprometemos a hacer todo lo posible para minimizar cualquier inconveniente y garantizar que todos los pagos pendientes se realicen tan pronto como sea posible.</p>
            </div>
        </div>
    </section>
    <footer>
        <div class="footer">

             <ul class="list">
                <li>
                    <a href="Index.jsp">Inicio</a>
                </li>
                <li>
                    <a href="Servicios.jsp">Servicios</a>
                </li>
                <li>
                    <a href="Nosotros.jsp">Nosotros</a>
                </li>
               </li>
             </ul>
             <p class="copyright">
                Plataforma de empleado Â© 2023 | Hecho por Polo y ZuÃ±iga
             </p>
        </div>
    </footer>
    <script type="text/javascript" src="JS/Slide.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</body>
</html>
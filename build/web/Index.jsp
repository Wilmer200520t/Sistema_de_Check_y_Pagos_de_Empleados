

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>TESLA S.A.C.</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" 
    rel="stylesheet" 
    integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" 
    crossorigin="anonymous">
    <link rel="stylesheet" href="Encabezado.css">
    <link rel="stylesheet" href="Style-body.css">
    <link rel="stylesheet" href="Footer.css">
    <link rel="stylesheet" 
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    </head>
    <body>
    <header class="encabezado">
        <div class="logoET">
            <a href="index.jsp">
                <img href="index.jsp" src="SRC/Logo.png" alt="Logo Empresa">
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
        <a onclick="openNav()" href="#" class="boton-menu"><button>Menú</button></a>
        
        <div class="overlay" id="mobile-menu">
            <a onclick="closeNav()" href="#" class="close">&times;</a>
            <div class="overlay-content">
                <a href="Index.jsp">Inicio</a>
                <a href="Servicios.jsp">Servicios</a>
                <a href="Nosotros.jsp">Nosotros</a>

                <div class="boton-nosotros">
                    <a href="PHP/index.php"><button>Iniciar Sesión</button></a>
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
            <img src="SRC/Banner1.png" class="d-block w-100" alt="..">
        </div>
        <div class="carousel-item">
            <img src="SRC/Banner2.png" class="d-block w-100" alt="...">
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

    <section class="Nosotros-index">
        <div class="descripcionNosotros-index">
            <h2>TESLA S.A.C</h2>
            <span class="line-titulo"></span>
            <p>
                Nos complace darte la bienvenida a nuestro Portal del Empleado, tu plataforma personalizada para acceder a información relevante y recursos útiles. 
                Aquí encontrarás todo lo que necesitas para hacer tu experiencia laboral con nosotros más efectiva y gratificante.
                <br></br>
                Creemos en el constante cambio que afrontan las empresas, por lo que tratamos de desarrollar nuevas 
                herramientas que los ayuden en su labor del día a día.
            </p>
            <div class="boton-nosotros">
                <a href="Nosotros.jsp"><button>Más información</button></a>
            </div>
        </div>
        <div class="img-empresa">
            <img class="Cirugía" src="SRC/Ideas.png">
        </div>
        
    </section>
    <section class="Areas-index">
        <h2>ÁREA DE LA EMPRESA</h2>
        <div class="descripcionAreas-index">
            <!--Area 1-->   
            <div class="card">
                <div class="head">
                    <div class="circle"></div>
                    <div class="img">
                        <img src="SRC/RecursosH.png" alt="">
                    </div>
                </div>
                
                <div class="descripcion">
                    <h3>RECURSOS HUMANOS</h3>
                    <h4>Área base 1</h4>
                    <p>Nuestra área de Recursos Humanos en la empresa cumple un rol esencial en la administración de nuestro 
                    talento humano y el desarrollo 
                    de nuestra organización.</p>
                </div>
            </div>
            <!--Area 2-->
            <div class="card">
                <div class="head">
                    <div class="circle-2"></div>
                    <div class="img">
                        <img src="SRC/Administracion.png" alt="">
                    </div>
                </div>

                <div class="descripcion">
                    <h3>ADMINISTRACIÓN</h3>
                    <h4>Área base 2</h4>
                    <p>Nuestro equipo de Administración desempeña un papel crucial en el éxito de nuestra empresa, 
                    encargándose de una serie de responsabilidades clave que aseguran el funcionamiento eficiente y efectivo de todas las operaciones.
                    Nos dedicamos a la planificación estratégica, supervisión y coordinación de los recursos y procesos empresariales.</p>
                </div>
            </div>
            <!--Area 3-->
            <div class="card">
                <div class="head">
                    <div class="circle"></div>
                    <div class="img">
                        <img src="SRC/Calidad.png" alt="">
                    </div>
                </div>

                <div class="descripcion">
                    <h3>CALIDAD</h3>
                    <h4>Área base 3</h4>
                    <p>Nuestra dedicada área de Calidad se enfoca en garantizar que nuestros productos y servicios cumplan con los más altos estándares,
                    superando las expectativas de nuestros clientes en cada interacción.
                    Nos encargamos de supervisar y mejorar continuamente todos los aspectos de nuestra operación, desde la producción hasta la entrega.</p>
                </div>
            </div>
        </div>
        <div class="boton-vm-especialistas">
            <a href="Servicios.jsp"><button>Ver más</button></a>
        </div>
    </section>

    <section class="section-servicios-vp">
        <h1>NUESTRAS ESPECIALIDADES</h1>
        <div class="container-serv">
            <div class="hexagon">
                <div class="shape">
                    <img src="SRC/Java.png" alt="">
                </div>
            </div>
            <div class="hexagon">
                <div class="shape">
                    <img src="SRC/Python2.png" alt="">
                </div>
            </div>
            <div class="hexagon">
                <div class="shape">
                    <img src="SRC/Cs.png" alt="">
                </div>
            </div>
            <div class="hexagon">
                <div class="shape">
                    <img src="SRC/Kotlin2.png" alt="">
                </div>
            </div>
            <div class="hexagon">
                <div class="shape">
                    <img src="SRC/Html.png" alt="">
                </div>
            </div>
            <div class="hexagon">
                <div class="shape">
                    <img src="SRC/Php1.png" alt="">
                </div>
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
                Plataforma de empleado © 2023 | Hecho por Polo y Zuñiga
             </p>
        </div>
    </footer>

    <script type="text/javascript" src="/JS/Slide.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</body>
</html>

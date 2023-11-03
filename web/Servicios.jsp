<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Servicios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" 
    rel="stylesheet" 
    integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" 
    crossorigin="anonymous">
    <link rel="stylesheet" href="Encabezado.css">
    <link rel="stylesheet" href="Style-body.css">
    <link rel="stylesheet" href="Servicios.css">
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
        <a href="login.jsp" class="boton_ingresar_registrarse"><button>Iniciar Sesion</button></a>
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
    <section class="Especialistas-index">
        <br>
        <h1>INFORMACION DE LA EMPRESA</h1>
        <div class="descripcionEspecialistas-index">
            <!--Sede 1-->
            <div class="card">
                <div class="head">
                    <div class="circle"></div>
                    <div class="img">
                        <img src="SRC/SedePrincipal.png" alt="">
                    </div>
                </div>

                <div class="descripcion">
                    <h3>SEDE PRINCIPAL</h3>
                    <h4>Sede 1</h4>
                    <p> Direccion: Av. Principal 123, Distrito de Miraflores, Lima, Peru
                        Telefono: +51 1 234 5678
                        Horario de Atencion: Lunes a Viernes: 9:00 AM - 6:00 PM</p>
                </div>
            </div>
            <!--Sede 2-->
            <div class="card">
                <div class="head">
                    <div class="circle-2"></div>
                    <div class="img">
                        <img src="SRC/SedeA.png" alt="">
                    </div>
                </div>

                <div class="descripcion">
                    <h3>SUCURSAL A</h3>
                    <h4>Sede 2</h4>
                    <p>Direccion: Jr. Comercio 456, Distrito de San Isidro, Lima, Peru 
                    Telefono: +51 1 234 6789 
                    Horario de Atencion: Lunes a Viernes: 9:30 AM - 7:00 PM, Sabados: 10:00 AM - 2:00 PM</p>
                </div>
            </div>
            <!--Veterinaria 3-->
            <div class="card">
                <div class="head">
                    <div class="circle"></div>
                    <div class="img">
                        <img src="SRC/SedeB.png" alt="">
                    </div>
                </div>

                <div class="descripcion">
                    <h3>SUCURSAL B</h3>
                    <h4>Sede 3</h4>
                    <p>Direccion: Av. Lima 789, Distrito de Surco, Lima, Peru 
                    Telefono: +51 1 234 7890
                    Horario de Atencion: Lunes a Sabado: 10:00 AM - 8:00 PM, Domingos: 11:00 AM - 4:00 PM</p>
                </div>
            </div>
            <div class="card">
                <div class="head">
                    <div class="circle-2"></div>
                    <div class="img">
                        <img src="SRC/Legal.png" alt="">
                    </div>
                </div>

                <div class="descripcion">
                    <h3>INFORMACION LEGAL</h3>
                    <h4>Datos esenciales</h4>
                    <p>Registro Unico de Contribuyentes (RUC): 12345678901
                    Registro Mercantil: N/A (Registro publico disponible en la Superintendencia Nacional de los Registros Publicos - SUNARP) 
                    Fecha de ConstituciÃ³n: 15 de Marzo de 2010
                    Tipo de Empresa: Sociedad Anonima Cerrada (S.A.C.)</p>
                </div>
            </div>
            <div class="card">
                <div class="head">
                    <div class="circle"></div>
                    <div class="img">
                        <img src="SRC/Empresa.png" alt="">
                    </div>
                </div>

                <div class="descripcion">
                    <h3>SOBRE NOSOTROS</h3>
                    <h4>Empresa</h4>
                    <p>Nos dedicamos a ofrecer soluciones innovadoras en tecnologÃ­a para empresas en toda Lima y sus alrededores. 
                        Desde nuestra fundaciÃ³n en 2010, nos hemos comprometido a proporcionar servicios de alta calidad, productos tecnolÃ³gicos de vanguardia y un excelente servicio al cliente.
                        Estamos orgullosos de ser lÃ­deres en el mercado de soluciones tecnolÃ³gicas en Lima, ayudando a las empresas a prosperar en la era digital.</p>
                </div>
            </div>
            <div class="card">
                <div class="head">
                    <div class="circle-2"></div>
                    <div class="img">
                        <img src="SRC/RRHH.png" alt="">
                    </div>
                </div>

                <div class="descripcion">
                    <h3>CONTACTO DE RRHH</h3>
                    <h4>Recursos humanos (datos)</h4>
                    <p>Nombre del Encargado de Recursos Humanos: Grecia Mendoza 
                    Correo electrÃ³nico de Recursos Humanos: rrhh@teslasolutions.pe
                    TelÃ©fono de Recursos Humanos: +51 1 234 5679</p>
                </div>
            </div>
        </div>
    </section>
    <section class="section-servicios-vp">
        <h1>TU PERFIL</h1>
        <div class="container-serv">
            <div class="hexagon">
                <div class="shape">
                    <img src="SRC/Perfil.png" alt="">
                    <div class="content">
                        <div>
                            <h2>NOMBRE COMPLETO</h2>
                            <p>X</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="hexagon">
                <div class="shape">
                    <img src="SRC/Codigo.png" alt="">
                    <div class="content">
                        <div>
                            <h2>CODIGO</h2>
                            <p>X</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="hexagon">
                <div class="shape">
                    <img src="SRC/CumpleaÃ±os.png" alt="">
                    <div class="content">
                        <div>
                            <h2>FECHA DE CUMPLEAÃOS</h2>
                            <p>X</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="hexagon">
                <div class="shape">
                    <img src="SRC/DNI.png" alt="">
                    <div class="content">
                        <div>
                            <h2>DNI</h2>
                            <p>X</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="hexagon">
                <div class="shape">
                    <img src="SRC/FechaIngreso.png" alt="">
                    <div class="content">
                        <div>
                            <h2>FECHA DE INGRESO</h2>
                            <p>X</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="hexagon">
                <div class="shape">
                    <img src="SRC/Banco.png" alt="">
                    <div class="content">
                        <div>
                            <h2>BANCO INDEXADO</h2>
                            <p>X</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="hexagon">
                <div class="shape">
                    <img src="SRC/Horario.png" alt="">
                    <div class="content">
                        <div>
                            <h2>HORARIO LABORAL</h2>
                            <p>X</p>
                        </div>
                    </div>
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
                Plataforma de empleado Â© 2023 | Hecho por Polo y ZuÃ±iga
             </p>
        </div>
    </footer>
    <script type="text/javascript" src="JS/Slide.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</body>
</html>
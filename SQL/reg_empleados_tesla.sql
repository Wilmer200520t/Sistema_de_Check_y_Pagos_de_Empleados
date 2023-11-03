-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3345
-- Tiempo de generación: 03-11-2023 a las 18:29:50
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `reg_empleados_tesla`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `fun_llenar_pagos` (IN `h_nor` FLOAT, IN `h_satu` FLOAT, IN `h_sun` FLOAT, IN `h_holi` FLOAT, IN `h_miss` FLOAT, IN `h_recover` FLOAT, IN `iduser` INT, IN `idupdate` INT, IN `idperiodin` INT)   BEGIN
	-- declaracion variables
    DECLARE id int;
    DECLARE idperiod int;
    DECLARE bonus float;
    DECLARE payment float;
    DECLARE payment_ho float;
    -- asignar valor a variable
    SELECT MAX(id_payment) into id FROM payments;
    IF id is null THEN
    	set id=1;
    ELSE
    	set id=id+1;
    END IF;
    -- consultar su pago por hora
    SELECT level_payment.hour_payment into payment_ho FROM reg_facts JOIN level_payment on 	level_payment.id_level_pay=reg_facts.id_level_pay WHERE reg_facts.id_user=iduser ORDER BY id_user_fact DESC LIMIT 1;
    
    -- consultar su bonus 
    SELECT level_payment.work_bonus into bonus FROM reg_facts JOIN level_payment on level_payment.id_level_pay=reg_facts.id_level_pay WHERE reg_facts.id_user=iduser ORDER BY id_user_fact DESC LIMIT 1;
    -- consultar periodo
    SELECT reg_facts.id_period into idperiod FROM reg_facts join periods ON reg_facts.id_period=periods.id_period WHERE (id_user=iduser) AND (periods.statuts=1);
    
    -- operaciones de sus pagos
    set h_nor=h_nor*payment_ho;
    set h_satu=h_satu*payment_ho*1.2;
    set h_sun=h_sun*payment_ho*1.3;
    set h_holi=h_holi*payment_ho*3;
    set h_miss=h_miss*payment_ho*1.1;
    set h_recover=h_recover*payment_ho*1.1;
    -- calcular su pago_total
    set payment=h_nor+h_satu+h_sun+h_holi-h_miss+h_recover+bonus;
    
    IF idupdate=-1 THEN
    	-- insertar datos en la tabla payment
    	INSERT INTO payments VALUES(id,h_nor,h_satu,h_sun, h_holi,h_miss,h_recover,bonus,payment);
    	-- insertar datos en la tabla de hechos
    	UPDATE reg_facts SET id_payment = id WHERE (id_user = iduser) AND (id_period=idperiod);
    ELSEIF idupdate=-2 THEN
    	-- insertar datos en la tabla payment
    	INSERT INTO payments VALUES(id,h_nor,h_satu,h_sun, h_holi,h_miss,h_recover,bonus,payment);
    	-- insertar datos en la tabla de hechos
    	UPDATE reg_facts SET id_payment = id WHERE (id_user = iduser) AND (id_period=idperiodin);
    ELSE
    	UPDATE payments set p_work_day=h_nor,p_work_saturday=h_satu,p_work_sunday=h_sun,p_work_holeiday=h_holi,dis_miss_hour=h_miss,p_recover_hour=h_recover,p_work_bonus=bonus,payment_total=payment WHERE id_payment=idupdate;
    END IF;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_buscarUser` (IN `iduser` INT)   BEGIN
	SELECT COUNT(id_user) FROM users WHERE id_user=iduser;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_call_check` (IN `iduser` INT, IN `idperiod` INT)   BEGIN
	-- declaraciones
    DECLARE id_per int;
    DECLARE d_init date;
    DECLARE d_end date;
    
    -- asignar valores ala variable
    SELECT date_init into d_init FROM periods WHERE  id_period=idperiod  LIMIT 1; -- d_init
    SELECT date_end into d_end FROM periods WHERE id_period=idperiod LIMIT 1; -- d_end
    
    -- llamar a idcheck
    SELECT * FROM check_day WHERE (c_date BETWEEN d_init AND d_end) AND (id_user=iduser);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_check_` (IN `iduser` INT)   BEGIN	
	DECLARE id_ch int;
    DECLARE cdate date;
    DECLARE cstart time;
    DECLARE cend time;
    DECLARE id_per int; 
    DECLARE n_day int;
    DECLARE f_day int;
    DECLARE t_day varchar(50);
    DECLARE type varchar(50);
    -- buscar el periodo
    	SELECT max(id_period) into id_per FROM periods WHERE statuts=1;
    -- Validar el tipo del dia
    SELECT dayofweek(curdate()) into n_day;
    SELECT count(id_holiday) into f_day FROM holidays WHERE fecha=curdate();
    
    IF f_day=1 THEN
    	set t_day='Feriado';
    ELSEIF n_day>=2 AND n_day<=6 THEN
    	set t_day='Normal';
    ELSEIF n_day=7  THEN
    	set t_day='Sabado';
    ELSEIF n_day=1 THEN
    	set t_day='Domingo';
    END IF;
    
    
    -- validar si marco entrada
    	SELECT max(c_idcheck) into id_ch FROM check_day WHERE(c_date=CURDATE() AND id_user=iduser);
        SELECT c_start into cstart  FROM check_day WHERE(c_date=CURDATE() AND id_user=iduser) ORDER BY c_idcheck DESC LIMIT 1;
        SELECT c_end into cend FROM check_day WHERE(c_date=CURDATE() AND id_user=iduser) ORDER BY c_idcheck DESC LIMIT 1;
       -- si start esta vacio
       	IF cstart is null THEN
        	-- asignar varibales id
    		SELECT max(c_idcheck) into id_ch FROM check_day;
    
    		IF id_ch is null THEN
    			set id_ch=1;
    		ELSE
    			set id_ch=id_ch+1;
   			END IF;
        	-- marcacion entrada
            INSERT INTO check_day VALUES (id_ch,iduser,CURDATE(),CURTIME(),null,t_day,id_per);
            SET type='Entrada';
        ELSEIF cend is null THEN
        	-- marcacion Salida
        	UPDATE check_day SET c_end = CURTIME() WHERE c_idcheck = id_ch;
            SET type='Salida';
        ELSE 
        	SELECT max(c_idcheck) into id_ch FROM check_day;
        	set id_ch=id_ch+1;
            -- segunda o mas marcacions
            INSERT INTO check_day VALUES (id_ch,iduser,CURDATE(),CURTIME(),null,t_day,id_per);
            SET type='Entrada';
        END IF;
    	SELECT CURDATE(),CURTIME(),type;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_hechos_last_period` (IN `iduser` INT, IN `levelpago` INT)   BEGIN
	-- declarar variables
    DECLARE id_red int;
    DECLARE id_per int;
    
    -- asiganar valores
    SELECT max(id_user_fact) into id_red FROM reg_facts;
    		IF id_red is null THEN
    			set id_red=1;
    		ELSE
    			set id_red=id_red+1;
   			END IF;
    SELECT MAX(id_period) into id_per FROM periods WHERE statuts=1;
    -- if idpago es 0
    IF levelpago=0 THEN
    	SELECT id_level_pay into levelpago FROM reg_facts WHERE id_user=100001 ORDER BY id_user_fact DESC LIMIT 1;
    END IF;
    IF levelpago is null THEN
    	SET levelpago=40;
    END IF;
    
    -- registar tabla hechos
    INSERT INTO reg_facts VALUES(id_red,iduser,null,id_per,null,levelpago);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_journeys` (IN `n_day` FLOAT, IN `n_satu` FLOAT, IN `n_sun` FLOAT, IN `n_holi` FLOAT, IN `n_miss` FLOAT, IN `r_recover` FLOAT, IN `iduser` INT, IN `idperiodin` INT)   BEGIN
	-- declaracion variables
    DECLARE id_journy int;
    DECLARE id_fact int;
    DECLARE idperiod int;
    DECLARE updat datetime;
    DECLARE idjup int;
    DECLARE idpup int;
    -- asignacion
    SELECT MAX(id_journeys) into id_journy FROM journeys;
    IF id_journy is null THEN
    	set id_journy=1;
    ELSE
    	set id_journy=id_journy+1;
    END IF;
    set updat=NOW();
    -- consultar periodo
    SELECT reg_facts.id_period into idperiod FROM reg_facts join periods ON reg_facts.id_period=periods.id_period WHERE (id_user=iduser) AND (periods.statuts=1);
    -- buscar el id fac_maximo y vigente de la tabla de hechos
    SELECT reg_facts.id_user_fact into id_fact FROM reg_facts join periods ON reg_facts.id_period=periods.id_period WHERE (id_user=iduser) AND (periods.statuts=1);
    -- if para actualizar o crear
    IF idperiod=-1 THEN
    	-- introducir datos a joruneys
    	INSERT INTO journeys VALUES(id_journy,n_day,n_satu,n_sun,n_holi,n_miss,r_recover,updat);
    	-- vinvular con la tabla de hechos
    	UPDATE reg_facts SET id_journeys = id_journy WHERE (id_user_fact = id_fact) AND (id_period=idperiod);
    	-- llenar en la tabla de pagos
    	call fun_llenar_pagos( n_day, n_satu, n_sun, n_holi, n_miss,r_recover, iduser,-1,0);
    ELSE 
         SELECT id_journeys into idjup FROM reg_facts WHERE id_user=iduser AND id_period=idperiodin;
         SELECT id_payment into idpup FROM reg_facts WHERE id_user=iduser AND id_period=idperiodin;
         IF	idjup IS NULL THEN
         	-- introducir datos a joruneys
    		INSERT INTO journeys VALUES(id_journy,n_day,n_satu,n_sun,n_holi,n_miss,r_recover,updat);
    		-- vinvular con la tabla de hechos
    		UPDATE reg_facts SET id_journeys = id_journy WHERE (id_user = iduser) AND (id_period=idperiodin);
    		-- llenar en la tabla de pagos
    		call fun_llenar_pagos( n_day, n_satu, n_sun, n_holi, n_miss,r_recover, iduser,-2,idperiodin);
         ELSE
         	UPDATE journeys SET j_work_day_hours=n_day, j_work_saturday_hours=n_satu,j_work_sunday_hours=n_sun,j_work_holidays_hours=n_holi,j_miss_hours=n_miss,j_recover_hours=r_recover,last_update=updat WHERE id_journeys=idjup;
         	call fun_llenar_pagos( n_day, n_satu, n_sun, n_holi, n_miss,r_recover, iduser,idpup,0);
         END IF;
         
    END IF; 

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_llamar_user_payments_works` (IN `iduser` INT, IN `idper` INT)   BEGIN
	DECLARE idperi int;
    if idper=0 THEN
    	SELECT id_period INTO idperi FROM periods  WHERE statuts=1 LIMIT 1;
    ELSE
    	set idperi=idper;
    END IF;
    
	SELECT * FROM reg_facts JOIN users ON reg_facts.id_user=users.id_user JOIN factory on users.user_idfactory=factory.idfactory JOIN journeys ON reg_facts.id_journeys=journeys.id_journeys JOIN payments ON reg_facts.id_payment=payments.id_payment JOIN periods on periods.id_period=reg_facts.id_period WHERE reg_facts.id_user=iduser AND periods.id_period=idperi LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_login_users` (IN `iduser` INT, IN `password` VARCHAR(100), OUT `error` VARCHAR(50), OUT `promisse` VARCHAR(50), OUT `passpromisse` VARCHAR(50))   BEGIN
	DECLARE _count int DEFAULT 0;
    DECLARE typeuser int DEFAULT 0;
    DECLARE dbpass varchar(100) DEFAULT '';
    -- consulta si existe usuario
   	SELECT COUNT(id_user) into _count FROM users WHERE id_user=iduser;
    -- validacion de existencia
    IF _count=1 THEN
    	-- consulta password y guarda valor
    	SELECT user_password into dbpass from users WHERE id_user=iduser;
        	set promisse=iduser;
            set passpromisse=dbpass;
    ELSE 
    	-- no exite usuario
 		set error='Usuario no encontrado en la base de datos.';
        set promisse='false';
    end if;
    -- mandar el tipo de usuario
    SELECT id_typeuser into typeuser from users WHERE id_user=iduser;
    -- retorna datos
    SELECT error,promisse,passpromisse, typeuser;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_readFactories` ()   BEGIN
	SELECT idfactory,f_name,f_branch FROM factory;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_readTypesUsers` ()   BEGIN
	SELECT * FROM type_user;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_read_users_periods` (IN `iduser` INT)   BEGIN
	SELECT reg_facts.id_period,periods.date_month FROM reg_facts JOIN periods ON reg_facts.id_period=periods.id_period WHERE id_user=iduser ORDER BY reg_facts.id_period DESC;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registro_usuarios` (IN `type` INT, IN `pass` VARCHAR(100), IN `name` VARCHAR(80), IN `lastn` VARCHAR(80), IN `old` INT, IN `dni` INT(8), IN `birdthdate` DATE, IN `address` VARCHAR(100), IN `country` VARCHAR(100), IN `factory` INT)   BEGIN 
	DECLARE id int;
    DECLARE us int DEFAULT 1;
    DECLARE cr_date datetime;
    -- obtener fecha y id
    SELECT now() into cr_date;
    SELECT max(id_user) into id FROM users;
    set id=id+1;
    -- iniciar proceso de insercion de datos
    insert into users VALUES(id,type,pass,name,lastn,old,dni,birdthdate,address,country,factory,cr_date);
    -- devolver
    SELECT us,id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `check_day`
--

CREATE TABLE `check_day` (
  `c_idcheck` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `c_date` date DEFAULT NULL,
  `c_start` time DEFAULT NULL,
  `c_end` time DEFAULT NULL,
  `type_day` varchar(50) NOT NULL,
  `c_idperiod` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `check_day`
--

INSERT INTO `check_day` (`c_idcheck`, `id_user`, `c_date`, `c_start`, `c_end`, `type_day`, `c_idperiod`) VALUES
(7, 100001, '2023-10-01', '07:00:00', '20:15:38', 'Sabado', 231),
(8, 100001, '2023-10-07', '07:00:00', '20:15:38', 'Sabado', 231),
(11, 100002, '2023-10-08', '07:00:00', '20:15:38', 'Feriado', 231),
(12, 100001, '2023-10-08', '07:00:00', '20:15:38', 'Feriado', 231),
(13, 100002, '2023-10-08', '07:00:00', '20:15:38', 'Feriado', 231),
(14, 100001, '2023-10-17', '07:00:00', '20:15:38', 'Normal', 231),
(15, 100001, '2023-10-17', '07:00:00', '20:15:38', 'Normal', 231),
(16, 100001, '2023-10-17', '07:00:00', '20:15:38', 'Normal', 231),
(17, 100001, '2023-10-17', '07:00:00', '20:15:38', 'Normal', 231),
(18, 100001, '2023-10-17', '07:00:00', '20:15:38', 'Normal', 231),
(19, 100001, '2023-10-17', '07:00:00', '20:15:38', 'Normal', 231),
(20, 100001, '2023-10-17', '07:00:00', '20:15:38', 'Normal', 231),
(21, 100001, '2023-10-17', '07:00:00', '20:15:38', 'Normal', 231),
(22, 100001, '2023-10-17', '07:00:00', '20:15:38', 'Normal', 231),
(23, 100001, '2023-10-17', '07:00:00', '20:15:38', 'Normal', 231),
(25, 100002, '2023-10-17', '07:00:00', '20:15:38', 'Normal', 231),
(26, 100002, '2023-10-17', '07:00:00', '20:15:38', 'Normal', 231),
(27, 100002, '2023-10-17', '07:00:00', '20:15:38', 'Normal', 231),
(28, 100001, '2023-10-17', '07:00:00', '20:15:38', 'Normal', 231),
(29, 100001, '2023-10-17', '07:00:00', '20:15:38', 'Normal', 231),
(30, 100001, '2023-10-17', '07:00:00', '20:15:38', 'Normal', 231),
(31, 100002, '2023-10-17', '07:00:00', '20:15:38', 'Normal', 231),
(32, 100001, '2023-10-18', '07:00:00', '20:15:38', 'Normal', 231),
(33, 100001, '2023-10-18', '07:00:00', '19:30:16', 'Normal', 231),
(34, 100004, '2023-10-18', '07:00:00', NULL, 'Normal', 231),
(35, 100005, '2023-10-18', '07:00:00', NULL, 'Normal', 231),
(36, 100001, '2023-10-18', '07:00:00', '19:57:52', 'Normal', 231),
(37, 100001, '2023-10-18', '07:00:00', '19:58:09', 'Normal', 231);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factory`
--

CREATE TABLE `factory` (
  `idfactory` int(11) NOT NULL,
  `f_name` varchar(100) NOT NULL,
  `f_ruc` decimal(16,0) NOT NULL,
  `f_address` varchar(100) NOT NULL,
  `f_branch` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `factory`
--

INSERT INTO `factory` (`idfactory`, `f_name`, `f_ruc`, `f_address`, `f_branch`) VALUES
(1001, 'Tesla INC', 20558625852, 'Av. Argentina n° 485', 'Sede Sur'),
(1002, 'Tesla INC', 20558625852, 'Calle Santa Luisa n° 156', 'Sede Norte'),
(1003, 'Tesla INC', 20558625852, 'AV. Vallejo n° 258', 'Sede Oeste'),
(1004, 'Tesla INC', 20558625852, 'AV. Caja de Agua n° 934', 'Sede Este');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `holidays`
--

CREATE TABLE `holidays` (
  `id_holiday` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `descripcion` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `holidays`
--

INSERT INTO `holidays` (`id_holiday`, `fecha`, `descripcion`) VALUES
(1, '2023-01-01', 'Ano Nuevo'),
(63, '2023-03-06', 'Jueves Santo'),
(73, '2023-03-07', 'Viernes Santo'),
(15, '2023-05-01', 'Dia del Trabajador'),
(296, '2023-06-29', 'Dia San Pedro y San Pablo'),
(287, '2023-07-28', 'Fiestas Patrias'),
(297, '2023-07-29', 'Fiestas Patrias'),
(68, '2023-08-06', 'Batlla de Junin'),
(308, '2023-08-30', 'Santa Rosa de Lima'),
(810, '2023-10-08', 'Combate Angamos'),
(111, '2023-11-01', 'Dia de los Santos'),
(812, '0000-00-00', 'Dia de la Inmaculada Concepcion'),
(912, '2023-12-09', 'Batalla de Ayacuccho'),
(2512, '2023-12-25', 'Navidad');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `journeys`
--

CREATE TABLE `journeys` (
  `id_journeys` int(11) NOT NULL,
  `j_work_day_hours` float DEFAULT NULL,
  `j_work_saturday_hours` float DEFAULT NULL,
  `j_work_sunday_hours` float DEFAULT NULL,
  `j_work_holidays_hours` float DEFAULT NULL,
  `j_miss_hours` float DEFAULT NULL,
  `j_recover_hours` float DEFAULT NULL,
  `last_update` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `journeys`
--

INSERT INTO `journeys` (`id_journeys`, `j_work_day_hours`, `j_work_saturday_hours`, `j_work_sunday_hours`, `j_work_holidays_hours`, `j_miss_hours`, `j_recover_hours`, `last_update`) VALUES
(1, 223.91, 26.5, 0, 13.25, 1, 1, '2023-10-18 19:59:12'),
(3, 145, 16, 8, 8, 1, 1, '2023-10-18 13:35:27'),
(4, 0, 0, 0, 0, 1, 1, '2023-10-18 19:11:34'),
(6, 140, 8, 8, 16, 1.5, 1.5, '2023-10-18 13:34:15');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `level_payment`
--

CREATE TABLE `level_payment` (
  `id_level_pay` int(11) NOT NULL,
  `month_payment` float NOT NULL,
  `day_payment` float NOT NULL,
  `hour_payment` float NOT NULL,
  `work_bonus` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `level_payment`
--

INSERT INTO `level_payment` (`id_level_pay`, `month_payment`, `day_payment`, `hour_payment`, `work_bonus`) VALUES
(10, 4200, 200, 25, 500),
(20, 3500, 166.6, 20.8, 350),
(30, 2500, 119, 14.8, 300),
(40, 1500, 71, 8.9, 250);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `payments`
--

CREATE TABLE `payments` (
  `id_payment` int(11) NOT NULL,
  `p_work_day` float NOT NULL,
  `p_work_saturday` float NOT NULL,
  `p_work_sunday` float NOT NULL,
  `p_work_holeiday` float NOT NULL,
  `dis_miss_hour` float NOT NULL,
  `p_recover_hour` float NOT NULL,
  `p_work_bonus` float NOT NULL,
  `payment_total` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `payments`
--

INSERT INTO `payments` (`id_payment`, `p_work_day`, `p_work_saturday`, `p_work_sunday`, `p_work_holeiday`, `dis_miss_hour`, `p_recover_hour`, `p_work_bonus`, `payment_total`) VALUES
(6, 2146, 284.16, 153.92, 355.2, 16.28, 16.28, 300, 3239.28),
(7, 0, 0, 0, 0, 22.88, 22.88, 350, 350),
(8, 4657.33, 661.44, 0, 826.8, 22.88, 22.88, 350, 6495.57),
(10, 2072, 142.08, 153.92, 710.4, 24.42, 24.42, 300, 3378.4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `periods`
--

CREATE TABLE `periods` (
  `id_period` int(11) NOT NULL,
  `date_init` date DEFAULT NULL,
  `date_end` date DEFAULT NULL,
  `date_month` varchar(30) DEFAULT NULL,
  `date_year` int(11) DEFAULT NULL,
  `statuts` int(11) NOT NULL,
  `st_description` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `periods`
--

INSERT INTO `periods` (`id_period`, `date_init`, `date_end`, `date_month`, `date_year`, `statuts`, `st_description`) VALUES
(230, '2023-09-01', '2023-09-30', 'Setiembre', 2023, 0, 'Pasado'),
(231, '2023-10-01', '2023-10-31', 'Octubre', 2023, 1, 'Vigente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recover`
--

CREATE TABLE `recover` (
  `id_recover` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `miss_date` date DEFAULT NULL,
  `hours_miss` float DEFAULT NULL,
  `recover_date` date DEFAULT NULL,
  `start_day` time DEFAULT NULL,
  `end_day` time DEFAULT NULL,
  `state` tinyint(1) DEFAULT NULL,
  `miss_hour` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reg_facts`
--

CREATE TABLE `reg_facts` (
  `id_user_fact` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `id_journeys` int(11) DEFAULT NULL,
  `id_period` int(11) DEFAULT NULL,
  `id_payment` int(11) DEFAULT NULL,
  `id_level_pay` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `reg_facts`
--

INSERT INTO `reg_facts` (`id_user_fact`, `id_user`, `id_journeys`, `id_period`, `id_payment`, `id_level_pay`) VALUES
(1, 100001, 4, 230, 7, 20),
(2, 100002, 6, 230, 10, 30),
(3, 100001, 1, 231, 8, 20),
(4, 100002, 3, 231, 6, 30);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `type_user`
--

CREATE TABLE `type_user` (
  `id_typeuser` int(11) NOT NULL,
  `description` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `type_user`
--

INSERT INTO `type_user` (`id_typeuser`, `description`) VALUES
(1, 'Empleados'),
(2, 'Administradores');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id_user` int(11) NOT NULL,
  `id_typeuser` int(11) NOT NULL,
  `user_password` varchar(100) NOT NULL,
  `user_name` varchar(80) DEFAULT NULL,
  `user_lastname` varchar(80) DEFAULT NULL,
  `user_years_old` decimal(2,0) DEFAULT NULL,
  `user_dni` decimal(8,0) DEFAULT NULL,
  `user_birthdate` date DEFAULT NULL,
  `user_address` varchar(100) DEFAULT NULL,
  `user_country` varchar(100) DEFAULT NULL,
  `user_idfactory` int(11) NOT NULL,
  `user_create_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id_user`, `id_typeuser`, `user_password`, `user_name`, `user_lastname`, `user_years_old`, `user_dni`, `user_birthdate`, `user_address`, `user_country`, `user_idfactory`, `user_create_date`) VALUES
(100001, 1, 'wilmer2005', 'Wilmer Franco', 'Zuñiga Gamboa', 21, 76513440, '2002-05-20', 'Calle sol n° 258', 'Peru', 1001, '2023-10-06 21:02:54'),
(100002, 1, 'Lilli2002', 'Lilly', 'Polo Sotomayor', 21, 78951258, '2002-06-19', 'av. Puente piedra', 'Peru', 1002, '2023-10-07 11:54:42'),
(100003, 2, 'Admin200', 'Administrador', 'de Software', 0, 10000000, '0000-00-00', 'no adrress', 'no country', 1001, '2023-10-17 10:43:55'),
(100004, 1, 'Estela200', 'Estela Maribel', 'Solis Quispe', 23, 76258545, '2000-06-10', 'AV. Carabayllo', 'Peru', 1002, '2023-10-17 13:51:44'),
(100005, 1, '15', 'Wilmer', 'Z', 20, 25, '2000-05-10', 'AV. Carabayllo', 'Peru', 1001, '2023-10-17 13:56:45'),
(100006, 2, '123', 'Estela Maribel', 'Solis Quispe', 21, 76518458, '2000-02-20', 'AV. Carabayllo', 'Peru', 1002, '2023-10-18 19:56:27');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `check_day`
--
ALTER TABLE `check_day`
  ADD PRIMARY KEY (`c_idcheck`),
  ADD KEY `c_idperiod` (`c_idperiod`),
  ADD KEY `check_day_ibfk_2` (`id_user`);

--
-- Indices de la tabla `factory`
--
ALTER TABLE `factory`
  ADD PRIMARY KEY (`idfactory`);

--
-- Indices de la tabla `journeys`
--
ALTER TABLE `journeys`
  ADD PRIMARY KEY (`id_journeys`);

--
-- Indices de la tabla `level_payment`
--
ALTER TABLE `level_payment`
  ADD PRIMARY KEY (`id_level_pay`);

--
-- Indices de la tabla `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id_payment`);

--
-- Indices de la tabla `periods`
--
ALTER TABLE `periods`
  ADD PRIMARY KEY (`id_period`);

--
-- Indices de la tabla `recover`
--
ALTER TABLE `recover`
  ADD PRIMARY KEY (`id_recover`),
  ADD KEY `id_user` (`id_user`);

--
-- Indices de la tabla `reg_facts`
--
ALTER TABLE `reg_facts`
  ADD PRIMARY KEY (`id_user_fact`),
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_journeys` (`id_journeys`),
  ADD KEY `id_period` (`id_period`),
  ADD KEY `id_payment` (`id_payment`),
  ADD KEY `id_level_pay` (`id_level_pay`);

--
-- Indices de la tabla `type_user`
--
ALTER TABLE `type_user`
  ADD PRIMARY KEY (`id_typeuser`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`),
  ADD KEY `fk_user_factory` (`user_idfactory`),
  ADD KEY `fk_type_user` (`id_typeuser`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `check_day`
--
ALTER TABLE `check_day`
  ADD CONSTRAINT `check_day_ibfk_1` FOREIGN KEY (`c_idperiod`) REFERENCES `periods` (`id_period`),
  ADD CONSTRAINT `check_day_ibfk_2` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`);

--
-- Filtros para la tabla `recover`
--
ALTER TABLE `recover`
  ADD CONSTRAINT `recover_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`);

--
-- Filtros para la tabla `reg_facts`
--
ALTER TABLE `reg_facts`
  ADD CONSTRAINT `reg_facts_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`),
  ADD CONSTRAINT `reg_facts_ibfk_2` FOREIGN KEY (`id_journeys`) REFERENCES `journeys` (`id_journeys`),
  ADD CONSTRAINT `reg_facts_ibfk_3` FOREIGN KEY (`id_period`) REFERENCES `periods` (`id_period`),
  ADD CONSTRAINT `reg_facts_ibfk_5` FOREIGN KEY (`id_payment`) REFERENCES `payments` (`id_payment`),
  ADD CONSTRAINT `reg_facts_ibfk_6` FOREIGN KEY (`id_level_pay`) REFERENCES `level_payment` (`id_level_pay`);

--
-- Filtros para la tabla `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_type_user` FOREIGN KEY (`id_typeuser`) REFERENCES `type_user` (`id_typeuser`),
  ADD CONSTRAINT `fk_user_factory` FOREIGN KEY (`user_idfactory`) REFERENCES `factory` (`idfactory`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

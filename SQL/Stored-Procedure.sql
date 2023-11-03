DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_llamar_user_payments_works`(IN `iduser` INT, IN `idper` INT)
BEGIN
	DECLARE idperi int;
    if idper=0 THEN
    	SELECT id_period INTO idperi FROM periods  WHERE statuts=1 LIMIT 1;
    ELSE
    	set idperi=idper;
    END IF;
    
	SELECT * FROM reg_facts JOIN users ON reg_facts.id_user=users.id_user JOIN factory on users.user_idfactory=factory.idfactory JOIN journeys ON reg_facts.id_journeys=journeys.id_journeys JOIN payments ON reg_facts.id_payment=payments.id_payment JOIN periods on periods.id_period=reg_facts.id_period WHERE reg_facts.id_user=iduser AND periods.id_period=idperi LIMIT 1;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fun_llenar_pagos`(IN `h_nor` FLOAT, IN `h_satu` FLOAT, IN `h_sun` FLOAT, IN `h_holi` FLOAT, IN `h_miss` FLOAT, IN `h_recover` FLOAT, IN `iduser` INT, IN `idupdate` INT, IN `idperiodin` INT)
BEGIN
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
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_buscarUser`(in iduser int)
BEGIN
	SELECT COUNT(id_user) FROM users WHERE id_user=iduser;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_call_check`(IN `iduser` INT, IN `idperiod` INT)
BEGIN
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
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_check_`(IN `iduser` INT)
BEGIN	
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
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_hechos_last_period`(
	in iduser int,
    in levelpago int
)
BEGIN
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
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_journeys`(IN `n_day` FLOAT, IN `n_satu` FLOAT, IN `n_sun` FLOAT, IN `n_holi` FLOAT, IN `n_miss` FLOAT, IN `r_recover` FLOAT, IN `iduser` INT, IN `idperiodin` INT)
BEGIN
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
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_login_users`(IN `iduser` INT, IN `password` VARCHAR(100), OUT `error` VARCHAR(50), OUT `promisse` VARCHAR(50), OUT `passpromisse` VARCHAR(50))
BEGIN
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
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_readFactories`()
BEGIN
	SELECT idfactory,f_name,f_branch FROM factory;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_readTypesUsers`()
BEGIN
	SELECT * FROM type_user;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_read_users_periods`(IN `iduser` INT)
BEGIN
	SELECT reg_facts.id_period,periods.date_month FROM reg_facts JOIN periods ON reg_facts.id_period=periods.id_period WHERE id_user=iduser ORDER BY reg_facts.id_period DESC;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registro_usuarios`(IN `type` INT, IN `pass` VARCHAR(100), IN `name` VARCHAR(80), IN `lastn` VARCHAR(80), IN `old` INT, IN `dni` INT(8), IN `birdthdate` DATE, IN `address` VARCHAR(100), IN `country` VARCHAR(100), IN `factory` INT)
BEGIN 
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

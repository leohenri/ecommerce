-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 05-Abr-2022 às 02:31
-- Versão do servidor: 10.4.22-MariaDB
-- versão do PHP: 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `db_ecommerce`
--

DELIMITER $$
--
-- Procedimentos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_addresses_save` (`pidaddress` INT(11), `pidperson` INT(11), `pdesaddress` VARCHAR(128), `pdesnumber` VARCHAR(32), `pdescomplement` VARCHAR(32), `pdescity` VARCHAR(32), `pdesstate` VARCHAR(32), `pdescountry` VARCHAR(32), `pdeszipcode` CHAR(8), `pdesdistrict` VARCHAR(32))  BEGIN

	IF pidaddress > 0 THEN
		
		UPDATE tb_addresses
        SET
			idperson = pidperson,
            desaddress = pdesaddress,
            descomplement = pdescomplement,
            descity = pdescity,
            desnumber = pdesnumber,
            desstate = pdesstate,
            descountry = pdescountry,
            deszipcode = pdeszipcode, 
            desdistrict = pdesdistrict
		WHERE idaddress = pidaddress;
        
    ELSE
		
		INSERT INTO tb_addresses (idperson, desaddress, descomplement, descity, desnumber, desstate, descountry, deszipcode, desdistrict)
        VALUES(pidperson, pdesaddress, pdescomplement, pdescity, pdesnumber, pdesstate, pdescountry, pdeszipcode, pdesdistrict);
        
        SET pidaddress = LAST_INSERT_ID();
        
    END IF;
    
    SELECT * FROM tb_addresses WHERE idaddress = pidaddress;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_carts_save` (`pidcart` INT, `pdessessionid` VARCHAR(64), `piduser` INT, `pdeszipcode` CHAR(8), `pvlfreight` DECIMAL(10,2), `pnrdays` INT)  BEGIN

    IF pidcart > 0 THEN
        
        UPDATE tb_carts
        SET
            dessessionid = pdessessionid,
            iduser = piduser,
            deszipcode = pdeszipcode,
            vlfreight = pvlfreight,
            nrdays = pnrdays
        WHERE idcart = pidcart;
        
    ELSE
        
        INSERT INTO tb_carts (dessessionid, iduser, deszipcode, vlfreight, nrdays)
        VALUES(pdessessionid, piduser, pdeszipcode, pvlfreight, pnrdays);
        
        SET pidcart = LAST_INSERT_ID();
        
    END IF;
    
    SELECT * FROM tb_carts WHERE idcart = pidcart;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_categories_save` (`pidcategory` INT, `pdescategory` VARCHAR(64))  BEGIN
	
	IF pidcategory > 0 THEN
		
		UPDATE tb_categories
        SET descategory = pdescategory
        WHERE idcategory = pidcategory;
        
    ELSE
		
		INSERT INTO tb_categories (descategory) VALUES(pdescategory);
        
        SET pidcategory = LAST_INSERT_ID();
        
    END IF;
    
    SELECT * FROM tb_categories WHERE idcategory = pidcategory;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_orders_save` (`pidorder` INT, `pidcart` INT(11), `piduser` INT(11), `pidstatus` INT(11), `pidaddress` INT(11), `pvltotal` DECIMAL(10,2))  BEGIN
	
	IF pidorder > 0 THEN
		
		UPDATE tb_orders
        SET
			idcart = pidcart,
            iduser = piduser,
            idstatus = pidstatus,
            idaddress = pidaddress,
            vltotal = pvltotal
		WHERE idorder = pidorder;
        
    ELSE
    
		INSERT INTO tb_orders (idcart, iduser, idstatus, idaddress, vltotal)
        VALUES(pidcart, piduser, pidstatus, pidaddress, pvltotal);
		
		SET pidorder = LAST_INSERT_ID();
        
    END IF;
    
    SELECT * 
    FROM tb_orders a
    INNER JOIN tb_ordersstatus b USING(idstatus)
    INNER JOIN tb_carts c USING(idcart)
    INNER JOIN tb_users d ON d.iduser = a.iduser
    INNER JOIN tb_addresses e USING(idaddress)
    WHERE idorder = pidorder;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_products_save` (`pidproduct` INT(11), `pdesproduct` VARCHAR(64), `pvlprice` DECIMAL(10,2), `pvlwidth` DECIMAL(10,2), `pvlheight` DECIMAL(10,2), `pvllength` DECIMAL(10,2), `pvlweight` DECIMAL(10,2), `pdesurl` VARCHAR(128))  BEGIN
	
	IF pidproduct > 0 THEN
		
		UPDATE tb_products
        SET 
			desproduct = pdesproduct,
            vlprice = pvlprice,
            vlwidth = pvlwidth,
            vlheight = pvlheight,
            vllength = pvllength,
            vlweight = pvlweight,
            desurl = pdesurl
        WHERE idproduct = pidproduct;
        
    ELSE
		
		INSERT INTO tb_products (desproduct, vlprice, vlwidth, vlheight, vllength, vlweight, desurl) 
        VALUES(pdesproduct, pvlprice, pvlwidth, pvlheight, pvllength, pvlweight, pdesurl);
        
        SET pidproduct = LAST_INSERT_ID();
        
    END IF;
    
    SELECT * FROM tb_products WHERE idproduct = pidproduct;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_userspasswordsrecoveries_create` (`piduser` INT, `pdesip` VARCHAR(45))  BEGIN
	
	INSERT INTO tb_userspasswordsrecoveries (iduser, desip)
    VALUES(piduser, pdesip);
    
    SELECT * FROM tb_userspasswordsrecoveries
    WHERE idrecovery = LAST_INSERT_ID();
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usersupdate_save` (`piduser` INT, `pdesperson` VARCHAR(64), `pdeslogin` VARCHAR(64), `pdespassword` VARCHAR(256), `pdesemail` VARCHAR(128), `pnrphone` BIGINT, `pinadmin` TINYINT)  BEGIN
	
    DECLARE vidperson INT;
    
	SELECT idperson INTO vidperson
    FROM tb_users
    WHERE iduser = piduser;
    
    UPDATE tb_persons
    SET 
		desperson = pdesperson,
        desemail = pdesemail,
        nrphone = pnrphone
	WHERE idperson = vidperson;
    
    UPDATE tb_users
    SET
		deslogin = pdeslogin,
        despassword = pdespassword,
        inadmin = pinadmin
	WHERE iduser = piduser;
    
    SELECT * FROM tb_users a INNER JOIN tb_persons b USING(idperson) WHERE a.iduser = piduser;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_users_delete` (`piduser` INT)  BEGIN
    
    DECLARE vidperson INT;
    
    SET FOREIGN_KEY_CHECKS = 0;
	
	SELECT idperson INTO vidperson
    FROM tb_users
    WHERE iduser = piduser;
	
    DELETE FROM tb_addresses WHERE idperson = vidperson;
    DELETE FROM tb_addresses WHERE idaddress IN(SELECT idaddress FROM tb_orders WHERE iduser = piduser);
	DELETE FROM tb_persons WHERE idperson = vidperson;
    
    DELETE FROM tb_userslogs WHERE iduser = piduser;
    DELETE FROM tb_userspasswordsrecoveries WHERE iduser = piduser;
    DELETE FROM tb_orders WHERE iduser = piduser;
    DELETE FROM tb_cartsproducts WHERE idcart IN(SELECT idcart FROM tb_carts WHERE iduser = piduser);
    DELETE FROM tb_carts WHERE iduser = piduser;
    DELETE FROM tb_users WHERE iduser = piduser;
    
    SET FOREIGN_KEY_CHECKS = 1;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_users_save` (`pdesperson` VARCHAR(64), `pdeslogin` VARCHAR(64), `pdespassword` VARCHAR(256), `pdesemail` VARCHAR(128), `pnrphone` BIGINT, `pinadmin` TINYINT)  BEGIN
	
    DECLARE vidperson INT;
    
	INSERT INTO tb_persons (desperson, desemail, nrphone)
    VALUES(pdesperson, pdesemail, pnrphone);
    
    SET vidperson = LAST_INSERT_ID();
    
    INSERT INTO tb_users (idperson, deslogin, despassword, inadmin)
    VALUES(vidperson, pdeslogin, pdespassword, pinadmin);
    
    SELECT * FROM tb_users a INNER JOIN tb_persons b USING(idperson) WHERE a.iduser = LAST_INSERT_ID();
    
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_addresses`
--

CREATE TABLE `tb_addresses` (
  `idaddress` int(11) NOT NULL,
  `idperson` int(11) NOT NULL,
  `desaddress` varchar(128) NOT NULL,
  `desnumber` varchar(16) NOT NULL,
  `descity` varchar(32) NOT NULL,
  `desstate` varchar(32) NOT NULL,
  `descountry` varchar(32) NOT NULL,
  `deszipcode` char(8) NOT NULL,
  `desdistrict` varchar(32) NOT NULL,
  `dtregister` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_addresses`
--

INSERT INTO `tb_addresses` (`idaddress`, `idperson`, `desaddress`, `desnumber`, `descity`, `desstate`, `descountry`, `deszipcode`, `desdistrict`, `dtregister`) VALUES
(1, 7, 'Avenida Brasil', 'de 26647 a 27767', 'Rio de Janeiro', 'RJ', 'Brasil', '21615338', 'Deodoro', '2017-09-06 16:04:03'),
(2, 7, 'Avenida Brasil', 'de 26647 a 27767', 'Rio de Janeiro', 'RJ', 'Brasil', '21615338', 'Deodoro', '2017-09-06 16:05:19'),
(3, 1, 'Avenida Paulista', 'de 612 a 1510 - ', 'São Paulo', 'SP', 'Brasil', '01310100', 'Bela Vista', '2017-09-08 11:39:31'),
(4, 1, 'Avenida Paulista', 'de 612 a 1510 - ', 'São Paulo', 'SP', 'Brasil', '01310100', 'Bela Vista', '2017-09-08 11:39:54'),
(5, 1, 'Avenida Paulista', 'de 612 a 1510 - ', 'São Paulo', 'SP', 'Brasil', '01310100', 'Bela Vista', '2017-09-08 12:19:04'),
(6, 1, 'Avenida Paulista', 'de 612 a 1510 - ', 'São Paulo', 'SP', 'Brasil', '01310100', 'Bela Vista', '2017-09-08 12:20:07'),
(7, 1, 'Avenida Paulista', 'de 612 a 1510 - ', 'São Paulo', 'SP', 'Brasil', '01310100', 'Bela Vista', '2017-09-08 12:21:06'),
(8, 1, 'Avenida Paulista', 'de 612 a 1510 - ', 'São Paulo', 'SP', 'Brasil', '01310100', 'Bela Vista', '2017-09-08 12:22:33'),
(9, 1, 'Avenida Paulista', 'de 612 a 1510 - ', 'São Paulo', 'SP', 'Brasil', '01310100', 'Bela Vista', '2017-09-08 12:27:54'),
(10, 1, 'Avenida Paulista', 'de 612 a 1510 - ', 'São Paulo', 'SP', 'Brasil', '01310100', 'Bela Vista', '2017-09-21 13:59:47');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_carts`
--

CREATE TABLE `tb_carts` (
  `idcart` int(11) NOT NULL,
  `dessessionid` varchar(64) NOT NULL,
  `iduser` int(11) DEFAULT NULL,
  `deszipcode` char(8) DEFAULT NULL,
  `vlfreight` decimal(10,2) DEFAULT NULL,
  `nrdays` int(11) DEFAULT NULL,
  `dtregister` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_carts`
--

INSERT INTO `tb_carts` (`idcart`, `dessessionid`, `iduser`, `deszipcode`, `vlfreight`, `nrdays`, `dtregister`) VALUES
(1, '8hcko3j7hmgp8sv7ggnseueupv', NULL, '22041080', NULL, 2, '2017-09-04 18:50:50'),
(2, 'm8iq807es95o2hj1a30772df1d', NULL, '21615338', '72.92', 2, '2017-09-06 13:12:50'),
(3, 'cl1s6p6ti29vns970emmbhe7tb', 7, NULL, NULL, NULL, '2017-09-06 13:46:15'),
(4, 'a8frnbabuqu60gguivlmrpagin', NULL, '01310100', '61.12', 1, '2017-09-08 11:39:01'),
(5, '51jglmd9n3cdirc1ah75m31pt1', NULL, NULL, NULL, NULL, '2017-09-14 11:26:39'),
(6, 'tlvjs3tas1bml5uit8b5qgjn9l', NULL, '01310100', '42.79', 1, '2017-09-21 13:18:21');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_cartsproducts`
--

CREATE TABLE `tb_cartsproducts` (
  `idcartproduct` int(11) NOT NULL,
  `idcart` int(11) NOT NULL,
  `idproduct` int(11) NOT NULL,
  `dtremoved` datetime DEFAULT NULL,
  `dtregister` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_cartsproducts`
--

INSERT INTO `tb_cartsproducts` (`idcartproduct`, `idcart`, `idproduct`, `dtremoved`, `dtregister`) VALUES
(1, 1, 2, '2017-09-04 15:51:33', '2017-09-04 18:51:14'),
(2, 1, 2, '2017-09-04 15:52:09', '2017-09-04 18:51:31'),
(3, 1, 4, '2017-09-04 15:53:42', '2017-09-04 18:53:36'),
(4, 1, 4, '2017-09-04 15:54:11', '2017-09-04 18:53:40'),
(5, 1, 2, '2017-09-04 16:32:57', '2017-09-04 18:54:01'),
(6, 1, 2, '2017-09-04 16:33:04', '2017-09-04 19:31:05'),
(7, 1, 2, '2017-09-04 16:41:33', '2017-09-04 19:32:59'),
(8, 1, 2, '2017-09-04 16:41:38', '2017-09-04 19:33:02'),
(9, 1, 2, NULL, '2017-09-04 19:39:39'),
(10, 2, 2, '2017-09-06 10:21:57', '2017-09-06 13:20:44'),
(11, 2, 4, NULL, '2017-09-06 13:42:37'),
(12, 2, 4, NULL, '2017-09-06 15:28:56'),
(13, 4, 4, '2017-09-08 09:39:01', '2017-09-08 11:39:01'),
(14, 4, 4, NULL, '2017-09-08 12:27:38'),
(15, 4, 4, NULL, '2017-09-08 12:38:57'),
(16, 6, 4, NULL, '2017-09-21 13:59:32');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_categories`
--

CREATE TABLE `tb_categories` (
  `idcategory` int(11) NOT NULL,
  `descategory` varchar(32) NOT NULL,
  `dtregister` timestamp NOT NULL DEFAULT current_timestamp(),
  `disablecategory` int(1) DEFAULT NULL,
  `dtlastupdate` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_categories`
--

INSERT INTO `tb_categories` (`idcategory`, `descategory`, `dtregister`, `disablecategory`, `dtlastupdate`) VALUES
(1, 'Android', '2017-09-21 15:18:08', NULL, '2022-03-29 23:57:03'),
(2, 'IOS', '2017-09-21 15:18:15', NULL, '2022-03-29 23:56:58'),
(3, 'Samsung', '2017-09-21 15:19:14', NULL, '2022-04-01 13:29:57'),
(4, 'Teste', '2022-03-29 23:27:36', NULL, '2022-04-01 13:29:58'),
(5, 'Teste 22322', '2022-03-29 23:33:05', NULL, '2022-04-01 13:29:59'),
(6, 'Alimentícios', '2022-03-31 18:05:17', NULL, '2022-03-31 20:33:53'),
(7, 'Leandro', '2022-04-01 21:10:37', NULL, '2022-04-01 21:10:37'),
(8, 'Leandro', '2022-04-01 21:10:42', NULL, '2022-04-01 21:10:42');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_categoriesproducts`
--

CREATE TABLE `tb_categoriesproducts` (
  `idcategory` int(11) NOT NULL,
  `idproduct` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `tb_categoriesproducts`
--

INSERT INTO `tb_categoriesproducts` (`idcategory`, `idproduct`) VALUES
(1, 1),
(1, 4);

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_orders`
--

CREATE TABLE `tb_orders` (
  `idorder` int(11) NOT NULL,
  `idcart` int(11) NOT NULL,
  `iduser` int(11) NOT NULL,
  `idstatus` int(11) NOT NULL,
  `idaddress` int(11) NOT NULL,
  `vltotal` decimal(10,2) NOT NULL,
  `dtregister` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_orders`
--

INSERT INTO `tb_orders` (`idorder`, `idcart`, `iduser`, `idstatus`, `idaddress`, `vltotal`, `dtregister`) VALUES
(1, 4, 1, 1, 4, '42.79', '2017-09-08 11:39:54'),
(2, 4, 1, 3, 9, '2359.12', '2017-09-08 12:27:54');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_ordersstatus`
--

CREATE TABLE `tb_ordersstatus` (
  `idstatus` int(11) NOT NULL,
  `desstatus` varchar(32) NOT NULL,
  `dtregister` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_ordersstatus`
--

INSERT INTO `tb_ordersstatus` (`idstatus`, `desstatus`, `dtregister`) VALUES
(1, 'Em Aberto', '2017-03-13 03:00:00'),
(2, 'Aguardando Pagamento', '2017-03-13 03:00:00'),
(3, 'Pago', '2017-03-13 03:00:00'),
(4, 'Entregue', '2017-03-13 03:00:00');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_persons`
--

CREATE TABLE `tb_persons` (
  `idperson` int(11) NOT NULL,
  `desperson` varchar(64) NOT NULL,
  `desemail` varchar(128) DEFAULT NULL,
  `nrphone` bigint(20) DEFAULT NULL,
  `dtregister` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_persons`
--

INSERT INTO `tb_persons` (`idperson`, `desperson`, `desemail`, `nrphone`, `dtregister`) VALUES
(1, 'João Rangel', 'admin@hcode.com.br', 2147483647, '2017-03-01 03:00:00'),
(7, 'Suporte', 'suporte@hcode.com.br', 1112345678, '2017-03-15 16:10:27'),
(8, 'aaaaaaaaaaaaaaa', 'aaa@gmail.com', 5222212, '2017-09-04 20:43:40'),
(9, 'Joao', 'joao@hcode.com.br', 12345678, '2017-09-04 20:50:02'),
(10, 'Hcode', 'suporte@hcode.com.br', 1112345678, '2017-09-06 14:32:15'),
(11, 'Pedro Henrique de Souza Barbosa', 'phsb17092013@gmail.com', 389999999, '2022-03-29 17:17:52'),
(12, 'Rafaela Souza', 'rafaeladinelli@gmail.com', 389999945555, '2022-03-31 18:03:59');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_photos`
--

CREATE TABLE `tb_photos` (
  `idphoto` int(11) NOT NULL,
  `idproduct` int(11) NOT NULL,
  `desphoto` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `tb_photos`
--

INSERT INTO `tb_photos` (`idphoto`, `idproduct`, `desphoto`) VALUES
(10, 1, '1-20220404212606.jpg'),
(11, 1, '1-20220404212615.jpg'),
(12, 4, '4-20220404213224.jpg');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_products`
--

CREATE TABLE `tb_products` (
  `idproduct` int(11) NOT NULL,
  `desproduct` varchar(64) NOT NULL,
  `vlprice` decimal(10,2) NOT NULL,
  `vlwidth` decimal(10,2) NOT NULL,
  `vlheight` decimal(10,2) NOT NULL,
  `vllength` decimal(10,2) NOT NULL,
  `vlweight` decimal(10,2) NOT NULL,
  `desurl` varchar(128) NOT NULL,
  `dtregister` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_products`
--

INSERT INTO `tb_products` (`idproduct`, `desproduct`, `vlprice`, `vlwidth`, `vlheight`, `vllength`, `vlweight`, `desurl`, `dtregister`) VALUES
(1, 'Smartphone Motorola Moto G5 Plus', '1135.23', '15.20', '7.40', '0.70', '0.16', 'smartphone-motorola-moto-g5-plus', '2017-09-04 18:30:32'),
(2, 'Smartphone Moto Z Play', '1887.78', '14.10', '0.90', '1.16', '0.13', 'smartphone-moto-z-play', '2017-09-04 18:30:32'),
(3, 'Smartphone Samsung Galaxy J5 Pro', '1299.00', '14.60', '7.10', '0.80', '0.16', 'smartphone-samsung-galaxy-j5', '2017-09-04 18:30:32'),
(4, 'Smartphone Samsung Galaxy J7 Prime', '1149.00', '15.10', '7.50', '0.80', '0.16', 'smartphone-samsung-galaxy-j7', '2017-09-04 18:30:32'),
(5, 'Smartphone Samsung Galaxy J3 Dual', '679.90', '14.20', '7.10', '0.70', '0.14', 'smartphone-samsung-galaxy-j3', '2017-09-04 18:30:32');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_users`
--

CREATE TABLE `tb_users` (
  `iduser` int(11) NOT NULL,
  `idperson` int(11) NOT NULL,
  `deslogin` varchar(64) NOT NULL,
  `despassword` varchar(256) NOT NULL,
  `inadmin` tinyint(4) NOT NULL DEFAULT 0,
  `userdisable` int(11) DEFAULT NULL,
  `dtregister` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_users`
--

INSERT INTO `tb_users` (`iduser`, `idperson`, `deslogin`, `despassword`, `inadmin`, `userdisable`, `dtregister`) VALUES
(1, 1, 'admin', 'Disable in 2022-03-29 20:21:50', 1, 1, '2017-03-13 03:00:00'),
(7, 7, 'suporte', '$2y$12$XJWXBh.snM6OSslHSSr.2uAErgM1ziU/tjn3FkyL.3bzg4l/cX1Du', 1, NULL, '2017-03-15 16:10:27'),
(8, 8, 'aaa', 'Disable in 2022-03-29 20:21:14', 0, 1, '2017-09-04 20:43:40'),
(9, 9, 'joao@hcode.com.br', '$2y$12$Dz4iQ1CNYCGcOz9OVUoBXu7G7jnhfHcCFBj8l0kz7VPQcA2D.2Llu', 0, NULL, '2017-09-04 20:50:02'),
(10, 10, 'suporte@hcode.com.br', '$2y$12$U1J8BTm4LHRVg8s9I9icneryymudMIdS51hBeIa0w60P8D4VRSs/m', 1, NULL, '2017-09-06 14:32:15'),
(11, 11, 'phsb', 'Disable in 2022-03-29 20:22:20', 1, 1, '2022-03-29 17:17:52'),
(12, 12, 'rafaeladinelli', 'Disable in 2022-03-31 15:04:36', 1, 1, '2022-03-31 18:03:59');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_userslogs`
--

CREATE TABLE `tb_userslogs` (
  `idlog` int(11) NOT NULL,
  `iduser` int(11) NOT NULL,
  `deslog` varchar(128) NOT NULL,
  `desip` varchar(45) NOT NULL,
  `desuseragent` varchar(128) NOT NULL,
  `dessessionid` varchar(64) NOT NULL,
  `desurl` varchar(128) NOT NULL,
  `dtregister` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_userspasswordsrecoveries`
--

CREATE TABLE `tb_userspasswordsrecoveries` (
  `idrecovery` int(11) NOT NULL,
  `iduser` int(11) NOT NULL,
  `desip` varchar(45) NOT NULL,
  `dtrecovery` datetime DEFAULT NULL,
  `dtregister` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_userspasswordsrecoveries`
--

INSERT INTO `tb_userspasswordsrecoveries` (`idrecovery`, `iduser`, `desip`, `dtrecovery`, `dtregister`) VALUES
(1, 7, '127.0.0.1', NULL, '2017-03-15 16:10:59'),
(2, 7, '127.0.0.1', '2017-03-15 13:33:45', '2017-03-15 16:11:18'),
(3, 7, '127.0.0.1', '2017-03-15 13:37:35', '2017-03-15 16:37:12'),
(4, 7, '127.0.0.1', NULL, '2017-09-06 13:44:34'),
(5, 7, '127.0.0.1', '2017-09-06 10:45:54', '2017-09-06 13:45:28');

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `tb_addresses`
--
ALTER TABLE `tb_addresses`
  ADD PRIMARY KEY (`idaddress`),
  ADD KEY `fk_addresses_persons_idx` (`idperson`);

--
-- Índices para tabela `tb_carts`
--
ALTER TABLE `tb_carts`
  ADD PRIMARY KEY (`idcart`),
  ADD KEY `FK_carts_users_idx` (`iduser`);

--
-- Índices para tabela `tb_cartsproducts`
--
ALTER TABLE `tb_cartsproducts`
  ADD PRIMARY KEY (`idcartproduct`),
  ADD KEY `FK_cartsproducts_carts_idx` (`idcart`),
  ADD KEY `fk_cartsproducts_products_idx` (`idproduct`);

--
-- Índices para tabela `tb_categories`
--
ALTER TABLE `tb_categories`
  ADD PRIMARY KEY (`idcategory`);

--
-- Índices para tabela `tb_orders`
--
ALTER TABLE `tb_orders`
  ADD PRIMARY KEY (`idorder`),
  ADD KEY `FK_orders_users_idx` (`iduser`),
  ADD KEY `fk_orders_ordersstatus_idx` (`idstatus`),
  ADD KEY `fk_orders_carts_idx` (`idcart`),
  ADD KEY `fk_orders_addresses_idx` (`idaddress`);

--
-- Índices para tabela `tb_ordersstatus`
--
ALTER TABLE `tb_ordersstatus`
  ADD PRIMARY KEY (`idstatus`);

--
-- Índices para tabela `tb_persons`
--
ALTER TABLE `tb_persons`
  ADD PRIMARY KEY (`idperson`);

--
-- Índices para tabela `tb_photos`
--
ALTER TABLE `tb_photos`
  ADD PRIMARY KEY (`idphoto`);

--
-- Índices para tabela `tb_products`
--
ALTER TABLE `tb_products`
  ADD PRIMARY KEY (`idproduct`);

--
-- Índices para tabela `tb_users`
--
ALTER TABLE `tb_users`
  ADD PRIMARY KEY (`iduser`),
  ADD KEY `FK_users_persons_idx` (`idperson`);

--
-- Índices para tabela `tb_userslogs`
--
ALTER TABLE `tb_userslogs`
  ADD PRIMARY KEY (`idlog`),
  ADD KEY `fk_userslogs_users_idx` (`iduser`);

--
-- Índices para tabela `tb_userspasswordsrecoveries`
--
ALTER TABLE `tb_userspasswordsrecoveries`
  ADD PRIMARY KEY (`idrecovery`),
  ADD KEY `fk_userspasswordsrecoveries_users_idx` (`iduser`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `tb_addresses`
--
ALTER TABLE `tb_addresses`
  MODIFY `idaddress` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de tabela `tb_carts`
--
ALTER TABLE `tb_carts`
  MODIFY `idcart` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `tb_cartsproducts`
--
ALTER TABLE `tb_cartsproducts`
  MODIFY `idcartproduct` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de tabela `tb_categories`
--
ALTER TABLE `tb_categories`
  MODIFY `idcategory` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de tabela `tb_orders`
--
ALTER TABLE `tb_orders`
  MODIFY `idorder` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `tb_ordersstatus`
--
ALTER TABLE `tb_ordersstatus`
  MODIFY `idstatus` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `tb_persons`
--
ALTER TABLE `tb_persons`
  MODIFY `idperson` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de tabela `tb_photos`
--
ALTER TABLE `tb_photos`
  MODIFY `idphoto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de tabela `tb_products`
--
ALTER TABLE `tb_products`
  MODIFY `idproduct` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `tb_users`
--
ALTER TABLE `tb_users`
  MODIFY `iduser` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de tabela `tb_userslogs`
--
ALTER TABLE `tb_userslogs`
  MODIFY `idlog` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tb_userspasswordsrecoveries`
--
ALTER TABLE `tb_userspasswordsrecoveries`
  MODIFY `idrecovery` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `tb_addresses`
--
ALTER TABLE `tb_addresses`
  ADD CONSTRAINT `fk_addresses_persons` FOREIGN KEY (`idperson`) REFERENCES `tb_persons` (`idperson`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `tb_carts`
--
ALTER TABLE `tb_carts`
  ADD CONSTRAINT `fk_carts_users` FOREIGN KEY (`iduser`) REFERENCES `tb_users` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `tb_cartsproducts`
--
ALTER TABLE `tb_cartsproducts`
  ADD CONSTRAINT `fk_cartsproducts_carts` FOREIGN KEY (`idcart`) REFERENCES `tb_carts` (`idcart`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_cartsproducts_products` FOREIGN KEY (`idproduct`) REFERENCES `tb_products` (`idproduct`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `tb_orders`
--
ALTER TABLE `tb_orders`
  ADD CONSTRAINT `fk_orders_addresses` FOREIGN KEY (`idaddress`) REFERENCES `tb_addresses` (`idaddress`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_orders_carts` FOREIGN KEY (`idcart`) REFERENCES `tb_carts` (`idcart`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_orders_ordersstatus` FOREIGN KEY (`idstatus`) REFERENCES `tb_ordersstatus` (`idstatus`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_orders_users` FOREIGN KEY (`iduser`) REFERENCES `tb_users` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `tb_users`
--
ALTER TABLE `tb_users`
  ADD CONSTRAINT `fk_users_persons` FOREIGN KEY (`idperson`) REFERENCES `tb_persons` (`idperson`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `tb_userslogs`
--
ALTER TABLE `tb_userslogs`
  ADD CONSTRAINT `fk_userslogs_users` FOREIGN KEY (`iduser`) REFERENCES `tb_users` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `tb_userspasswordsrecoveries`
--
ALTER TABLE `tb_userspasswordsrecoveries`
  ADD CONSTRAINT `fk_userspasswordsrecoveries_users` FOREIGN KEY (`iduser`) REFERENCES `tb_users` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

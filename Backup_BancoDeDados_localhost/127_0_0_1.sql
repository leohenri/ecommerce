-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 07-Jun-2022 às 01:24
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
CREATE DATABASE IF NOT EXISTS `db_ecommerce` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `db_ecommerce`;

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
(8, 'Leandro', '2022-04-01 21:10:42', NULL, '2022-04-01 21:10:42'),
(9, 'Hortifruti', '2022-04-05 01:09:37', NULL, '2022-04-05 01:09:37'),
(10, 'Calçados', '2022-04-05 01:10:41', NULL, '2022-04-05 01:10:41');

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
  MODIFY `idcategory` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

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
--
-- Banco de dados: `db_exemple`
--
CREATE DATABASE IF NOT EXISTS `db_exemple` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `db_exemple`;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_example1`
--

CREATE TABLE `tb_example1` (
  `id` int(11) NOT NULL,
  `msgDB` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_example1`
--

INSERT INTO `tb_example1` (`id`, `msgDB`) VALUES
(1, 'Oba! Tudo certo com a conexão do DB. Bora programar?!'),
(2, 'Parece que você está em um loop!'),
(3, 'Esse já é o 3º registro de loop! '),
(4, 'Parabéns. 4º registro mostrado no loop!');

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
(1, 'Administrador', 'admin@email.com.br', 2147483647, '2017-03-01 06:00:00'),
(13, 'Pedro Henrique de Souza Barbosa', 'phsb@gmail.com', 3899999, '2022-04-12 20:19:01'),
(14, 'Pedro Henrique de Souza Barbosa', 'phsb@gmail.com', 3899999, '2022-04-12 20:20:27'),
(15, 'Lucas de', 'lucas@gmail.com', 6454654, '2022-04-12 20:22:16'),
(16, 'Laranja', 'laranja@gmail.com', 7878998797, '2022-04-25 23:42:29'),
(17, 'Laranja', 'laranja@gmail.com', 7878998797, '2022-04-25 23:44:20');

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
(1, 1, 'admin', '$2y$12$HQmLiCWCxDw/vb/z6TfpQe5Dp3D5rayYxdsyoORNJsFIAUeRcdLNO', 1, NULL, '2017-03-13 03:00:00'),
(2, 13, 'phsb', '170352', 1, NULL, '2022-04-12 20:19:01'),
(3, 14, 'phsb', '170352', 1, NULL, '2022-04-12 20:20:27'),
(4, 15, 'lucas', 'lucas', 1, NULL, '2022-04-12 20:22:16');

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `tb_example1`
--
ALTER TABLE `tb_example1`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `tb_persons`
--
ALTER TABLE `tb_persons`
  ADD PRIMARY KEY (`idperson`);

--
-- Índices para tabela `tb_users`
--
ALTER TABLE `tb_users`
  ADD PRIMARY KEY (`iduser`),
  ADD KEY `FK_users_persons_idx` (`idperson`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `tb_example1`
--
ALTER TABLE `tb_example1`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `tb_persons`
--
ALTER TABLE `tb_persons`
  MODIFY `idperson` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de tabela `tb_users`
--
ALTER TABLE `tb_users`
  MODIFY `iduser` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- Banco de dados: `loja`
--
CREATE DATABASE IF NOT EXISTS `loja` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `loja`;

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
(6, '26arbhs500cf3sehrivmqlv1af', NULL, NULL, NULL, NULL, '2022-05-05 16:55:41'),
(7, 'r9m9el7fli0cserla0m2p2is2c', NULL, '71065000', '188.93', 4, '2022-05-07 20:15:22');

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
(17, 6, 4, '2022-05-05 15:27:37', '2022-05-05 18:19:53'),
(18, 6, 4, '2022-05-05 15:27:39', '2022-05-05 18:25:56'),
(19, 6, 4, '2022-05-05 15:27:40', '2022-05-05 18:26:06'),
(20, 6, 4, '2022-05-05 15:27:41', '2022-05-05 18:26:26'),
(21, 6, 1, '2022-05-05 15:28:35', '2022-05-05 18:28:06'),
(22, 6, 1, '2022-05-05 15:28:35', '2022-05-05 18:28:11'),
(23, 6, 1, '2022-05-05 15:28:35', '2022-05-05 18:28:12'),
(24, 6, 1, '2022-05-05 15:28:35', '2022-05-05 18:28:13'),
(25, 6, 1, '2022-05-05 15:28:35', '2022-05-05 18:28:14'),
(26, 6, 4, '2022-05-05 17:27:00', '2022-05-05 19:11:23'),
(27, 6, 1, '2022-05-05 17:27:02', '2022-05-05 19:11:30'),
(28, 6, 1, '2022-05-05 17:27:02', '2022-05-05 19:11:45'),
(29, 6, 1, '2022-05-05 17:27:02', '2022-05-05 19:13:17'),
(30, 6, 4, '2022-05-05 17:27:00', '2022-05-05 19:13:23'),
(31, 6, 3, '2022-05-05 16:34:07', '2022-05-05 19:33:44'),
(32, 6, 3, '2022-05-05 17:27:03', '2022-05-05 19:33:44'),
(33, 6, 3, '2022-05-05 17:27:03', '2022-05-05 19:33:44'),
(34, 6, 3, '2022-05-05 17:27:03', '2022-05-05 19:33:44'),
(35, 6, 3, '2022-05-05 17:27:03', '2022-05-05 19:33:44'),
(36, 6, 2, '2022-05-05 17:27:02', '2022-05-05 19:34:35'),
(37, 6, 2, NULL, '2022-05-05 20:27:17'),
(38, 7, 2, '2022-05-07 17:30:55', '2022-05-07 20:15:53'),
(39, 7, 2, '2022-05-07 17:30:56', '2022-05-07 20:28:41'),
(40, 7, 2, '2022-05-07 17:30:58', '2022-05-07 20:29:00'),
(41, 7, 2, '2022-05-07 17:31:02', '2022-05-07 20:30:10'),
(42, 7, 2, '2022-05-07 17:33:44', '2022-05-07 20:30:35'),
(43, 7, 2, '2022-05-07 17:33:45', '2022-05-07 20:30:39'),
(44, 7, 2, '2022-05-07 17:43:14', '2022-05-07 20:30:45'),
(45, 7, 2, '2022-05-07 17:43:19', '2022-05-07 20:33:48'),
(46, 7, 2, '2022-05-07 17:43:23', '2022-05-07 20:33:49'),
(47, 7, 2, '2022-05-07 17:43:25', '2022-05-07 20:33:50'),
(48, 7, 2, '2022-05-07 17:44:22', '2022-05-07 20:33:52'),
(49, 7, 2, NULL, '2022-05-07 20:45:18'),
(50, 7, 2, NULL, '2022-05-07 20:45:26'),
(51, 7, 2, NULL, '2022-05-07 20:45:30');

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
(4, 'Teste', '2022-03-29 23:27:36', 1, '2022-04-11 19:34:10'),
(5, 'Teste 22322', '2022-03-29 23:33:05', 1, '2022-04-11 19:30:23'),
(6, 'Alimentícios', '2022-03-31 18:05:17', NULL, '2022-03-31 20:33:53'),
(7, 'Leandro', '2022-04-01 21:10:37', 1, '2022-04-11 19:34:18'),
(8, 'Leandro', '2022-04-01 21:10:42', 1, '2022-04-11 19:34:24'),
(9, 'Hortifruti', '2022-04-05 01:09:37', NULL, '2022-04-05 01:09:37'),
(10, 'Calçados', '2022-04-05 01:10:41', NULL, '2022-04-05 01:10:41'),
(11, 'Roupas Masculinas', '2022-04-11 19:28:19', NULL, '2022-04-11 19:28:19'),
(12, 'Celular', '2022-04-12 19:38:35', NULL, '2022-04-12 19:38:35');

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
(12, 1),
(12, 3),
(12, 2),
(12, 5),
(12, 4),
(1, 1);

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
(8, 'abacaxi', 'aaa@gmail.com', 5222212, '2017-09-04 20:43:40'),
(9, 'Joao', 'joao@hcode.com.br', 12345678, '2017-09-04 20:50:02'),
(10, 'Hcode', 'suporte@hcode.com.br', 1112345678, '2017-09-06 14:32:15'),
(11, 'Pedro Henrique de Souza Barbosa', 'phsb17092013@gmail.com', 389999999, '2022-03-29 17:17:52'),
(12, 'Rafaela Souza', 'rafaeladinelli@gmail.com', 389999945555, '2022-03-31 18:03:59'),
(13, 'LEANDRO HENRIQUE', 'leohenribar@gmail.com', 38999718826, '2022-04-11 17:44:24'),
(14, 'geilene cristina barbosa', 'gege@gmail.com', 389987899879, '2022-04-11 17:45:10'),
(15, 'cirene', 'cici@gmail.com', 546564546546, '2022-04-11 17:47:48'),
(16, 'geraldo se', 'gegeraldo@gmail.com', 77777, '2022-04-11 17:48:18'),
(17, 'kenia', 'kenia@gmailc.om', 978879879, '2022-04-11 17:50:20'),
(18, 'kenia', 'kenia@gmailc.om', 978879879, '2022-04-11 17:51:53'),
(19, '', '', 0, '2022-05-08 21:02:48'),
(20, '', '', 0, '2022-05-08 21:02:50'),
(21, '', '', 0, '2022-05-08 21:03:48'),
(22, '', '', 0, '2022-05-08 21:04:02'),
(23, 'Pedro Henrique', 'pedro@gmail.com', 0, '2022-05-08 21:36:20'),
(24, 'Geraldo Martins', 'gge@mar.com', 0, '2022-05-08 21:40:35');

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
(1, 'Smartphone Motorola Moto G5 Plus', '1135.23', '15.00', '7.40', '7.00', '0.16', 'smartphone-motorola-moto-g5-plus', '2017-09-04 18:30:32'),
(2, 'Smartphone Moto Z Play', '1000.00', '14.00', '9.00', '11.00', '0.13', 'smartphone-moto-z-play', '2017-09-04 18:30:32'),
(3, 'Smartphone Samsung Galaxy J5 Pro', '1299.00', '14.00', '7.10', '8.00', '0.16', 'smartphone-samsung-galaxy-j5', '2017-09-04 18:30:32'),
(4, 'Smartphone Samsung Galaxy J7 Prime', '1149.00', '15.00', '7.50', '8.00', '0.16', 'smartphone-samsung-galaxy-j7', '2017-09-04 18:30:32'),
(5, 'Smartphone Samsung Galaxy J3 Dual', '679.90', '14.00', '7.10', '7.00', '0.14', 'smartphone-samsung-galaxy-j3', '2017-09-04 18:30:32');

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
(1, 1, 'admin', '$2y$12$HQmLiCWCxDw/vb/z6TfpQe5Dp3D5rayYxdsyoORNJsFIAUeRcdLNO', 1, NULL, '2017-03-13 03:00:00'),
(7, 7, 'suporte', '$2y$12$XJWXBh.snM6OSslHSSr.2uAErgM1ziU/tjn3FkyL.3bzg4l/cX1Du', 1, NULL, '2017-03-15 16:10:27'),
(8, 8, 'abacaxi', 'Disable in 2022-03-29 20:21:14', 0, 1, '2017-09-04 20:43:40'),
(9, 9, 'joao@hcode.com.br', '$2y$12$Dz4iQ1CNYCGcOz9OVUoBXu7G7jnhfHcCFBj8l0kz7VPQcA2D.2Llu', 0, NULL, '2017-09-04 20:50:02'),
(10, 10, 'suporte@hcode.com.br', '$2y$12$U1J8BTm4LHRVg8s9I9icneryymudMIdS51hBeIa0w60P8D4VRSs/m', 1, NULL, '2017-09-06 14:32:15'),
(11, 11, 'phsb', 'Disable in 2022-03-29 20:22:20', 1, 1, '2022-03-29 17:17:52'),
(12, 12, 'rafaeladinelli', 'Disable in 2022-03-31 15:04:36', 1, 1, '2022-03-31 18:03:59'),
(13, 13, 'leohenribar', '123456', 1, NULL, '2022-04-11 17:44:24'),
(14, 14, 'gege', '213312645', 1, NULL, '2022-04-11 17:45:10'),
(15, 15, 'cici', 'ljkasdflfdas', 1, NULL, '2022-04-11 17:47:48'),
(16, 16, 'sdfklajsdf', 'Disable in 2022-04-11 15:13:37', 1, 1, '2022-04-11 17:48:18'),
(17, 18, 'kenia', 'Disable in 2022-04-11 15:13:31', 1, 1, '2022-04-11 17:51:53'),
(18, 19, '', '$2y$12$Se7ZuHCnReMjMorj1VtuqeBulZEn.wpMy2vcgrtgRR21h5hiVN9YW', 0, NULL, '2022-05-08 21:02:48'),
(19, 20, '', '$2y$12$RL5eliOFTMipMStldEOo7.EfYN5oWJGGsJXDyzelgBkSyS8GCAAfm', 0, NULL, '2022-05-08 21:02:50'),
(20, 21, '', '$2y$12$DRYTtH1OjxSSr/9Q5wbPqe94dg6qYtqkG55DgWENeYJfrEv6ZYLsO', 0, NULL, '2022-05-08 21:03:48'),
(21, 22, '', '$2y$12$LMoukOiDhLGyfCC3s/qadupI3K4TuOhUNZNr67bxchYfULpna.H8u', 0, NULL, '2022-05-08 21:04:02'),
(22, 23, 'pedro@gmail.com', '$2y$12$CO98AEJ8rhOxbPMlbeup5OKrQrQtdJKkAbmksc93CQlPYH7m3wYIm', 0, NULL, '2022-05-08 21:36:20'),
(23, 24, 'gge@mar.com', '$2y$12$5YaL1bFRmvENne7ZGpfXC.ABBZi0cTXsxU8rKSuSYQ6GFr.dQdiSm', 0, NULL, '2022-05-08 21:40:35');

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
(5, 7, '127.0.0.1', '2017-09-06 10:45:54', '2017-09-06 13:45:28'),
(6, 13, '127.0.0.1', NULL, '2022-04-11 18:42:04'),
(7, 13, '127.0.0.1', NULL, '2022-04-11 18:43:15'),
(8, 13, '127.0.0.1', NULL, '2022-04-11 18:47:21'),
(9, 13, '127.0.0.1', NULL, '2022-04-11 18:48:35'),
(10, 13, '127.0.0.1', NULL, '2022-04-11 18:52:16'),
(11, 13, '127.0.0.1', NULL, '2022-04-11 18:52:56'),
(12, 13, '127.0.0.1', NULL, '2022-04-11 18:53:31'),
(13, 13, '127.0.0.1', NULL, '2022-04-11 18:59:32');

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
  MODIFY `idcart` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de tabela `tb_cartsproducts`
--
ALTER TABLE `tb_cartsproducts`
  MODIFY `idcartproduct` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT de tabela `tb_categories`
--
ALTER TABLE `tb_categories`
  MODIFY `idcategory` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

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
  MODIFY `idperson` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de tabela `tb_photos`
--
ALTER TABLE `tb_photos`
  MODIFY `idphoto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de tabela `tb_products`
--
ALTER TABLE `tb_products`
  MODIFY `idproduct` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de tabela `tb_users`
--
ALTER TABLE `tb_users`
  MODIFY `iduser` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de tabela `tb_userslogs`
--
ALTER TABLE `tb_userslogs`
  MODIFY `idlog` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tb_userspasswordsrecoveries`
--
ALTER TABLE `tb_userspasswordsrecoveries`
  MODIFY `idrecovery` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

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
--
-- Banco de dados: `rosario`
--
CREATE DATABASE IF NOT EXISTS `rosario` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `rosario`;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_example1`
--

CREATE TABLE `tb_example1` (
  `id` int(11) NOT NULL,
  `msgDB` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_example1`
--

INSERT INTO `tb_example1` (`id`, `msgDB`) VALUES
(1, 'BD rosario'),
(2, 'Parece que você está em um loop!'),
(3, 'Esse já é o 3º registro de loop! '),
(4, 'Parabéns. 4º registro mostrado no loop!');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_oration`
--

CREATE TABLE `tb_oration` (
  `idoration` int(11) NOT NULL,
  `nameoration` varchar(255) NOT NULL,
  `router` varchar(255) NOT NULL,
  `desoration` text NOT NULL,
  `datelast` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_oration`
--

INSERT INTO `tb_oration` (`idoration`, `nameoration`, `router`, `desoration`, `datelast`) VALUES
(1, 'Pelo sinal da Santa Cruz', 'pelo-sinal-da-santa-cruz', 'Pelo sinal da Santa Cruz,\r\nlivrai-nos, Deus, Nosso Senhor, \r\ndos nossos inimigos.', '2022-04-14 00:03:51'),
(2, 'Em nome do Pai', 'em-nome-do-pai', 'Em nome do Pai, do Filho e do Espirito Santo.\r\nAmém.', '2022-04-14 00:03:51'),
(3, 'Oferecimento do Terço (Rosário)', 'oferecimento-do-terco-rosario', 'Divino Jesus, eu vos ofereço este terço (Rosário) que vou rezar, contemplando os mistérios de nossa Redenção. Concedei-me, pela intercessão de Maria, vossa Mãe Santíssima, a quem me dirijo, as graças necessárias para bem rezá-lo para ganhar as indulgências desta santa devoção.', '2022-04-14 00:06:56'),
(4, 'Creio em Deus Pai', 'creio-em-deus-pai', 'Creio em Deus Pai, todo-poderoso\r\nCriador do céu e da terra,\r\nCreio em Jesus Cristo, nosso Senhor,\r\nO qual foi concebido pelo poder do Espírito Santo,\r\nNasceu da Virgem Maria,\r\nPadeceu sob o poder de Pôncio Pilatos,\r\nFoi crucificado, morto e sepultado,\r\nDesceu a mansão dos mortos\r\nRessuscitou ao terceiro dia\r\nSubiu aos céus,\r\nEstá sentado à direita de Deus Pai,\r\nE, de onde há de vir julgar os vivos e os mortos.\r\nCreio no Espírito Santo\r\nNa Santa Igreja Católica,\r\nNa Comunhão dos Santos,\r\nNa remissão dos pecados,\r\nNa vida eterna, amém.', '2022-04-13 22:39:55'),
(5, 'Pai Nosso', 'pai-nosso', 'Pai Nosso, que estais no céu, \r\nsantificado seja o Vosso Nome, \r\nvenha a nós o Vosso Reino, \r\nseja feita a Vossa Vontade, \r\nassim na terra como no céu. \r\n\r\nO pão nosso de cada dia nos dai hoje,\r\nperdoai-nos as nossas ofensas, \r\nassim como nós perdoamos a quem nos tenha ofendido. \r\nE não nos deixeis cair em tentação, \r\nmas livrai-nos do mal. \r\nAmém.', '2022-04-13 23:33:52'),
(6, 'Ave Maria', 'ave-maria', 'Ave Maria,  cheia de graça, \r\no Senhor é convosco. \r\nBendita sois Vós entre as mulheres, \r\nbendito é o fruto de Vosso ventre, Jesus. \r\nSanta Maria, Mãe de Deus, \r\nrogai por nós, pecadores, \r\nagora e na hora de nossa morte. \r\nAmém. ', '2022-04-13 23:37:04'),
(7, 'Glória ao Pai', 'gloria-ao-pai', 'Glória ao Pai e ao Filho \r\ne ao Espírito Santo. \r\nComo era, no princípio, \r\nagora e sempre. \r\nAmém.', '2022-04-14 20:46:24'),
(8, 'Ó meu Jesus, perdoai-nos', 'o-meu-jesus-perdoai', 'Ó meu Jesus, perdoai-nos, livrai-nos do fogo do inferno, levai as almas todas para o Céu e socorrei principalmente aquelas que mais precisarem', '2022-04-14 20:49:39'),
(9, '1º Mistério Gozozo', '1-misterio-gozozo', 'A Anunciação do Anjo à Nossa Senhora.\r\n\r\nLc 1, 26-27\r\nNaquele tempo, o anjo Gabriel foi enviado por Deus a uma cidade da Galileia, chamada Nazaré, a uma virgem, prometida em casamento a um homem chamado José. Ele era descendente de Davi e o nome da virgem era Maria.\r\n\r\nSenhor, honramos a Vossa Encarnação no seio de Maria. Vos pedimos e à Mãe Santíssima, humildade e espírito de oração.\r\n\r\nA Anunciação a Maria inaugura a «plenitude dos tempos» (Gl 4, 4), isto é, o cumprimento das promessas e das preparações. (CIC, 484)', '2022-04-14 20:46:24'),
(10, '2º Ministério Gozozo', '2-misterior-gozozo', 'A Visitação de Nossa Senhora à Santa Isabel.\r\n\r\nLc 1, 39-42\r\nNaqueles dias, Maria partiu para a região montanhosa, dirigindo-se, apressadamente, a uma cidade da Judeia. Entrou na casa de Zacarias e cumprimentou Isabel. Quando Isabel ouviu a saudação de Maria, a criança pulou no seu ventre e Isabel ficou cheia do Espírito Santo. Com um grande grito, exclamou: “Bendita és tu entre as mulheres e bendito é o fruto do teu ventre!”\r\n\r\nSenhor, honramos a visitação de Vossa Mãe à prima Isabel. Vos pedimos e à Mãe Santíssima, a caridade para com o próximo.\r\n\r\nA «visitação» de Maria a Isabel tornou-se, assim, «visita de Deus ao seu povo» (CIC, 717)', '2022-04-17 00:25:10'),
(11, '3º Mistério Gozozo', '3-misterio-gozozo', '3-misterio-gozozo', '0000-00-00 00:00:00'),
(12, '4º Mistério Gozozo', '4-misterio-gozozo', '4-misterio-gozozo', '0000-00-00 00:00:00'),
(13, '5º Mistério Gozozo', '5-misterio-gozozo', '5-misterio-gozozo', '0000-00-00 00:00:00'),
(14, '1º Mistério Luminoso', '1-misterio-luminoso', '1-misterio-luminoso', '0000-00-00 00:00:00'),
(15, '2º Mistério Luminoso', '2-misterio-luminoso', '2-misterio-luminoso', '0000-00-00 00:00:00'),
(16, '3º Mistério Luminoso', '3-misterio-luminoso', '3-misterio-luminoso', '0000-00-00 00:00:00'),
(17, '4º Mistério Luminoso', '4-misterio-luminoso', '4-misterio-luminoso', '0000-00-00 00:00:00'),
(18, '5º Mistério Luminoso', '5-misterio-luminoso', '5-misterio-luminoso', '0000-00-00 00:00:00'),
(19, '1º Mistério Doloroso', '1-misterio-doloroso', '1-misterio-doloroso', '0000-00-00 00:00:00'),
(20, '2º Mistério Doloroso', '2-misterio-doloroso', '2-misterio-doloroso', '0000-00-00 00:00:00'),
(21, '3º Mistério Doloroso', '3-misterio-doloroso', '3-misterio-doloroso', '0000-00-00 00:00:00'),
(22, '4º Mistério Doloroso', '4-misterio-doloroso', '4-misterio-doloroso', '0000-00-00 00:00:00'),
(23, '5º Mistério Doloroso', '5-misterio-doloroso', '5-misterio-doloroso', '0000-00-00 00:00:00'),
(24, '1º Mistério Glorioso', '1-misterio-glorioso', '1-misterio-glorioso', '0000-00-00 00:00:00'),
(25, '2º Mistério Glorioso', '2-misterio-glorioso', '2-misterio-glorioso', '0000-00-00 00:00:00'),
(26, '3º Mistério Glorioso', '3-misterio-glorioso', '3-misterio-glorioso', '0000-00-00 00:00:00'),
(27, '4º Mistério Glorioso', '4-misterio-glorioso', '4-misterio-glorioso', '0000-00-00 00:00:00'),
(28, '5º Mistério Glorioso', '5-misterio-glorioso', '5-misterio-glorioso', '0000-00-00 00:00:00'),
(29, 'Agradecimento', 'agradecimento', 'agradecimento', '0000-00-00 00:00:00'),
(30, 'Salve a Rainha', 'salva-a-rainha', 'salva-a-rainha', '0000-00-00 00:00:00');

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
(1, 'Administrador', 'admin@email.com.br', 2147483647, '2017-03-01 06:00:00'),
(13, 'Pedro Henrique de Souza Barbosa', 'phsb@gmail.com', 3899999, '2022-04-12 20:19:01'),
(14, 'Pedro Henrique de Souza Barbosa', 'phsb@gmail.com', 3899999, '2022-04-12 20:20:27'),
(15, 'Lucas de', 'lucas@gmail.com', 6454654, '2022-04-12 20:22:16');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_rosario`
--

CREATE TABLE `tb_rosario` (
  `id` int(11) NOT NULL,
  `ordem` int(11) DEFAULT NULL,
  `idoration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tb_rosario`
--

INSERT INTO `tb_rosario` (`id`, `ordem`, `idoration`) VALUES
(1, NULL, 1),
(2, NULL, 2),
(3, NULL, 3),
(4, NULL, 4),
(5, NULL, 5),
(6, 1, 6),
(7, 2, 6),
(8, 3, 6),
(9, NULL, 7),
(10, NULL, 9),
(11, NULL, 5),
(12, 1, 6),
(13, 2, 6),
(14, 3, 6),
(15, 4, 6),
(16, 5, 6),
(17, 6, 6),
(18, 7, 6),
(19, 8, 6),
(20, 9, 6),
(21, 10, 6),
(22, NULL, 7),
(23, NULL, 8),
(24, NULL, 10),
(25, NULL, 5),
(26, 1, 6),
(27, 2, 6),
(28, 3, 6),
(29, 4, 6),
(30, 5, 6),
(31, 6, 6),
(32, 7, 6),
(33, 8, 6),
(34, 9, 6),
(35, 10, 6),
(36, NULL, 7),
(37, NULL, 8),
(38, NULL, 11),
(39, NULL, 5),
(40, 1, 6),
(41, 2, 6),
(42, 3, 6),
(43, 4, 6),
(44, 5, 6),
(45, 6, 6),
(46, 7, 6),
(47, 8, 6),
(48, 9, 6),
(49, 10, 6),
(50, NULL, 7),
(51, NULL, 8),
(52, NULL, 12),
(53, NULL, 5),
(54, 1, 6),
(55, 2, 6),
(56, 3, 6),
(57, 4, 6),
(58, 5, 6),
(59, 6, 6),
(60, 7, 6),
(61, 8, 6),
(62, 9, 6),
(63, 10, 6),
(64, NULL, 7),
(65, NULL, 8),
(66, NULL, 13),
(67, NULL, 5),
(68, 1, 6),
(69, 2, 6),
(70, 3, 6),
(71, 4, 6),
(72, 5, 6),
(73, 6, 6),
(74, 7, 6),
(75, 8, 6),
(76, 9, 6),
(77, 10, 6),
(78, NULL, 7),
(79, NULL, 8),
(80, NULL, 14),
(81, NULL, 5),
(82, 1, 6),
(83, 2, 6),
(84, 3, 6),
(85, 4, 6),
(86, 5, 6),
(87, 6, 6),
(88, 7, 6),
(89, 8, 6),
(90, 9, 6),
(91, 10, 6),
(92, NULL, 7),
(93, NULL, 8),
(94, NULL, 15),
(95, NULL, 5),
(96, 1, 6),
(97, 2, 6),
(98, 3, 6),
(99, 4, 6),
(100, 5, 6),
(101, 6, 6),
(102, 7, 6),
(103, 8, 6),
(104, 9, 6),
(105, 10, 6),
(106, NULL, 7),
(107, NULL, 8),
(108, NULL, 16),
(109, NULL, 5),
(110, 1, 6),
(111, 2, 6),
(112, 3, 6),
(113, 4, 6),
(114, 5, 6),
(115, 6, 6),
(116, 7, 6),
(117, 8, 6),
(118, 9, 6),
(119, 10, 6),
(120, NULL, 7),
(121, NULL, 8),
(122, NULL, 17),
(123, NULL, 5),
(124, 1, 6),
(125, 2, 6),
(126, 3, 6),
(127, 4, 6),
(128, 5, 6),
(129, 6, 6),
(130, 7, 6),
(131, 8, 6),
(132, 9, 6),
(133, 10, 6),
(134, NULL, 7),
(135, NULL, 8),
(136, NULL, 18),
(137, NULL, 5),
(138, 1, 6),
(139, 2, 6),
(140, 3, 6),
(141, 4, 6),
(142, 5, 6),
(143, 6, 6),
(144, 7, 6),
(145, 8, 6),
(146, 9, 6),
(147, 10, 6),
(148, NULL, 7),
(149, NULL, 8),
(150, NULL, 19),
(151, NULL, 5),
(152, 1, 6),
(153, 2, 6),
(154, 3, 6),
(155, 4, 6),
(156, 5, 6),
(157, 6, 6),
(158, 7, 6),
(159, 8, 6),
(160, 9, 6),
(161, 10, 6),
(162, NULL, 7),
(163, NULL, 8),
(164, NULL, 20),
(165, NULL, 5),
(166, 1, 6),
(167, 2, 6),
(168, 3, 6),
(169, 4, 6),
(170, 5, 6),
(171, 6, 6),
(172, 7, 6),
(173, 8, 6),
(174, 9, 6),
(175, 10, 6),
(176, NULL, 7),
(177, NULL, 8),
(178, NULL, 21),
(179, NULL, 5),
(180, 1, 6),
(181, 2, 6),
(182, 3, 6),
(183, 4, 6),
(184, 5, 6),
(185, 6, 6),
(186, 7, 6),
(187, 8, 6),
(188, 9, 6),
(189, 10, 6),
(190, NULL, 7),
(191, NULL, 8),
(192, NULL, 22),
(193, NULL, 5),
(194, 1, 6),
(195, 2, 6),
(196, 3, 6),
(197, 4, 6),
(198, 5, 6),
(199, 6, 6),
(200, 7, 6),
(201, 8, 6),
(202, 9, 6),
(203, 10, 6),
(204, NULL, 7),
(205, NULL, 8),
(206, NULL, 23),
(207, NULL, 5),
(208, 1, 6),
(209, 2, 6),
(210, 3, 6),
(211, 4, 6),
(212, 5, 6),
(213, 6, 6),
(214, 7, 6),
(215, 8, 6),
(216, 9, 6),
(217, 10, 6),
(218, NULL, 7),
(219, NULL, 8),
(220, NULL, 24),
(221, NULL, 5),
(222, 1, 6),
(223, 2, 6),
(224, 3, 6),
(225, 4, 6),
(226, 5, 6),
(227, 6, 6),
(228, 7, 6),
(229, 8, 6),
(230, 9, 6),
(231, 10, 6),
(232, NULL, 7),
(233, NULL, 8),
(234, NULL, 25),
(235, NULL, 5),
(236, 1, 6),
(237, 2, 6),
(238, 3, 6),
(239, 4, 6),
(240, 5, 6),
(241, 6, 6),
(242, 7, 6),
(243, 8, 6),
(244, 9, 6),
(245, 10, 6),
(246, NULL, 7),
(247, NULL, 8),
(248, NULL, 26),
(249, NULL, 5),
(250, 1, 6),
(251, 2, 6),
(252, 3, 6),
(253, 4, 6),
(254, 5, 6),
(255, 6, 6),
(256, 7, 6),
(257, 8, 6),
(258, 9, 6),
(259, 10, 6),
(260, NULL, 7),
(261, NULL, 8),
(262, NULL, 27),
(263, NULL, 5),
(264, 1, 6),
(265, 2, 6),
(266, 3, 6),
(267, 4, 6),
(268, 5, 6),
(269, 6, 6),
(270, 7, 6),
(271, 8, 6),
(272, 9, 6),
(273, 10, 6),
(274, NULL, 7),
(275, NULL, 8),
(276, NULL, 28),
(277, NULL, 5),
(278, 1, 6),
(279, 2, 6),
(280, 3, 6),
(281, 4, 6),
(282, 5, 6),
(283, 6, 6),
(284, 7, 6),
(285, 8, 6),
(286, 9, 6),
(287, 10, 6),
(288, NULL, 29),
(289, NULL, 30);

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
(1, 1, 'admin', '$2y$12$HQmLiCWCxDw/vb/z6TfpQe5Dp3D5rayYxdsyoORNJsFIAUeRcdLNO', 1, NULL, '2017-03-13 03:00:00'),
(2, 13, 'phsb', '170352', 1, NULL, '2022-04-12 20:19:01'),
(3, 14, 'phsb', '170352', 1, NULL, '2022-04-12 20:20:27'),
(4, 15, 'lucas', 'lucas', 1, NULL, '2022-04-12 20:22:16');

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `tb_example1`
--
ALTER TABLE `tb_example1`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `tb_oration`
--
ALTER TABLE `tb_oration`
  ADD PRIMARY KEY (`idoration`);

--
-- Índices para tabela `tb_persons`
--
ALTER TABLE `tb_persons`
  ADD PRIMARY KEY (`idperson`);

--
-- Índices para tabela `tb_rosario`
--
ALTER TABLE `tb_rosario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rb_rosario_oration_idx` (`idoration`);

--
-- Índices para tabela `tb_users`
--
ALTER TABLE `tb_users`
  ADD PRIMARY KEY (`iduser`),
  ADD KEY `FK_users_persons_idx` (`idperson`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `tb_example1`
--
ALTER TABLE `tb_example1`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `tb_oration`
--
ALTER TABLE `tb_oration`
  MODIFY `idoration` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de tabela `tb_persons`
--
ALTER TABLE `tb_persons`
  MODIFY `idperson` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de tabela `tb_rosario`
--
ALTER TABLE `tb_rosario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=290;

--
-- AUTO_INCREMENT de tabela `tb_users`
--
ALTER TABLE `tb_users`
  MODIFY `iduser` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `tb_rosario`
--
ALTER TABLE `tb_rosario`
  ADD CONSTRAINT `tb_rosario_oration` FOREIGN KEY (`idoration`) REFERENCES `tb_oration` (`idoration`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

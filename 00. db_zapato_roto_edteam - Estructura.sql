-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 05-06-2020 a las 22:53:07
-- Versión del servidor: 10.4.11-MariaDB
-- Versión de PHP: 7.4.6

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `db_zapato_roto_edteam`
--
CREATE DATABASE IF NOT EXISTS `db_zapato_roto_edteam` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `db_zapato_roto_edteam`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--
-- Creación: 06-06-2020 a las 03:42:26
--

DROP TABLE IF EXISTS `clientes`;
CREATE TABLE IF NOT EXISTS `clientes` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `identificacion` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Identificación del cliente\nNOTA: Por dentificación, no sabía si se refería a un documento identificador o número único',
  `nombre` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Nombre del cliente',
  `paises_id` int(11) NOT NULL COMMENT 'Id del país',
  `dt_creacion` datetime NOT NULL DEFAULT current_timestamp() COMMENT 'Fecha de creación del registro',
  PRIMARY KEY (`id`),
  KEY `fk_clientes_paises_1_idx` (`paises_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Lista de clientes';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturas`
--
-- Creación: 06-06-2020 a las 03:16:15
--

DROP TABLE IF EXISTS `facturas`;
CREATE TABLE IF NOT EXISTS `facturas` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `clientes_id` int(11) NOT NULL COMMENT 'Id del cliente',
  `descuento` decimal(12,2) NOT NULL DEFAULT 0.00 COMMENT 'Descuento',
  `subtotal` decimal(12,2) NOT NULL COMMENT 'Subtotal de la factura (Suma total de los productos adquiridos sin impuestos)',
  `impuestos` decimal(12,2) NOT NULL COMMENT 'Total de impuestos',
  `total` decimal(12,2) NOT NULL COMMENT 'Total de la factura',
  `dt_creacion` datetime NOT NULL DEFAULT current_timestamp() COMMENT 'Fecha de creación del registro / Fecha de facturación',
  PRIMARY KEY (`id`),
  KEY `fk_facturas_clientes_1_idx` (`clientes_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Lista de facturas';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura_productos`
--
-- Creación: 06-06-2020 a las 03:10:46
--

DROP TABLE IF EXISTS `factura_productos`;
CREATE TABLE IF NOT EXISTS `factura_productos` (
  `facturas_id` int(11) NOT NULL COMMENT 'Id de la factura',
  `productos_id` int(11) NOT NULL COMMENT 'Id del producto',
  `cantidad` int(11) NOT NULL COMMENT 'Cantidad de productos',
  `precio_unitario` decimal(12,2) NOT NULL COMMENT 'Precio unitario del producto.\nAl momento de guardar la facturación, se persiste el valor del producto a fin de evitar la alteración del histórico',
  `impuesto_unitario` decimal(12,2) NOT NULL DEFAULT 0.00 COMMENT 'Impuesto unitario del producto.\nAl momento de guardar la facturación, se persiste el valor del producto a fin de evitar la alteración del histórico',
  `dt_creacion` datetime NOT NULL DEFAULT current_timestamp() COMMENT 'Fecha de creación del registro',
  PRIMARY KEY (`facturas_id`,`productos_id`),
  KEY `fk_factura_productos_productos_1_idx` (`productos_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Lista de productos asociados a la factura';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--
-- Creación: 06-06-2020 a las 03:18:21
--

DROP TABLE IF EXISTS `inventario`;
CREATE TABLE IF NOT EXISTS `inventario` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `productos_id` int(11) NOT NULL COMMENT 'Id del producto',
  `tipo_movimiento` enum('entrada','salida') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Tipo de movimiento',
  `fecha` date NOT NULL COMMENT 'Fecha del movimiento',
  `dt_creacion` datetime NOT NULL DEFAULT current_timestamp() COMMENT 'Fecha de creación del registro',
  PRIMARY KEY (`id`),
  KEY `fk_inventario_productos_1_idx` (`productos_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Listado de movimientos de productos en inventario';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paises`
--
-- Creación: 06-06-2020 a las 03:28:52
-- Última actualización: 06-06-2020 a las 03:28:35
--

DROP TABLE IF EXISTS `paises`;
CREATE TABLE IF NOT EXISTS `paises` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `nombre` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Nombre del país',
  `dt_creacion` datetime NOT NULL DEFAULT current_timestamp() COMMENT 'Fecha de creación del registro',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Países';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--
-- Creación: 06-06-2020 a las 03:50:53
-- Última actualización: 05-06-2020 a las 23:39:33
--

DROP TABLE IF EXISTS `productos`;
CREATE TABLE IF NOT EXISTS `productos` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `nombre` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Nombre del producto',
  `presentacion` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Descripción/Presentación del producto',
  `precio` decimal(12,2) NOT NULL COMMENT 'Precio del producto',
  `dt_creacion` datetime NOT NULL DEFAULT current_timestamp() COMMENT 'Fecha de creación del registro',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Lista de productos';

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD CONSTRAINT `fk_clientes_paises_1` FOREIGN KEY (`paises_id`) REFERENCES `paises` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `facturas`
--
ALTER TABLE `facturas`
  ADD CONSTRAINT `fk_facturas_clientes_1` FOREIGN KEY (`clientes_id`) REFERENCES `clientes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `factura_productos`
--
ALTER TABLE `factura_productos`
  ADD CONSTRAINT `fk_factura_productos_facturas_1` FOREIGN KEY (`facturas_id`) REFERENCES `facturas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_factura_productos_productos_1` FOREIGN KEY (`productos_id`) REFERENCES `productos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD CONSTRAINT `fk_inventario_productos_1` FOREIGN KEY (`productos_id`) REFERENCES `productos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;


--
-- Metadatos
--
USE `phpmyadmin`;

--
-- Metadatos para la tabla clientes
--

--
-- Metadatos para la tabla facturas
--

--
-- Metadatos para la tabla factura_productos
--

--
-- Metadatos para la tabla inventario
--

--
-- Metadatos para la tabla paises
--

--
-- Metadatos para la tabla productos
--

--
-- Metadatos para la base de datos db_zapato_roto_edteam
--
SET FOREIGN_KEY_CHECKS=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

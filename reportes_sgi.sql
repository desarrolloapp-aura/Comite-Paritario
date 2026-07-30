-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 30-07-2026 a las 21:11:24
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `reportes_sgi`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app_reportes_inspeccioncabecera`
--

CREATE TABLE `app_reportes_inspeccioncabecera` (
  `id` int(11) NOT NULL,
  `codigo` varchar(50) NOT NULL,
  `revision` int(11) NOT NULL,
  `tipo_inspeccion` varchar(20) NOT NULL,
  `faena` varchar(150) NOT NULL,
  `lugar` varchar(250) NOT NULL,
  `fecha_inspeccion` date DEFAULT NULL,
  `hora_inspeccion` time(6) DEFAULT NULL,
  `realizada_por` varchar(150) NOT NULL,
  `notificado_a` varchar(150) NOT NULL,
  `fecha_creacion` datetime(6) NOT NULL,
  `hora_creacion` time(6) NOT NULL,
  `correo_usuario_creador` varchar(50) NOT NULL,
  `firma_responsable` varchar(100) DEFAULT NULL,
  `token` char(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app_reportes_iteminspeccion`
--

CREATE TABLE `app_reportes_iteminspeccion` (
  `id` int(11) NOT NULL,
  `numero_item` int(10) UNSIGNED NOT NULL CHECK (`numero_item` >= 0),
  `observaciones` longtext NOT NULL,
  `grado_riesgo` varchar(1) NOT NULL,
  `recomendaciones` longtext NOT NULL,
  `responsable_accion` varchar(150) NOT NULL,
  `fecha_cumplimiento` date NOT NULL,
  `cumplimiento` varchar(10) NOT NULL,
  `evidencia_cierre` varchar(100) DEFAULT NULL,
  `fecha_cierre` datetime(6) DEFAULT NULL,
  `inspeccion_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app_reportes_iteminspeccionevidencia`
--

CREATE TABLE `app_reportes_iteminspeccionevidencia` (
  `id` int(11) NOT NULL,
  `archivo` varchar(100) NOT NULL,
  `fecha_subida` datetime(6) NOT NULL,
  `item_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app_reportes_itemobsconductaevidencia`
--

CREATE TABLE `app_reportes_itemobsconductaevidencia` (
  `id` int(11) NOT NULL,
  `archivo` varchar(100) NOT NULL,
  `fecha_subida` datetime(6) NOT NULL,
  `item_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app_reportes_itemobservacionconducta`
--

CREATE TABLE `app_reportes_itemobservacionconducta` (
  `id` int(11) NOT NULL,
  `numero_item` int(10) UNSIGNED NOT NULL CHECK (`numero_item` >= 0),
  `analisis_causa` longtext NOT NULL,
  `acciones_correctivas` longtext NOT NULL,
  `responsable` varchar(200) NOT NULL,
  `fecha_cumplimiento` date NOT NULL,
  `cumplimiento` varchar(10) NOT NULL,
  `observacion_conducta_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app_reportes_observacionconducta`
--

CREATE TABLE `app_reportes_observacionconducta` (
  `id` int(11) NOT NULL,
  `area_trabajo` varchar(250) NOT NULL,
  `persona_observada` varchar(200) NOT NULL,
  `fecha_observacion` date NOT NULL,
  `descripcion_tarea` longtext NOT NULL,
  `observacion` longtext NOT NULL,
  `antiguedad_puesto` varchar(100) DEFAULT NULL,
  `tarea` varchar(250) NOT NULL,
  `observacion_planificada` varchar(20) NOT NULL,
  `mejora` varchar(20) NOT NULL,
  `fecha_creacion` datetime(6) NOT NULL,
  `hora_creacion` time(6) NOT NULL,
  `nombre_usuario_creador` varchar(150) NOT NULL,
  `correo_usuario_creador` varchar(50) NOT NULL,
  `firma_creador` varchar(100) DEFAULT NULL,
  `firma_observado` varchar(100) DEFAULT NULL,
  `token` char(32) NOT NULL,
  `fecha_exportado` datetime(6) DEFAULT NULL,
  `hora_exportado` time(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app_reportes_reportehsgi`
--

CREATE TABLE `app_reportes_reportehsgi` (
  `id` int(11) NOT NULL,
  `cargo` varchar(150) NOT NULL,
  `centro_trabajo` varchar(150) NOT NULL,
  `fecha_hallazgo` date NOT NULL,
  `hora_hallazgo` time(6) NOT NULL,
  `turno` varchar(50) NOT NULL,
  `proceso_hallazgo` varchar(250) NOT NULL,
  `actividad_involucrada` varchar(250) NOT NULL,
  `lugar_especifico` varchar(250) NOT NULL,
  `ambito_hallazgo` varchar(250) NOT NULL,
  `causa` longtext NOT NULL,
  `nivel_hallazgo` varchar(50) NOT NULL,
  `supervisor_hallazgo` varchar(150) NOT NULL,
  `fecha_cierre` date DEFAULT NULL,
  `descripcion_hallazgo` longtext NOT NULL,
  `accion_inmediata` longtext NOT NULL,
  `responsable_cierre` varchar(150) NOT NULL,
  `estado_cierre` varchar(10) NOT NULL,
  `evidencia_cierre` varchar(100) DEFAULT NULL,
  `fecha_creacion` datetime(6) NOT NULL,
  `hora_creacion` time(6) NOT NULL,
  `fecha_exportado` datetime(6) DEFAULT NULL,
  `hora_exportado` time(6) DEFAULT NULL,
  `nombre_usuario_creador` varchar(150) NOT NULL,
  `correo_usuario_creador` varchar(50) NOT NULL,
  `token` char(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app_reportes_reportehsgievidencia`
--

CREATE TABLE `app_reportes_reportehsgievidencia` (
  `id` int(11) NOT NULL,
  `archivo` varchar(100) NOT NULL,
  `fecha_subida` datetime(6) NOT NULL,
  `reporte_hsgi_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app_reportes_usuario`
--

CREATE TABLE `app_reportes_usuario` (
  `id` int(11) NOT NULL,
  `correo` longtext NOT NULL,
  `counter` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add Inspección (Cabecera)', 7, 'add_inspeccioncabecera'),
(26, 'Can change Inspección (Cabecera)', 7, 'change_inspeccioncabecera'),
(27, 'Can delete Inspección (Cabecera)', 7, 'delete_inspeccioncabecera'),
(28, 'Can view Inspección (Cabecera)', 7, 'view_inspeccioncabecera'),
(29, 'Can add Ítem de Inspección', 8, 'add_iteminspeccion'),
(30, 'Can change Ítem de Inspección', 8, 'change_iteminspeccion'),
(31, 'Can delete Ítem de Inspección', 8, 'delete_iteminspeccion'),
(32, 'Can view Ítem de Inspección', 8, 'view_iteminspeccion'),
(33, 'Can add Observación de Conducta', 9, 'add_observacionconducta'),
(34, 'Can change Observación de Conducta', 9, 'change_observacionconducta'),
(35, 'Can delete Observación de Conducta', 9, 'delete_observacionconducta'),
(36, 'Can view Observación de Conducta', 9, 'view_observacionconducta'),
(37, 'Can add Reporte HSGI', 10, 'add_reportehsgi'),
(38, 'Can change Reporte HSGI', 10, 'change_reportehsgi'),
(39, 'Can delete Reporte HSGI', 10, 'delete_reportehsgi'),
(40, 'Can view Reporte HSGI', 10, 'view_reportehsgi'),
(41, 'Can add usuario', 11, 'add_usuario'),
(42, 'Can change usuario', 11, 'change_usuario'),
(43, 'Can delete usuario', 11, 'delete_usuario'),
(44, 'Can view usuario', 11, 'view_usuario'),
(45, 'Can add Evidencia de Reporte HSGI', 12, 'add_reportehsgievidencia'),
(46, 'Can change Evidencia de Reporte HSGI', 12, 'change_reportehsgievidencia'),
(47, 'Can delete Evidencia de Reporte HSGI', 12, 'delete_reportehsgievidencia'),
(48, 'Can view Evidencia de Reporte HSGI', 12, 'view_reportehsgievidencia'),
(49, 'Can add Ítem de Observación de Conducta', 13, 'add_itemobservacionconducta'),
(50, 'Can change Ítem de Observación de Conducta', 13, 'change_itemobservacionconducta'),
(51, 'Can delete Ítem de Observación de Conducta', 13, 'delete_itemobservacionconducta'),
(52, 'Can view Ítem de Observación de Conducta', 13, 'view_itemobservacionconducta'),
(53, 'Can add Evidencia de Ítem (Observación de Conducta)', 14, 'add_itemobsconductaevidencia'),
(54, 'Can change Evidencia de Ítem (Observación de Conducta)', 14, 'change_itemobsconductaevidencia'),
(55, 'Can delete Evidencia de Ítem (Observación de Conducta)', 14, 'delete_itemobsconductaevidencia'),
(56, 'Can view Evidencia de Ítem (Observación de Conducta)', 14, 'view_itemobsconductaevidencia'),
(57, 'Can add Evidencia de Ítem (Inspección)', 15, 'add_iteminspeccionevidencia'),
(58, 'Can change Evidencia de Ítem (Inspección)', 15, 'change_iteminspeccionevidencia'),
(59, 'Can delete Evidencia de Ítem (Inspección)', 15, 'delete_iteminspeccionevidencia'),
(60, 'Can view Evidencia de Ítem (Inspección)', 15, 'view_iteminspeccionevidencia');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$600000$NqWukzf1HYCARVO9kLFc8g$lxRlkhxyI0PI3a50sF/qyiDxW0rAI0BRgqP2quANK3I=', NULL, 1, 'usuario', '', '', 'desarrolloapp@aura.cl', 1, 1, '2026-07-30 19:09:43.127712');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(7, 'app_reportes', 'inspeccioncabecera'),
(8, 'app_reportes', 'iteminspeccion'),
(15, 'app_reportes', 'iteminspeccionevidencia'),
(14, 'app_reportes', 'itemobsconductaevidencia'),
(13, 'app_reportes', 'itemobservacionconducta'),
(9, 'app_reportes', 'observacionconducta'),
(10, 'app_reportes', 'reportehsgi'),
(12, 'app_reportes', 'reportehsgievidencia'),
(11, 'app_reportes', 'usuario'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2026-07-30 19:09:14.239277'),
(2, 'auth', '0001_initial', '2026-07-30 19:09:15.773816'),
(3, 'admin', '0001_initial', '2026-07-30 19:09:16.141813'),
(4, 'admin', '0002_logentry_remove_auto_add', '2026-07-30 19:09:16.159754'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2026-07-30 19:09:16.170620'),
(6, 'app_reportes', '0001_initial', '2026-07-30 19:09:17.229936'),
(7, 'contenttypes', '0002_remove_content_type_name', '2026-07-30 19:09:17.385659'),
(8, 'auth', '0002_alter_permission_name_max_length', '2026-07-30 19:09:17.520232'),
(9, 'auth', '0003_alter_user_email_max_length', '2026-07-30 19:09:17.566031'),
(10, 'auth', '0004_alter_user_username_opts', '2026-07-30 19:09:17.572537'),
(11, 'auth', '0005_alter_user_last_login_null', '2026-07-30 19:09:17.762445'),
(12, 'auth', '0006_require_contenttypes_0002', '2026-07-30 19:09:17.771727'),
(13, 'auth', '0007_alter_validators_add_error_messages', '2026-07-30 19:09:17.791766'),
(14, 'auth', '0008_alter_user_username_max_length', '2026-07-30 19:09:17.828535'),
(15, 'auth', '0009_alter_user_last_name_max_length', '2026-07-30 19:09:17.864335'),
(16, 'auth', '0010_alter_group_name_max_length', '2026-07-30 19:09:17.905225'),
(17, 'auth', '0011_update_proxy_permissions', '2026-07-30 19:09:17.932981'),
(18, 'auth', '0012_alter_user_first_name_max_length', '2026-07-30 19:09:17.965825'),
(19, 'sessions', '0001_initial', '2026-07-30 19:09:18.063107');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `app_reportes_inspeccioncabecera`
--
ALTER TABLE `app_reportes_inspeccioncabecera`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token` (`token`);

--
-- Indices de la tabla `app_reportes_iteminspeccion`
--
ALTER TABLE `app_reportes_iteminspeccion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `app_reportes_itemins_inspeccion_id_5087a140_fk_app_repor` (`inspeccion_id`);

--
-- Indices de la tabla `app_reportes_iteminspeccionevidencia`
--
ALTER TABLE `app_reportes_iteminspeccionevidencia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `app_reportes_itemins_item_id_2d46e239_fk_app_repor` (`item_id`);

--
-- Indices de la tabla `app_reportes_itemobsconductaevidencia`
--
ALTER TABLE `app_reportes_itemobsconductaevidencia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `app_reportes_itemobs_item_id_e5e104cc_fk_app_repor` (`item_id`);

--
-- Indices de la tabla `app_reportes_itemobservacionconducta`
--
ALTER TABLE `app_reportes_itemobservacionconducta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `app_reportes_itemobs_observacion_conducta_142730f5_fk_app_repor` (`observacion_conducta_id`);

--
-- Indices de la tabla `app_reportes_observacionconducta`
--
ALTER TABLE `app_reportes_observacionconducta`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token` (`token`);

--
-- Indices de la tabla `app_reportes_reportehsgi`
--
ALTER TABLE `app_reportes_reportehsgi`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token` (`token`);

--
-- Indices de la tabla `app_reportes_reportehsgievidencia`
--
ALTER TABLE `app_reportes_reportehsgievidencia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `app_reportes_reporte_reporte_hsgi_id_f3c6cc64_fk_app_repor` (`reporte_hsgi_id`);

--
-- Indices de la tabla `app_reportes_usuario`
--
ALTER TABLE `app_reportes_usuario`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indices de la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indices de la tabla `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indices de la tabla `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indices de la tabla `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indices de la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indices de la tabla `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indices de la tabla `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `app_reportes_inspeccioncabecera`
--
ALTER TABLE `app_reportes_inspeccioncabecera`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `app_reportes_iteminspeccion`
--
ALTER TABLE `app_reportes_iteminspeccion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `app_reportes_iteminspeccionevidencia`
--
ALTER TABLE `app_reportes_iteminspeccionevidencia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `app_reportes_itemobsconductaevidencia`
--
ALTER TABLE `app_reportes_itemobsconductaevidencia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `app_reportes_itemobservacionconducta`
--
ALTER TABLE `app_reportes_itemobservacionconducta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `app_reportes_observacionconducta`
--
ALTER TABLE `app_reportes_observacionconducta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `app_reportes_reportehsgi`
--
ALTER TABLE `app_reportes_reportehsgi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `app_reportes_reportehsgievidencia`
--
ALTER TABLE `app_reportes_reportehsgievidencia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `app_reportes_usuario`
--
ALTER TABLE `app_reportes_usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT de la tabla `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `app_reportes_iteminspeccion`
--
ALTER TABLE `app_reportes_iteminspeccion`
  ADD CONSTRAINT `app_reportes_itemins_inspeccion_id_5087a140_fk_app_repor` FOREIGN KEY (`inspeccion_id`) REFERENCES `app_reportes_inspeccioncabecera` (`id`);

--
-- Filtros para la tabla `app_reportes_iteminspeccionevidencia`
--
ALTER TABLE `app_reportes_iteminspeccionevidencia`
  ADD CONSTRAINT `app_reportes_itemins_item_id_2d46e239_fk_app_repor` FOREIGN KEY (`item_id`) REFERENCES `app_reportes_iteminspeccion` (`id`);

--
-- Filtros para la tabla `app_reportes_itemobsconductaevidencia`
--
ALTER TABLE `app_reportes_itemobsconductaevidencia`
  ADD CONSTRAINT `app_reportes_itemobs_item_id_e5e104cc_fk_app_repor` FOREIGN KEY (`item_id`) REFERENCES `app_reportes_itemobservacionconducta` (`id`);

--
-- Filtros para la tabla `app_reportes_itemobservacionconducta`
--
ALTER TABLE `app_reportes_itemobservacionconducta`
  ADD CONSTRAINT `app_reportes_itemobs_observacion_conducta_142730f5_fk_app_repor` FOREIGN KEY (`observacion_conducta_id`) REFERENCES `app_reportes_observacionconducta` (`id`);

--
-- Filtros para la tabla `app_reportes_reportehsgievidencia`
--
ALTER TABLE `app_reportes_reportehsgievidencia`
  ADD CONSTRAINT `app_reportes_reporte_reporte_hsgi_id_f3c6cc64_fk_app_repor` FOREIGN KEY (`reporte_hsgi_id`) REFERENCES `app_reportes_reportehsgi` (`id`);

--
-- Filtros para la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Filtros para la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Filtros para la tabla `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Filtros para la tabla `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Filtros para la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

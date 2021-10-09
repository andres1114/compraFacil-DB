CREATE DATABASE compraFacil CHARACTER SET utf8 COLLATE utf8_general_ci;
USE compraFacil;
SET storage_engine=INNODB;

CREATE TABLE pais (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre_pais VARCHAR(255) NOT NULL
) DEFAULT CHARACTER SET = utf8 COMMENT = 'tbl_01' ENGINE = InnoDB;

CREATE TABLE ciudad (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre_ciudad VARCHAR(255) NOT NULL,
    id_pais INT NOT NULL,

    FOREIGN KEY (id_pais) REFERENCES pais (id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) DEFAULT CHARACTER SET = utf8 COMMENT = 'tbl_01' ENGINE = InnoDB;

CREATE TABLE tipo_identificacion (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre_tipo_identificacion VARCHAR(255) NOT NULL
) DEFAULT CHARACTER SET = utf8 COMMENT = 'tbl_01' ENGINE = InnoDB;

CREATE TABLE imagen (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre_archivo VARCHAR(255) NOT NULL,
    extencion_archivo VARCHAR(255) NOT NULL,
    index_archivo CHAR(255) NOT NULL
) DEFAULT CHARACTER SET = utf8 COMMENT = 'tbl_01' ENGINE = InnoDB;

CREATE TABLE almacen (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre_almacen VARCHAR(255) NOT NULL,
    pagina_web_almacen CHAR(255) NOT NULL,
    id_imagen INT NULL,
    activo BOOLEAN NOT NULL,

    FOREIGN KEY (id_imagen) REFERENCES imagen (id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
) DEFAULT CHARACTER SET = utf8 COMMENT = 'tbl_01' ENGINE = InnoDB;

CREATE TABLE producto (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_almacen INT NOT NULL,
    nombre_producto CHAR(255) NOT NULL,
    precio_producto BIGINT NOT NULL,
    id_imagen INT NULL,
    activo BOOLEAN NOT NULL,

    FOREIGN KEY (id_imagen) REFERENCES imagen (id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
) DEFAULT CHARACTER SET = utf8 COMMENT = 'tbl_01' ENGINE = InnoDB;

CREATE TABLE empleado (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_tipo_identificacion INT NOT NULL,
    numero_identificacion_empleado VARCHAR(255) NOT NULL,
    nombre_empleado VARCHAR(255) NOT NULL,
    apellido_empleado VARCHAR(255) NOT NULL,
    fecha_registro_empleado DATETIME NOT NULL,
    activo BOOLEAN NOT NULL,

    FOREIGN KEY (id_tipo_identificacion) REFERENCES tipo_identificacion (id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) DEFAULT CHARACTER SET = utf8 COMMENT = 'tbl_01' ENGINE = InnoDB;

CREATE TABLE tipo_usuario (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    valor_tipo_usuario INT NOT NULL,
    descripcion_tipo_usuario VARCHAR(255) NOT NULL,
    pagina_redireccion VARCHAR(255) NOT NULL
) DEFAULT CHARACTER SET = utf8 COMMENT = 'tbl_01' ENGINE = InnoDB;

CREATE TABLE usuario (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre_usuario VARCHAR(255) NOT NULL,
    contrasena_md5 CHAR(255) NOT NULL,
    contrasena_sha256 CHAR(255) NOT NULL,
    id_tipo_usuario INT NOT NULL,
    activo BOOLEAN NOT NULL,

    FOREIGN KEY (id_tipo_usuario) REFERENCES tipo_usuario (id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) DEFAULT CHARACTER SET = utf8 COMMENT = 'tbl_01' ENGINE = InnoDB;

CREATE TABLE empleado_usuario (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    id_empleado INT NOT NULL,

    FOREIGN KEY (id_usuario) REFERENCES usuario (id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (id_empleado) REFERENCES empleado (id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) DEFAULT CHARACTER SET = utf8 COMMENT = 'tbl_01' ENGINE = InnoDB;

CREATE TABLE permisos (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre_permiso VARCHAR(255) NOT NULL,
    descripcion_permiso VARCHAR(255) NOT NULL,
    categoria_permiso VARCHAR(255) NOT NULL
) DEFAULT CHARACTER SET = utf8 COMMENT = 'tbl_01' ENGINE = InnoDB;

CREATE TABLE permisos_usuario (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    id_permiso INT NOT NULL,

    FOREIGN KEY (id_usuario) REFERENCES usuario (id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (id_permiso) REFERENCES permisos (id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) DEFAULT CHARACTER SET = utf8 COMMENT = 'tbl_01' ENGINE = InnoDB;

CREATE TABLE log (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    user_id INT NULL,
    user_name VARCHAR(255) NOT NULL,
    timestamp DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
    logaction VARCHAR(255) NOT NULL,
    logquery TEXT NOT NULL,

    FOREIGN KEY (user_id) REFERENCES usuario (id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
) DEFAULT CHARACTER SET = utf8 COMMENT = 'tbl_01' ENGINE = InnoDB;

CREATE TABLE session (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    user_id INT NULL,
    session_id TEXT NOT NULL,
    nonce_value TEXT NOT NULL,
    creation_date DATETIME NOT NULL,
    expiration_date DATETIME NOT NULL,

    FOREIGN KEY (user_id) REFERENCES usuario (id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) DEFAULT CHARACTER SET = utf8 COMMENT = 'tbl_01' ENGINE = InnoDB;

INSERT INTO tipo_usuario (valor_tipo_usuario, descripcion_tipo_usuario, pagina_redireccion) VALUES (1, 'Administrador de sistema', 'index.php'), (2, 'Usuario empleado', 'index.php');
INSERT INTO usuario (nombre_usuario, contrasena_md5, contrasena_sha256, id_tipo_usuario, activo) VALUES ('admin', MD5('admin'), 'RzZKZ1VFZWhhUk5Ydkc2UGsrTmFIUT09', 1, TRUE);
INSERT INTO tipo_identificacion (nombre_tipo_identificacion) VALUES ('Cédula de ciudadania'), ('Cédula extranjera'), ('NIT');

INSERT INTO pais (nombre_pais) VALUES ('Colombia');
INSERT INTO ciudad (id_pais,nombre_ciudad) VALUES
(1,'Titiribí'),
(1,'Medellín'),
(1,'Santa Rosa de Osos'),
(1,'Remedios'),
(1,'Santa Fe de Antioquia'),
(1,'Rionegro'),
(1,'Sopetrán'),
(1,'Barranquilla'),
(1,'Carmen'),
(1,'Cartagena'),
(1,'Corozal'),
(1,'Chinú'),
(1,'Lorica'),
(1,'Magangué'),
(1,'Mompox'),
(1,'Sabanalarga'),
(1,'Sincelejo'),
(1,'Jericó'),
(1,'Tunja'),
(1,'Soatá'),
(1,'Labranzagrande'),
(1,'Moniquirá'),
(1,'Guateque'),
(1,'Santa Rosa de Viterbo'),
(1,'Atrato'),
(1,'Barbacoas'),
(1,'Buenaventura'),
(1,'Buga'),
(1,'Caldas'),
(1,'Cali'),
(1,'Obando'),
(1,'Palmira'),
(1,'Pasto'),
(1,'Popayán'),
(1,'Quindío'),
(1,'Santander'),
(1,'San Juan'),
(1,'Toro'),
(1,'Tulúa'),
(1,'Túquerres'),
(1,'Bogotá'),
(1,'Cáqueza'),
(1,'Facatativá'),
(1,'La Palma'),
(1,'Tequendama'),
(1,'Ubaté'),
(1,'Zipaquirá'),
(1,'El Banco'),
(1,'Padilla'),
(1,'Santa'),
(1,'Tenerife'),
(1,'Valledupar'),
(1,'Cúcuta'),
(1,'García'),
(1,'Guanentá'),
(1,'Ocaña'),
(1,'Pamplona'),
(1,'Socorro'),
(1,'Soto'),
(1,'Vélez'),
(1,'Guamo'),
(1,'Ibagué'),
(1,'Neiva');

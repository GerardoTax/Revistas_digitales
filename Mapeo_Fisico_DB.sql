CREATE DATABASE revistas_digitales;

use revistad_digitales;

CREATE TABLE Usuario(
usuario VARCHAR(45) NOT NULL,
contraseña VARCHAR(45) NOT NULL,
area_trabajo VARCHAR(25) NOT NULL,
CONSTRAINT PK_USUARIO PRIMARY KEY (usuario)
);

CREATE TABLE Perfil(
 usuario_nombre VARCHAR(45) NOT NULL,
 nombre VARCHAR(45) NOT NULL,
 apellido VARCHAR(45) NOT NULL,
 fecha_creacion DATE,
foto_perfil LONGBLOB, 
 CONSTRAINT FK_TO_USUARIO FOREIGN KEY (usuario_nombre) REFERENCES usuario(usuario)
);

CREATE TABLE  Etiqueta(
nombre_etiqueta VARCHAR(45) NOT NULL,
CONSTRAINT FK_ETIQUETA PRIMARY KEY (nombre_etiqueta)
);

CREATE TABLE  Hobbit(
nombre_hobbits VARCHAR(45) NOT NULL,
CONSTRAINT FK_HOBBITS PRIMARY KEY (nombre_hobbits)
);

CREATE TABLE Categoria(
nombre_categoria VARCHAR(45) NOT NULL,
CONSTRAINT FK_CATEGORIA PRIMARY KEY(nombre_categoria)
);

CREATE TABLE Etiqueta_usuario(
usuario_nombre VARCHAR(45) NOT NULL,
etiqueta VARCHAR(45) NOT NULL,
CONSTRAINT FK_TO_USUARIO_ETIQUETA FOREIGN KEY (usuario_nombre) REFERENCES usuario(usuario),
CONSTRAINT FK_TO_ETIQUETA FOREIGN KEY (etiqueta) REFERENCES etiqueta(nombre_etiqueta)
);

CREATE TABLE Hobbit_usuario(
usuario_nombre VARCHAR(45) NOT NULL,
hobbit VARCHAR(45) NOT NULL,
CONSTRAINT FK_TO_USUARIO_HOBBITS FOREIGN KEY (usuario_nombre) REFERENCES usuario(usuario),
CONSTRAINT FK_TO_HOBBITS FOREIGN KEY (hobbit) REFERENCES hobbit(nombre_hobbits )
); 

CREATE TABLE revista(
id int(10) unsigned NOT NULL auto_increment,
nombre_revitas VARCHAR(45) NOT NULL,
fecha_creacion DATE,
precio_suscripcion FLOAT NOT null,
editor Varchar(45) NOT NULL,
describcion TEXT,
CONSTRAINT FK_TO_EDITOR_REVISTA FOREIGN KEY (editor) REFERENCES usuario(usuario),
CONSTRAINT FK_REVISTA  PRIMARY KEY (id)
);

CREATE TABLE eiquetas_revista(
codigo_revista int(10) unsigned NOT NULL,
nombre_etiqueta VARCHAR(45) NOT NULL,
CONSTRAINT FK_TO_REVISTA_ETIQUETA FOREIGN KEY (codigo_revista) REFERENCES revista(id),
CONSTRAINT FK_TO_ETIQUETA_REVISTA FOREIGN KEY (nombre_etiqueta) REFERENCES etiqueta(nombre_etiqueta)
);

CREATE TABLE categorias_revista(
tipo_categoria Varchar (45) NOT NULL,
codigo_revista INT(10)  UNSIGNED NOT NULL,
CONSTRAINT FK_TO_CATEGORIA_REVISTA FOREIGN KEY (tipo_categoria) REFERENCES categoria(nombre_categoria),
CONSTRAINT FK_TO_REVISTA_CATEGORIA FOREIGN  KEY (codigo_revista) REFERENCES revista(id) 
);

CREATE TABLE archivos (
  codigo_revista INT (10) UNSIGNED NOT NULL,
  archivo_binario blob NOT NULL,
  archivo_nombre varchar(255) NOT NULL default '',
  archivo_peso varchar(15) NOT NULL default '',
  archivo_tipo varchar(25) NOT NULL default '',
  CONSTRAINT FK_ARCHIVO_REVISTA FOREIGN KEY (codigo_revista) REFERENCES revista(id)
);
CREATE TABLE suscripcion(
usuario_nombre VARCHAR(45) NOT NULL,
codigo_revista INT (10) UNSIGNED NOT NULL,
fecha_suscripcion DATE,
CONSTRAINT FK_USUARIO_SUSCRIPCION FOREIGN KEY (usuario_nombre) REFERENCES usuario(usuario),
CONSTRAINT FK_TO_REVISTA_SUSCRIPCION FOREIGN KEY (codigo_revista) REFERENCES revista(id)
);

CREATE TABLE anuncio(
id INT(10) unsigned NOT NULL,
tipo_texto TEXT,
tipo_imagen LONGBLOB, 
tipo_video VARCHAR(100),
CONSTRAINT FK_ANUNCIO PRIMARY KEY (id)
);

CREATE TABLE etiqueta_anuncios(
codigo_anuncio INT(10) UNSIGNED NOT NULL,
nombre_etiqueta VARCHAR(45) NOT NULL,
CONSTRAINT FK_ANUNCIO_ETIQUETA FOREIGN KEY (codigo_anuncio) REFERENCES anuncio(id),
CONSTRAINT FK_ETIQUETA_ANUNCIO FOREIGN KEY (nombre_etiqueta) REFERENCES etiqueta(nombre_etiqueta)
);

CREATE TABLE comentario(
id INT(10) unsigned NOT NULL,
comentario TEXT,
usuario_comentario VARCHAR(45),
codigo_revista INT(10)  UNSIGNED NOT NULL,
esta_cometentario boolean,
CONSTRAINT FK_comentario PRIMARY KEY (id),
CONSTRAINT FK_USUARIO_COMENTARIO FOREIGN KEY (usuario_comentario) REFERENCES usuario(usuario),
CONSTRAINT FK_REVISTA_COMENTARIO FOREIGN KEY (codigo_revista) REFERENCES revista(id)
);
CREATE TABLE me_gusta(
usuario VARCHAR(45),
codigo_revista INT(10)  UNSIGNED NOT NULL,
esta_gusto boolean,
CONSTRAINT FK_USUARIO_ME_GUSTA FOREIGN KEY (usuario) REFERENCES usuario(usuario),
CONSTRAINT FK_REVISTA_ME_GUSTA FOREIGN KEY (codigo_revista) REFERENCES revista(id)
);

CREATE TABLE registro(
id INT(10)  UNSIGNED NOT NULL,
codigo_revista INT(10)  UNSIGNED NOT NULL,
administrador VARCHAR(45) NOT NULL,
precio_registro INT, 
fecha_registro DATE,
CONSTRAINT FK_CODIGO_REGISTRO PRIMARY KEY (id),
CONSTRAINT FK_ADMINISTRADOR FOREIGN KEY (administrador) REFERENCES usuario(usuario),
CONSTRAINT FK_CODIGO_REGISTRO FOREIGN KEY (codigo_revista) REFERENCES revista(id)
);

CREATE TABLE pago_suscripcion(
codigo_registro INT(10)  UNSIGNED NOT NULL,
precio_registro INT NOT NULL,
codigo_revista  INT(10)  UNSIGNED NOT NULL,
precio_suscripcion INT NOT NULL,
fecha_pago DATE,
CONSTRAINT FK_TO_REGISTRO_SUSCRIPCION FOREIGN KEY (codigo_registro) REFERENCES registro(id),
CONSTRAINT FK_REVISTA_SUSCRIPCION FOREIGN KEY (codigo_revista) REFERENCES revista(id)

);
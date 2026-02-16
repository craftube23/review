-- Creación del esquema para la gestión social integral
CREATE DATABASE IF NOT EXISTS db_bienestar_social;
USE db_bienestar_social;

-- Tabla base: Información demográfica del ciudadano
CREATE TABLE ciudadanos (
    pk_ciudadano INT AUTO_INCREMENT PRIMARY KEY,
    anualidad INT,
    rango_edad INT,
    sexo_biologico VARCHAR(25),
    doc_identidad_tipo VARCHAR(110),
    clasificacion_cat VARCHAR(110)
);

-- Información territorial
CREATE TABLE zonas_geograficas (
    id_sector INT AUTO_INCREMENT PRIMARY KEY,
    nombre_barrio_vereda VARCHAR(160),
    sector_comuna_correg VARCHAR(160),
    tipo_zona VARCHAR(60)
);

-- Catálogo de pertenencia étnica
CREATE TABLE grupos_etnicos (
    id_grupo_etnico INT AUTO_INCREMENT PRIMARY KEY,
    nombre_etnia VARCHAR(160)
);

-- Relación N a M entre ciudadanos y etnias
CREATE TABLE registro_etnico_persona (
    fk_persona INT,
    fk_etnia INT,
    CONSTRAINT pk_etnia_persona PRIMARY KEY (fk_persona, fk_etnia),
    CONSTRAINT fk_rel_persona FOREIGN KEY (fk_persona) REFERENCES ciudadanos(pk_ciudadano)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_rel_etnia FOREIGN KEY (fk_etnia) REFERENCES grupos_etnicos(id_grupo_etnico)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Perfil socio-cultural
CREATE TABLE perfil_social (
    id_usuario INT PRIMARY KEY,
    es_jefe_hogar VARCHAR(25),
    antecedente_migratorio VARCHAR(25),
    identidad_lgtbi VARCHAR(110),
    CONSTRAINT fk_perfil_usuario FOREIGN KEY (id_usuario) REFERENCES ciudadanos(pk_ciudadano)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Registro de limitaciones físicas o cognitivas
CREATE TABLE salud_discapacidad (
    id_sujeto INT PRIMARY KEY,
    posee_discapacidad VARCHAR(25),
    descripcion_discapacidad VARCHAR(110),
    CONSTRAINT fk_salud_usuario FOREIGN KEY (id_sujeto) REFERENCES ciudadanos(pk_ciudadano)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Información académica
CREATE TABLE formacion_academica (
    id_estudiante INT PRIMARY KEY,
    grado_instruccion VARCHAR(160),
    CONSTRAINT fk_edu_usuario FOREIGN KEY (id_estudiante) REFERENCES ciudadanos(pk_ciudadano)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Situación laboral actual
CREATE TABLE estatus_laboral (
    id_trabajador INT PRIMARY KEY,
    tipo_ocupacion VARCHAR(160),
    CONSTRAINT fk_lab_usuario FOREIGN KEY (id_trabajador) REFERENCES ciudadanos(pk_ciudadano)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Vinculación de vivienda
CREATE TABLE domicilio_ciudadano (
    id_residente INT PRIMARY KEY,
    id_lugar INT,
    CONSTRAINT fk_residente FOREIGN KEY (id_residente) REFERENCES ciudadanos(pk_ciudadano)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_lugar FOREIGN KEY (id_lugar) REFERENCES zonas_geograficas(id_sector)
        ON DELETE CASCADE ON UPDATE CASCADE
);

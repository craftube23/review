CREATE DATABASE IF NOT EXISTS sistema_integral_social;
USE sistema_integral_social;

CREATE TABLE PERSONA (
    id_persona INT AUTO_INCREMENT PRIMARY KEY,
    edad INT,
    genero VARCHAR(20),
    tipo_identificacion VARCHAR(100),
    categoria VARCHAR(100),
    periodo INT
);

CREATE TABLE UBICACION (
    id_ubicacion INT AUTO_INCREMENT PRIMARY KEY,
    barrio_vereda VARCHAR(150),
    comuna_corregimiento VARCHAR(150),
    zona VARCHAR(50)
);

CREATE TABLE ETNIA (
    id_etnia INT AUTO_INCREMENT PRIMARY KEY,
    grupo_etnico VARCHAR(150)
);

CREATE TABLE PERSONA_ETNIA (
    id_persona INT,
    id_etnia INT,
    PRIMARY KEY (id_persona, id_etnia),
    FOREIGN KEY (id_persona) REFERENCES PERSONA(id_persona)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_etnia) REFERENCES ETNIA(id_etnia)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE CONDICION_SOCIAL (
    id_persona INT PRIMARY KEY,
    cabeza_familia VARCHAR(20),
    experiencia_migratoria VARCHAR(20),
    orientacion_sexual_lgtbi VARCHAR(100),
    FOREIGN KEY (id_persona) REFERENCES PERSONA(id_persona)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE DISCAPACIDAD (
    id_persona INT PRIMARY KEY,
    personas_condicion_discapacidad VARCHAR(20),
    tipo_discapacidad VARCHAR(100),
    FOREIGN KEY (id_persona) REFERENCES PERSONA(id_persona)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE EDUCACION (
    id_persona INT PRIMARY KEY,
    nivel_educativo VARCHAR(150),
    FOREIGN KEY (id_persona) REFERENCES PERSONA(id_persona)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE OCUPACION (
    id_persona INT PRIMARY KEY,
    condicion_ocupacional VARCHAR(150),
    FOREIGN KEY (id_persona) REFERENCES PERSONA(id_persona)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE PERSONA_UBICACION (
    id_persona INT PRIMARY KEY,
    id_ubicacion INT,
    FOREIGN KEY (id_persona) REFERENCES PERSONA(id_persona)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_ubicacion) REFERENCES UBICACION(id_ubicacion)
        ON DELETE CASCADE ON UPDATE CASCADE
);

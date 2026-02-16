ALTER TABLE PERSONA
    ADD COLUMN id_original INT UNIQUE;

INSERT INTO UBICACION (barrio_vereda, comuna_corregimiento, zona)
SELECT DISTINCT barrio_vereda, comuna_corregimiento, zona
FROM datos_originales;

INSERT INTO ETNIA (grupo_etnico)
SELECT DISTINCT grupo_etnico
FROM datos_sistema;

INSERT INTO PERSONA (id_original, edad, genero, tipo_identificacion, categoria, periodo)
SELECT id, edad, genero, tipo_identificacion, categoria, periodo
FROM datos_sistema;

INSERT INTO CONDICION_SOCIAL (id_persona, cabeza_familia, experiencia_migratoria, orientacion_sexual_lgtbi)
SELECT p.id_persona,
        d.cabeza_familia,
        d.experiencia_migratoria,
        d.orientacion_sexual_lgtbi
FROM datos_sistema d
JOIN PERSONA p ON p.id_original = d.id;

INSERT INTO DISCAPACIDAD (id_persona, personas_condicion_discapacidad, tipo_discapacidad)
SELECT p.id_persona,
        d.personas_condicion_discapacidad,
        d.tipo_discapacidad
FROM datos_sistema d
JOIN PERSONA p ON p.id_original = d.id;

INSERT INTO EDUCACION (id_persona, nivel_educativo)
SELECT p.id_persona,
        d.nivel_educativo
FROM datos_sistema d
JOIN PERSONA p ON p.id_original = d.id;

INSERT INTO OCUPACION (id_persona, condicion_ocupacional)
SELECT p.id_persona,
        d.condicion_ocupacional
FROM datos_sistema d
JOIN PERSONA p ON p.id_original = d.id;

INSERT INTO PERSONA_ETNIA (id_persona, id_etnia)
SELECT DISTINCT
        p.id_persona,
        e.id_etnia
FROM datos_sistema d
JOIN PERSONA p ON p.id_original = d.id
JOIN ETNIA e ON e.grupo_etnico = d.grupo_etnico;

INSERT INTO PERSONA_UBICACION (id_persona, id_ubicacion)
SELECT DISTINCT
        p.id_persona,
        u.id_ubicacion
FROM datos_sistema d
JOIN PERSONA p ON p.id_original = d.id
JOIN UBICACION u
        ON u.barrio_vereda = d.barrio_vereda
    AND u.comuna_corregimiento = d.comuna_corregimiento
    AND u.zona = d.zona;

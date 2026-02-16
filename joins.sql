-- 1. Agregamos una columna temporal para no perder la referencia del ID original
ALTER TABLE ciudadanos 
    ADD COLUMN ref_id_sistema INT UNIQUE;

-- 2. Poblar la tabla de ubicaciones (evitando duplicados)
INSERT INTO zonas_geograficas (nombre_barrio_vereda, sector_comuna_correg, tipo_zona)
SELECT DISTINCT barrio_vereda, comuna_corregimiento, zona
FROM datos_originales;

-- 3. Poblar el catálogo de etnias
INSERT INTO grupos_etnicos (nombre_etnia)
SELECT DISTINCT grupo_etnico
FROM datos_sistema;

-- 4. Migración de datos principales a la tabla ciudadanos
INSERT INTO ciudadanos (ref_id_sistema, rango_edad, sexo_biologico, doc_identidad_tipo, clasificacion_cat, anualidad)
SELECT id, edad, genero, tipo_identificacion, categoria, periodo
FROM datos_sistema;

-- 5. Carga de información en perfil_social vinculando con el ID temporal
INSERT INTO perfil_social (id_usuario, es_jefe_hogar, antecedente_migratorio, identidad_lgtbi)
SELECT c.pk_ciudadano,
       ds.cabeza_familia,
       ds.experiencia_migratoria,
       ds.orientacion_sexual_lgtbi
FROM datos_sistema ds
JOIN ciudadanos c ON c.ref_id_sistema = ds.id;

-- 6. Carga de datos de discapacidad
INSERT INTO salud_discapacidad (id_sujeto, posee_discapacidad, descripcion_discapacidad)
SELECT c.pk_ciudadano,
       ds.personas_condicion_discapacidad,
       ds.tipo_discapacidad
FROM datos_sistema ds
JOIN ciudadanos c ON c.ref_id_sistema = ds.id;

-- 7. Carga de niveles educativos
INSERT INTO formacion_academica (id_estudiante, grado_instruccion)
SELECT c.pk_ciudadano,
       ds.nivel_educativo
FROM datos_sistema ds
JOIN ciudadanos c ON c.ref_id_sistema = ds.id;

-- 8. Carga de datos laborales
INSERT INTO estatus_laboral (id_trabajador, tipo_ocupacion)
SELECT c.pk_ciudadano,
       ds.condicion_ocupacional
FROM datos_sistema ds
JOIN ciudadanos c ON c.ref_id_sistema = ds.id;

-- 9. Relación Ciudadano - Etnia (Tabla intermedia)
INSERT INTO registro_etnico_persona (fk_persona, fk_etnia)
SELECT DISTINCT
       c.pk_ciudadano,
       ge.id_grupo_etnico
FROM datos_sistema ds
JOIN ciudadanos c ON c.ref_id_sistema = ds.id
JOIN grupos_etnicos ge ON ge.nombre_etnia = ds.grupo_etnico;

-- 10. Relación Ciudadano - Ubicación (Tabla intermedia)
INSERT INTO domicilio_ciudadano (id_residente, id_lugar)
SELECT DISTINCT
       c.pk_ciudadano,
       zg.id_sector
FROM datos_sistema ds
JOIN ciudadanos c ON c.ref_id_sistema = ds.id
JOIN zonas_geograficas zg 
    ON zg.nombre_barrio_vereda = ds.barrio_vereda
    AND zg.sector_comuna_correg = ds.comuna_corregimiento
    AND zg.tipo_zona = ds.zona;

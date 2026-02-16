-- Tabla temporal para la carga masiva de información externa
CREATE TABLE IF NOT EXISTS fuente_datos_sociales (
    id INT AUTO_INCREMENT PRIMARY KEY,
    
    -- Información temporal y clasificación
    anualidad INT,
    clasificacion_cat VARCHAR(110),
    
    -- Datos demográficos básicos
    sexo_biologico VARCHAR(35),
    rango_edad INT,
    doc_identidad_tipo VARCHAR(110),
    
    -- Condiciones de salud y discapacidad
    posee_discapacidad VARCHAR(25),
    descripcion_discapacidad VARCHAR(110),
    
    -- Factores sociales y de identidad
    es_jefe_hogar VARCHAR(25),
    identidad_lgtbi VARCHAR(110),
    antecedente_migratorio VARCHAR(25),
    
    -- Contexto cultural y educativo
    nombre_etnia VARCHAR(160),
    grado_instruccion VARCHAR(160),
    tipo_ocupacion VARCHAR(160),
    
    -- Datos de localización
    nombre_barrio_vereda VARCHAR(160),
    sector_comuna_correg VARCHAR(160),
    tipo_zona VARCHAR(60)
);

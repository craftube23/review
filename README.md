Markdown
# 📊 Sistema de Gestión y Arquitectura de Datos Sociales
**Postulante:** Andrés Felipe Navas Alvear  
**Materia:** Bases de Datos I (MySQL)

---

## 1. Introducción
Este proyecto presenta la reestructuración y normalización de un conjunto de datos brutos sobre caracterización poblacional. Se tomó como base una estructura plana (denominada `fuente_datos_sociales`) y se transformó en un modelo relacional eficiente aplicando la **Tercera Forma Normal (3FN)**.

### Objetivos Alcanzados:
* **Integridad Referencial:** Implementación de llaves primarias (`PK`) y foráneas (`FK`) con reglas de integridad.
* **Optimización de Almacenamiento:** Eliminación de redundancia de datos mediante tablas maestras.
* **Escalabilidad:** Estructura modular que permite añadir nuevos campos sin afectar la lógica actual.

---

## 2. Tecnologías y Metodología
* **Motor:** MySQL Server.
* **Lógica:** Modelo Relacional y Normalización.
* **Procesos:** Migración estructurada mediante sentencias DML (INSERT/SELECT).

---

## 3. Arquitectura del Sistema

### 3.1. Tabla de Importación (Staging)
Para el proceso de carga masiva, se definió la tabla `fuente_datos_sociales` que actúa como puente para los datos no estructurados:

```sql
CREATE TABLE IF NOT EXISTS fuente_datos_sociales (
    id INT AUTO_INCREMENT PRIMARY KEY,
    anualidad INT,
    clasificacion_cat VARCHAR(110),
    sexo_biologico VARCHAR(35),
    rango_edad INT,
    -- (Atributos poblacionales adicionales)
);
3.2. Modelo Normalizado
El diseño final se desglosa en las siguientes entidades lógicas:

ciudadanos: Centraliza la información demográfica base.

zonas_geograficas: Diccionario de barrios, comunas y zonas.

grupos_etnicos: Catálogo de pertenencia étnica.

perfil_social: Registro de condiciones de vulnerabilidad y migración.

salud_discapacidad: Detalle de limitaciones físicas o cognitivas.

formacion_academica: Estatus educativo.

estatus_laboral: Condición de ocupación actual.

4. Implementación de Relaciones (N:M)
Para las entidades que admiten múltiples categorías, se utilizaron tablas intermedias que garantizan la flexibilidad del modelo:

registro_etnico_persona: Vincula ciudadanos con sus respectivas etnias.

domicilio_ciudadano: Relaciona a los residentes con sus sectores geográficos.

5. Proceso de Carga y Migración
La migración de datos se ejecutó garantizando la unicidad de los registros maestros. Ejemplo de lógica utilizada:

SQL
INSERT INTO grupos_etnicos (nombre_etnia)
SELECT DISTINCT grupo_etnico
FROM fuente_datos_sociales;
Para asegurar que cada registro se asocie correctamente, se añadió el campo ref_id_sistema en la tabla principal para mapear los IDs originales durante el proceso de inserción.

6. Consulta de Consolidación (Reporting)
Se diseñó un script de consulta avanzada utilizando LEFT JOIN para recuperar la información completa de los ciudadanos de forma estructurada:

SQL
SELECT c.pk_ciudadano, c.sexo_biologico, zg.nombre_barrio_vereda, fa.grado_instruccion
FROM ciudadanos c
LEFT JOIN domicilio_ciudadano dc ON c.pk_ciudadano = dc.id_residente
LEFT JOIN zonas_geograficas zg ON dc.id_lugar = zg.id_sector
LEFT JOIN formacion_academica fa ON c.pk_ciudadano = fa.id_estudiante;
7. Conclusiones
La implementación de este modelo reduce significativamente el peso de la base de datos y evita anomalías de inserción, actualización y borrado. El sistema cumple con los requerimientos técnicos de normalización y está listo para integrarse con interfaces de visualización o análisis de datos.

Entregado por: Andrés Felipe Navas Alvear

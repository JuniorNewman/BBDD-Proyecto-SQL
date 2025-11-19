# BBDD-Proyecto-SQL

## 📌 Descripción del proyecto
Este proyecto consiste en analizar una base de datos relacionada con una tienda de alquiler de películas. A partir del conjunto de datos disponible, se realizan diferentes consultas SQL con el objetivo de extraer información útil sobre clientes, películas, inventarios, categorías, pagos y actores.

Las consultas no solo buscan obtener resultados concretos, sino también entender mejor cómo se relacionan las tablas entre sí y cómo se puede utilizar SQL para responder preguntas reales y sacar distintas respuestas y concluciones de todos los datos que tenemos.

---

## 🗂 Esquema de la Base de Datos

La base de datos representa una tienda de alquiler de películas y está compuesta por varias tablas conectadas mediante claves (clientes, películas, inventario, alquileres, pagos, etc.). Esto permite realizar consultas tanto simples como relacionadas entre múltiples tablas.

📎 Archivo del esquema: `esquema.png`

Vista general del modelo:

![Esquema de la Base de Datos](esquema.png)

---

## 📄 Archivo con consultas

El archivo principal del proyecto es:

📎 `Proyecto-BBDD SQL.sql`

En él se incluyen consultas de diferentes niveles, entre ellas:

- Selección y filtrado de datos (`WHERE`, `LIKE`, `BETWEEN`)
- Ordenación y límites (`ORDER BY`, `LIMIT`)
- Joins entre varias tablas
- Funciones de agregación (`COUNT`, `SUM`, `AVG`)
- Agrupaciones y filtros con `GROUP BY` y `HAVING`
- Subconsultas anidadas
- Consultas con fechas y diferencias de tiempo
- Tablas temporales para análisis específicos

Las consultas están organizadas y comentadas para facilitar su lectura y modificación.

---

## 🔧 Tecnologías utilizadas

| Tecnología | Uso |
|------------|-----|
| **PostgreSQL** | Base de datos |
| **DBeaver** | Ejecución y visualización |
| **SQL** | Lenguaje de consultas |

---




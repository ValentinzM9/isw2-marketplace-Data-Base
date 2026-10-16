![header](https://capsule-render.vercel.app/api?type=waving&color=336791&height=180&section=header&text=Marketplace%20de%20Alojamientos&fontSize=40&fontColor=ffffff&animation=fadeIn&fontFamily=Pacifico)
<br>

[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-336791?logo=postgresql)](#)
[![Redis](https://img.shields.io/badge/Redis-7-DC382D?logo=redis)](#)
[![Flyway](https://img.shields.io/badge/Flyway-Migrations-CC0200?logo=flyway)](#)
[![Licencia](https://img.shields.io/badge/Licencia-MIT-green)](LICENSE)
[![Estado](https://img.shields.io/badge/Estado-En%20desarrollo-yellow)](#)

> **Proyecto académico – Ingeniería de Software II**  
> *Repositorio de base de datos del Marketplace de Alojamientos – Inversiones LR*  
> *Universidad El Bosque – 2026*

---

## Descripción del proyecto

Este repositorio contiene la **capa de persistencia** del proyecto *Marketplace de Alojamientos*, desarrollado para la asignatura Ingeniería de Software II de la Universidad El Bosque.

Aquí se alojan el **modelo de datos**, los **scripts de creación y migración**, las **funciones, procedimientos y triggers**, así como los **diagramas** que documentan la estructura de la base de datos que da soporte al backend del sistema. La base de datos principal es **PostgreSQL**, complementada con **Redis** para caché y tareas temporales.

El objetivo es mantener un diseño consistente, normalizado y escalable que soporte las reglas de negocio del marketplace: usuarios, alojamientos, reservas, pagos, reseñas y auditoría.

---

## Funcionalidades que soporta

Las entidades y procesos que la base de datos debe respaldar son:

- Registro e inicio de sesión de usuarios.
- Gestión de perfiles y permisos.
- Publicación y administración de alojamientos.
- Búsqueda y disponibilidad de alojamientos.
- Cotización y gestión de reservas.
- Simulación de pagos.
- Cancelación de reservas con políticas configurables.
- Reseñas y calificaciones.
- Notificaciones.
- Administración, reportes y auditoría.

---

## Tecnologías del proyecto

| Componente | Tecnología |
|:---|:---|
| Motor principal | PostgreSQL 16 |
| Caché y almacenamiento temporal | Redis 7 |
| Contenedores | Docker |
| Migraciones | Flyway |
| Documentación de esquema | OpenAPI (integración con el backend) |
| Infraestructura prevista | AWS EC2 |
| Herramientas de calidad | SonarCloud, CodeRabbit |
| Control de versiones | GitHub |
| Gestión del proyecto | Jira, Confluence |

---

## Arquitectura y modelado

El diseño de la base de datos sigue los principios del **monolito modular** planteado en el backend, organizando los objetos por dominios funcionales (usuarios, alojamientos, reservas, pagos, reseñas, auditoría).

Se aplican las siguientes prácticas:

- **Normalización** hasta tercera forma normal (3FN) en las entidades transaccionales.
- **Integridad referencial** mediante claves foráneas y restricciones.
- **Índices estratégicos** para optimizar búsquedas y consultas frecuentes.
- **Vistas materializadas** para reportes y consultas analíticas.
- **Procedimientos y funciones** para operaciones complejas del dominio.
- **Triggers** para auditoría y validaciones automáticas.
- **Separación de esquemas** por dominio funcional cuando sea necesario.

---

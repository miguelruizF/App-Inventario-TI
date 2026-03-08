# App-Inventario-TI
Sistema de inventario TI con Electron y SQL Server.

## Finalidad del proyecto

Este proyecto tiene como objetivo centralizar y controlar el inventario de activos de tecnología de la información dentro de la organización.  
Permite registrar y consultar equipos, periféricos, licencias de software y otros recursos de TI, así como su ubicación, responsable y estado actual.

Con esta aplicación se busca:
- Reducir pérdidas y extravíos de equipos.
- Tener trazabilidad de movimientos entre usuarios y departamentos.
- Facilitar auditorías internas y externas.
- Generar una base de datos confiable para la toma de decisiones.

## Estructura del proyecto

Actualmente el proyecto se organiza de la siguiente manera:

- `README.md`: descripción general del proyecto.
- `database/`: scripts SQL para la base de datos en SQL Server (ejecutar en orden numérico).
  - `01_database.sql`: creación de la base de datos principal.
  - `02_departamentos.sql`: tabla de departamentos.
  - `03_usuarios.sql`: tabla de usuarios.
  - `04_tipos_activos.sql`: catálogo de tipos de activo.
  - `05_estatus_activo.sql`: catálogo de estatus del activo.
  - `06_marcas.sql`: catálogo de marcas.
  - `07_activos.sql`: tabla de activos (referencia a marcas, tipos y estatus).
  - `08_historial_asignaciones.sql`: historial de asignaciones y devoluciones.
  - `09_migrar_marca_a_catalogo.sql`: **solo para BD existente** — migra el campo texto `activos.marca` al catálogo `marcas` y deja `activos.id_marca` como FK.

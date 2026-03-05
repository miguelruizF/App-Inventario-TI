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
- `database/`: scripts SQL para la base de datos en SQL Server.
  - `01_database.sql`: creación de la base de datos principal.
  - `02_departamentos.sql`: definición y carga inicial de la tabla de departamentos.
  - `03_usuarios.sql`: definición y carga inicial de la tabla de usuarios.

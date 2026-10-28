# Hotel Reservation Database

Base de datos relacional para un sistema de consulta de disponibilidad y tarifas de habitaciones de una cadena hotelera.

## Tecnologías

- MySQL 8
- MySQL Workbench
- SQL

## Modelo de datos

El sistema cuenta con ocho tablas relacionadas:

- `hoteles`
- `habitaciones`
- `tipos_habitacion`
- `temporadas`
- `periodos_temporada`
- `tarifas`
- `reservas`
- `reserva_habitaciones`

## Estructura del proyecto

```text
scripts/
    01_schema.sql

docs/
    diagrams/
        Hotel_Reservation_MER.mwb
        Hotel_Reservation_MER.pdf
```

## Instalación

1. Abrir MySQL Workbench.
2. Ejecutar `scripts/01_schema.sql`.
3. Verificar la creación del esquema `hotel_reservations` y sus tablas.

## Documentación

El modelo entidad-relación (MER) se encuentra en la carpeta `docs/diagrams`.

## Arquitectura

La base de datos será consumida por una API REST desarrollada con FastAPI y una interfaz web construida con React.
# Hotel Reservation Database

Base de datos relacional para un sistema de reservas hoteleras que permite consultar disponibilidad de habitaciones y calcular tarifas según la sede, temporada, tipo de alojamiento y número de personas.

## Tecnologías

- MariaDB 10.6
- MySQL Workbench
- DBeaver
- SQL

## Modelo de datos

La base de datos `hotel_reservations` está compuesta por ocho tablas relacionadas:

- `hoteles`
- `habitaciones`
- `tipos_habitacion`
- `temporadas`
- `periodos_temporada`
- `tarifas`
- `reservas`
- `reserva_habitaciones`

## Datos iniciales

El sistema contiene cuatro sedes hoteleras con 108 habitaciones distribuidas de la siguiente manera:

| Sede | Estándar | Premium | VIP | Total |
|---|---:|---:|---:|---:|
| Barranquilla | 30 | 3 | 0 | 33 |
| Cali | 0 | 20 | 2 | 22 |
| Cartagena | 10 | 1 | 0 | 11 |
| Bogotá | 20 | 20 | 2 | 42 |
| **Total** | **60** | **44** | **4** | **108** |

Se incluyen temporadas alta y baja, así como tarifas de prueba para el cálculo de alojamiento.

## Estructura del proyecto

```text
hotel-booking-architecture/
├── scripts/
│   ├── 01_schema.sql
│   └── 02_seed.sql
├── docs/
│   └── diagrams/
│       ├── 01_schema.sql
│       └── mer hotel.pdf
└── README.md
```

## Instalación

1. Iniciar el servidor MariaDB.
2. Abrir DBeaver o MySQL Workbench.
3. Ejecutar `scripts/01_schema.sql` para crear el esquema y las tablas.
4. Ejecutar `scripts/02_seed.sql` para cargar los hoteles, habitaciones, temporadas y tarifas.
5. Verificar los registros con la siguiente consulta:

```sql
USE hotel_reservations;

SELECT COUNT(*) AS total_habitaciones
FROM habitaciones;
```

El resultado esperado es de 108 habitaciones.

## Documentación

El modelo entidad-relación (MER) está disponible en `docs/diagrams/mer hotel.pdf`.

El modelo utiliza claves primarias, claves foráneas y relaciones entre las entidades para garantizar la integridad referencial.

## Arquitectura

La base de datos es consumida por una API REST desarrollada en Python con FastAPI y SQLAlchemy.

La interfaz web se desarrolla en React para consultar hoteles, disponibilidad de habitaciones y tarifas.

La estructura permite incorporar posteriormente la gestión de reservas y las operaciones CRUD.
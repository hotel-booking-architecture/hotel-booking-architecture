CREATE DATABASE IF NOT EXISTS hotel_reservations
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE hotel_reservations;

CREATE TABLE IF NOT EXISTS hoteles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ciudad VARCHAR(100) NOT NULL,
    capacidad_por_habitacion INT NOT NULL,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT chk_capacidad_hotel
        CHECK (capacidad_por_habitacion > 0)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS tipos_habitacion (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(45) NOT NULL UNIQUE,
    descripcion VARCHAR(255)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS temporadas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(45) NOT NULL UNIQUE,
    descripcion VARCHAR(255)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS habitaciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    hotel_id INT NOT NULL,
    tipo_habitacion_id INT NOT NULL,
    numero VARCHAR(10) NOT NULL,
    activa BOOLEAN NOT NULL DEFAULT TRUE,

    CONSTRAINT fk_habitacion_hotel
        FOREIGN KEY (hotel_id)
        REFERENCES hoteles(id),

    CONSTRAINT fk_habitacion_tipo
        FOREIGN KEY (tipo_habitacion_id)
        REFERENCES tipos_habitacion(id),

    CONSTRAINT uq_habitacion_hotel_numero
        UNIQUE (hotel_id, numero),

    CONSTRAINT uq_habitacion_id_hotel_tipo
        UNIQUE (id, hotel_id, tipo_habitacion_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS periodos_temporada (
    id INT AUTO_INCREMENT PRIMARY KEY,
    temporada_id INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,

    CONSTRAINT fk_periodo_temporada
        FOREIGN KEY (temporada_id)
        REFERENCES temporadas(id),

    CONSTRAINT chk_periodo_fechas
        CHECK (fecha_fin >= fecha_inicio)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS tarifas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    hotel_id INT NOT NULL,
    tipo_habitacion_id INT NOT NULL,
    temporada_id INT NOT NULL,
    precio_base_habitacion DECIMAL(12,2) NOT NULL,
    precio_por_persona DECIMAL(12,2) NOT NULL,

    CONSTRAINT fk_tarifa_hotel
        FOREIGN KEY (hotel_id)
        REFERENCES hoteles(id),

    CONSTRAINT fk_tarifa_tipo
        FOREIGN KEY (tipo_habitacion_id)
        REFERENCES tipos_habitacion(id),

    CONSTRAINT fk_tarifa_temporada
        FOREIGN KEY (temporada_id)
        REFERENCES temporadas(id),

    CONSTRAINT uq_tarifa
        UNIQUE (hotel_id, tipo_habitacion_id, temporada_id),

    CONSTRAINT chk_tarifa_precios
        CHECK (
            precio_base_habitacion >= 0
            AND precio_por_persona >= 0
        )
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS reservas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fecha_entrada DATE NOT NULL,
    fecha_salida DATE NOT NULL,
    numero_personas INT NOT NULL,
    estado ENUM(
        'PENDIENTE',
        'CONFIRMADA',
        'CANCELADA'
    ) NOT NULL DEFAULT 'PENDIENTE',
    fecha_creacion DATETIME NOT NULL
        DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT chk_reserva_fechas
        CHECK (fecha_salida > fecha_entrada),

    CONSTRAINT chk_reserva_personas
        CHECK (numero_personas > 0)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS reserva_habitaciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    habitacion_id INT NOT NULL,
    reserva_id INT NOT NULL,

    CONSTRAINT fk_reserva_habitacion
        FOREIGN KEY (habitacion_id)
        REFERENCES habitaciones(id),

    CONSTRAINT fk_reserva_reserva
        FOREIGN KEY (reserva_id)
        REFERENCES reservas(id),

    CONSTRAINT uq_reserva_habitacion
        UNIQUE (reserva_id, habitacion_id)
) ENGINE=InnoDB;


USE hotel_reservations;

INSERT INTO hoteles
(id, nombre, ciudad, capacidad_por_habitacion, activo)
VALUES
(1, 'Hotel Barranquilla', 'Barranquilla', 4, 1),
(2, 'Hotel Cali', 'Cali', 6, 1),
(3, 'Hotel Cartagena', 'Cartagena', 8, 1),
(4, 'Hotel Bogotá', 'Bogotá', 6, 1);

INSERT INTO tipos_habitacion (id, nombre, descripcion)
VALUES
(1, 'Estándar', 'Habitación estándar'),
(2, 'Premium', 'Habitación premium'),
(3, 'VIP', 'Habitación VIP');

INSERT INTO temporadas (id, nombre, descripcion)
VALUES
(1, 'Alta', 'Temporada de mayor demanda'),
(2, 'Baja', 'Temporada regular');

INSERT INTO periodos_temporada
(temporada_id, fecha_inicio, fecha_fin)
VALUES
(2, '2026-01-01', '2026-12-14'),
(1, '2026-12-15', '2027-01-15'),
(2, '2027-01-16', '2027-12-31');

INSERT INTO habitaciones
(hotel_id, tipo_habitacion_id, numero, activa)
SELECT
    h.id,
    CASE
        WHEN h.id = 1 THEN IF(n.numero <= 30, 1, 2)
        WHEN h.id = 2 THEN IF(n.numero <= 20, 2, 3)
        WHEN h.id = 3 THEN IF(n.numero <= 10, 1, 2)
        WHEN h.id = 4 THEN
            CASE
                WHEN n.numero <= 20 THEN 1
                WHEN n.numero <= 40 THEN 2
                ELSE 3
            END
    END,
    CONCAT('H', LPAD(n.numero, 3, '0')),
    1
FROM hoteles h
CROSS JOIN (
    SELECT unidades.n + decenas.n * 10 + 1 AS numero
    FROM
    (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2
     UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
     UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8
     UNION ALL SELECT 9) unidades
    CROSS JOIN
    (SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2
     UNION ALL SELECT 3 UNION ALL SELECT 4) decenas
) n
WHERE n.numero <= CASE h.id
    WHEN 1 THEN 33
    WHEN 2 THEN 22
    WHEN 3 THEN 11
    WHEN 4 THEN 42
END;

INSERT INTO tarifas
(hotel_id, tipo_habitacion_id, temporada_id,
 precio_base_habitacion, precio_por_persona)
SELECT DISTINCT
    h.hotel_id,
    h.tipo_habitacion_id,
    t.id,
    (
        CASE h.tipo_habitacion_id
            WHEN 1 THEN 100000
            WHEN 2 THEN 180000
            WHEN 3 THEN 300000
        END
        + h.hotel_id * 10000
    ) * IF(t.id = 1, 1.5, 1),
    20000 * IF(t.id = 1, 1.5, 1)
FROM habitaciones h
CROSS JOIN temporadas t;

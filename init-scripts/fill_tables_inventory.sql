INSERT INTO unidad_medida (nombre) VALUES
    ('Gramos'),
    ('Litros'),
    ('Unidades');

-- Insertar ingredientes
INSERT INTO ingrediente (nombre, cantidad, unidad_medida_id) VALUES
    ('Harina', 1000, 1),  -- 500 gramos de harina
    ('Leche', 10, 2),     -- 1 litro de leche
    ('Huevo', 30, 3);     -- 3 unidades de huevo

-- Insertar recetas
INSERT INTO receta (nombre) VALUES
    ('Panqueques'),
    ('Bizcocho');

-- Insertar ingredientes en recetas
INSERT INTO ingrediente_receta (receta_id, ingrediente_id, cantidad, unidad_medida_id) VALUES
    (1, 1, 250, 1), -- 250g de harina para Panqueques
    (1, 2, 0.5, 2), -- 0.5 litros de leche para Panqueques
    (1, 3, 2, 3),   -- 2 huevos para Panqueques
    (2, 1, 300, 1), -- 300g de harina para Bizcocho
    (2, 2, 11, 2), -- 0.3 litros de leche para Bizcocho
    (2, 3, 3, 3);   -- 3 huevos para Bizcocho

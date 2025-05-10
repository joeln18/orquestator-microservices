-- Insertar unidades de medida solo si no existen
INSERT INTO unidad_medida (nombre)
SELECT nombre FROM (VALUES
    ('Gramos'),
    ('Litros'),
    ('Unidades')
) AS v(nombre)
WHERE NOT EXISTS (
    SELECT 1 FROM unidad_medida u WHERE u.nombre = v.nombre
);

-- Insertar ingredientes solo si no existen
INSERT INTO ingrediente (nombre, cantidad, unidad_medida_id)
SELECT nombre, cantidad, unidad_medida_id FROM (VALUES
    ('Harina', 1000, 1),
    ('Leche', 10, 2),
    ('Huevo', 30, 3)
) AS v(nombre, cantidad, unidad_medida_id)
WHERE NOT EXISTS (
    SELECT 1 FROM ingrediente i WHERE i.nombre = v.nombre
);

-- Insertar recetas solo si no existen
INSERT INTO receta (nombre)
SELECT nombre FROM (VALUES
    ('Panqueques'),
    ('Bizcocho')
) AS v(nombre)
WHERE NOT EXISTS (
    SELECT 1 FROM receta r WHERE r.nombre = v.nombre
);

-- Insertar ingredientes en recetas solo si no existen
INSERT INTO ingrediente_receta (receta_id, ingrediente_id, cantidad, unidad_medida_id)
SELECT receta_id, ingrediente_id, cantidad, unidad_medida_id FROM (VALUES
    (1, 1, 250, 1), 
    (1, 2, 0.5, 2), 
    (1, 3, 2, 3),   
    (2, 1, 300, 1), 
    (2, 2, 11, 2), 
    (2, 3, 3, 3)
) AS v(receta_id, ingrediente_id, cantidad, unidad_medida_id)
WHERE NOT EXISTS (
    SELECT 1 FROM ingrediente_receta ir
    WHERE ir.receta_id = v.receta_id AND ir.ingrediente_id = v.ingrediente_id
);
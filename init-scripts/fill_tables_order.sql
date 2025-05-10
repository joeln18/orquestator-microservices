-- Insertar cliente solo si no existe
INSERT INTO clientes (id_cliente, nombre_cliente, nit, email, estado)
SELECT id_cliente, nombre_cliente, nit, email, estado FROM (VALUES
    (7233, 'User Test', 12345, 'user@gmail.com', true)
) AS v(id_cliente, nombre_cliente, nit, email, estado)
WHERE NOT EXISTS (
    SELECT 1 FROM clientes c WHERE c.id_cliente = v.id_cliente
);
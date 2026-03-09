USE InventarioTI;
GO

-- Indexes on foreign keys for better join and lookup performance
CREATE NONCLUSTERED INDEX IX_usuarios_id_departamento ON usuarios(id_departamento);
CREATE NONCLUSTERED INDEX IX_activos_id_marca ON activos(id_marca);
CREATE NONCLUSTERED INDEX IX_activos_id_tipo_activo ON activos(id_tipo_activo);
CREATE NONCLUSTERED INDEX IX_activos_id_estatus ON activos(id_estatus);
CREATE NONCLUSTERED INDEX IX_activos_id_usuario ON activos(id_usuario);
CREATE NONCLUSTERED INDEX IX_historial_asignaciones_id_activo ON historial_asignaciones(id_activo);
CREATE NONCLUSTERED INDEX IX_historial_asignaciones_id_usuario ON historial_asignaciones(id_usuario);
GO

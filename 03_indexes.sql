-- ============================================================
-- INDICES
-- Proyecto: Marketplace
-- Motor: PostgreSQL
-- ============================================================

CREATE INDEX idx_adicional_publicacion ON public.servicio_adicional USING btree (id_publicacion);

CREATE INDEX idx_alojamiento_anfitrion ON public.alojamiento USING btree (id_anfitrion);

CREATE INDEX idx_alojamiento_busqueda ON public.alojamiento USING btree (ciudad, tipo_alojamiento, capacidad);

CREATE INDEX idx_cancelacion_usuario ON public.cancelacion USING btree (id_usuario);

CREATE INDEX idx_cotizacion_configuracion ON public.cotizacion USING btree (id_configuracion);

CREATE INDEX idx_cotizacion_publicacion ON public.cotizacion USING btree (id_publicacion);

CREATE INDEX idx_exportacion_administrador_fecha ON public.exportacion_reporte USING btree (id_administrador, fecha_solicitud DESC);

CREATE INDEX idx_exportacion_worker ON public.exportacion_reporte USING btree (estado, fecha_solicitud) WHERE ((estado)::text = ANY ((ARRAY['SOLICITADO'::character varying, 'EN_PROCESO'::character varying])::text[]));

CREATE INDEX idx_imagen_publicacion ON public.imagen_publicacion USING btree (id_publicacion);

CREATE INDEX idx_notificacion_usuario_fecha ON public.notificacion USING btree (id_usuario, fecha_creacion DESC);

CREATE INDEX idx_operacion_pendiente_worker ON public.operacion_pendiente USING btree (estado, proxima_ejecucion);

CREATE INDEX idx_outbox_worker ON public.bandeja_salida_auditoria USING btree (estado_envio, proxima_ejecucion) WHERE ((estado_envio)::text = ANY ((ARRAY['PENDIENTE'::character varying, 'ERROR'::character varying])::text[]));

CREATE INDEX idx_pago_reserva ON public.pago USING btree (id_reserva);

CREATE INDEX idx_periodo_alojamiento_fechas ON public.periodo_disponibilidad USING btree (id_alojamiento, fecha_inicio, fecha_fin);

CREATE INDEX idx_publicacion_politica ON public.publicacion USING btree (id_politica);

CREATE INDEX idx_publicacion_precio_activa ON public.publicacion USING btree (precio_por_noche) WHERE ((estado)::text = 'ACTIVA'::text);

CREATE INDEX idx_pubserv_servicio ON public.publicacion_servicio USING btree (id_servicio);

CREATE INDEX idx_resena_moderador ON public.resena USING btree (id_administrador_moderador);

CREATE INDEX idx_reserva_estado_retencion ON public.reserva USING btree (estado, retencion_hasta) WHERE ((estado)::text = ANY ((ARRAY['PENDIENTE_PAGO'::character varying, 'PENDIENTE_APROBACION'::character varying])::text[]));

CREATE INDEX idx_reserva_huesped ON public.reserva USING btree (id_huesped);

CREATE INDEX idx_reserva_noche_reserva ON public.reserva_noche USING btree (id_reserva);

CREATE INDEX idx_revision_publicacion_fecha ON public.revision_publicacion USING btree (id_publicacion, fecha_revision DESC);

CREATE INDEX idx_verificacion_usuario ON public.verificacion_correo USING btree (id_usuario);

CREATE UNIQUE INDEX uq_configuracion_vigente ON public.configuracion_tarifa USING btree ((1)) WHERE (vigente_hasta IS NULL);

CREATE UNIQUE INDEX uq_imagen_portada ON public.imagen_publicacion USING btree (id_publicacion) WHERE (es_portada = true);

CREATE UNIQUE INDEX uq_operacion_activa_reserva ON public.operacion_pendiente USING btree (id_reserva) WHERE ((estado)::text = ANY ((ARRAY['PENDIENTE'::character varying, 'EN_PROCESO'::character varying])::text[]));

CREATE UNIQUE INDEX uq_pago_exitoso_reserva ON public.pago USING btree (id_reserva) WHERE ((estado)::text = ANY ((ARRAY['PAGADO'::character varying, 'REEMBOLSADO'::character varying])::text[]));

CREATE UNIQUE INDEX uq_politica_version_activa ON public.politica_cancelacion USING btree (nombre) WHERE (activa = true);

CREATE UNIQUE INDEX uq_usuario_correo_ci ON public.usuario USING btree (lower((correo)::text));

CREATE UNIQUE INDEX uq_usuario_telefono ON public.usuario USING btree (telefono);

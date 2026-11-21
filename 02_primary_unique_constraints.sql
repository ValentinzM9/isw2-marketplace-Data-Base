-- ============================================================
-- LLAVES PRIMARIAS Y RESTRICCIONES UNIQUE
-- Proyecto: Marketplace
-- Motor: PostgreSQL
-- ============================================================

ALTER TABLE ONLY public.alojamiento
    ADD CONSTRAINT alojamiento_pkey PRIMARY KEY (id_alojamiento);

ALTER TABLE ONLY public.bandeja_salida_auditoria
    ADD CONSTRAINT bandeja_salida_auditoria_pkey PRIMARY KEY (id_evento);

ALTER TABLE ONLY public.cancelacion
    ADD CONSTRAINT cancelacion_id_reserva_key UNIQUE (id_reserva);

ALTER TABLE ONLY public.cancelacion
    ADD CONSTRAINT cancelacion_pkey PRIMARY KEY (id_cancelacion);

ALTER TABLE ONLY public.configuracion_tarifa
    ADD CONSTRAINT configuracion_tarifa_pkey PRIMARY KEY (id_configuracion);

ALTER TABLE ONLY public.cotizacion_adicional
    ADD CONSTRAINT cotizacion_adicional_pkey PRIMARY KEY (id_cotizacion, id_adicional);

ALTER TABLE ONLY public.cotizacion
    ADD CONSTRAINT cotizacion_pkey PRIMARY KEY (id_cotizacion);

ALTER TABLE ONLY public.exportacion_reporte
    ADD CONSTRAINT exportacion_reporte_pkey PRIMARY KEY (id_exportacion);

ALTER TABLE ONLY public.imagen_publicacion
    ADD CONSTRAINT imagen_publicacion_pkey PRIMARY KEY (id_imagen);

ALTER TABLE ONLY public.noche_reservada
    ADD CONSTRAINT noche_reservada_pkey PRIMARY KEY (id_noche);

ALTER TABLE ONLY public.notificacion
    ADD CONSTRAINT notificacion_pkey PRIMARY KEY (id_notificacion);

ALTER TABLE ONLY public.operacion_pendiente
    ADD CONSTRAINT operacion_pendiente_clave_idempotencia_key UNIQUE (clave_idempotencia);

ALTER TABLE ONLY public.operacion_pendiente
    ADD CONSTRAINT operacion_pendiente_pkey PRIMARY KEY (id_operacion);

ALTER TABLE ONLY public.pago
    ADD CONSTRAINT pago_clave_idempotencia_key UNIQUE (clave_idempotencia);

ALTER TABLE ONLY public.pago
    ADD CONSTRAINT pago_pkey PRIMARY KEY (id_pago);

ALTER TABLE ONLY public.pago
    ADD CONSTRAINT pago_referencia_stripe_key UNIQUE (referencia_stripe);

ALTER TABLE ONLY public.periodo_disponibilidad
    ADD CONSTRAINT periodo_disponibilidad_pkey PRIMARY KEY (id_periodo);

ALTER TABLE ONLY public.politica_cancelacion
    ADD CONSTRAINT politica_cancelacion_pkey PRIMARY KEY (id_politica);

ALTER TABLE ONLY public.publicacion
    ADD CONSTRAINT publicacion_id_alojamiento_key UNIQUE (id_alojamiento);

ALTER TABLE ONLY public.publicacion
    ADD CONSTRAINT publicacion_pkey PRIMARY KEY (id_publicacion);

ALTER TABLE ONLY public.publicacion_servicio
    ADD CONSTRAINT publicacion_servicio_pkey PRIMARY KEY (id_publicacion, id_servicio);

ALTER TABLE ONLY public.resena
    ADD CONSTRAINT resena_id_reserva_key UNIQUE (id_reserva);

ALTER TABLE ONLY public.resena
    ADD CONSTRAINT resena_pkey PRIMARY KEY (id_resena);

ALTER TABLE ONLY public.reserva
    ADD CONSTRAINT reserva_clave_idempotencia_key UNIQUE (clave_idempotencia);

ALTER TABLE ONLY public.reserva
    ADD CONSTRAINT reserva_id_cotizacion_key UNIQUE (id_cotizacion);

ALTER TABLE ONLY public.reserva_noche
    ADD CONSTRAINT reserva_noche_pkey PRIMARY KEY (id_noche);

ALTER TABLE ONLY public.reserva
    ADD CONSTRAINT reserva_pkey PRIMARY KEY (id_reserva);

ALTER TABLE ONLY public.revision_publicacion
    ADD CONSTRAINT revision_publicacion_pkey PRIMARY KEY (id_revision);

ALTER TABLE ONLY public.rol
    ADD CONSTRAINT rol_nombre_key UNIQUE (nombre);

ALTER TABLE ONLY public.rol
    ADD CONSTRAINT rol_pkey PRIMARY KEY (id_rol);

ALTER TABLE ONLY public.servicio_adicional
    ADD CONSTRAINT servicio_adicional_pkey PRIMARY KEY (id_adicional);

ALTER TABLE ONLY public.servicio
    ADD CONSTRAINT servicio_nombre_key UNIQUE (nombre);

ALTER TABLE ONLY public.servicio
    ADD CONSTRAINT servicio_pkey PRIMARY KEY (id_servicio);

ALTER TABLE ONLY public.servicio_adicional
    ADD CONSTRAINT uq_adicional_nombre UNIQUE (id_publicacion, nombre);

ALTER TABLE ONLY public.imagen_publicacion
    ADD CONSTRAINT uq_imagen_orden UNIQUE (id_publicacion, orden);

ALTER TABLE ONLY public.noche_reservada
    ADD CONSTRAINT uq_noche_alojamiento_fecha UNIQUE (id_alojamiento, fecha);

ALTER TABLE ONLY public.politica_cancelacion
    ADD CONSTRAINT uq_politica_nombre_version UNIQUE (nombre, version);

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_documento_hash_key UNIQUE (documento_hash);

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario);

ALTER TABLE ONLY public.verificacion_correo
    ADD CONSTRAINT verificacion_correo_pkey PRIMARY KEY (id_verificacion);

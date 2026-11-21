-- ============================================================
-- LLAVES FORANEAS
-- Proyecto: Marketplace
-- Motor: PostgreSQL
-- ============================================================

ALTER TABLE ONLY public.alojamiento
    ADD CONSTRAINT alojamiento_id_anfitrion_fkey FOREIGN KEY (id_anfitrion) REFERENCES public.usuario(id_usuario);

ALTER TABLE ONLY public.bandeja_salida_auditoria
    ADD CONSTRAINT bandeja_salida_auditoria_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);

ALTER TABLE ONLY public.cancelacion
    ADD CONSTRAINT cancelacion_id_reserva_fkey FOREIGN KEY (id_reserva) REFERENCES public.reserva(id_reserva);

ALTER TABLE ONLY public.cancelacion
    ADD CONSTRAINT cancelacion_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);

ALTER TABLE ONLY public.configuracion_tarifa
    ADD CONSTRAINT configuracion_tarifa_id_administrador_fkey FOREIGN KEY (id_administrador) REFERENCES public.usuario(id_usuario);

ALTER TABLE ONLY public.cotizacion_adicional
    ADD CONSTRAINT cotizacion_adicional_id_adicional_fkey FOREIGN KEY (id_adicional) REFERENCES public.servicio_adicional(id_adicional);

ALTER TABLE ONLY public.cotizacion_adicional
    ADD CONSTRAINT cotizacion_adicional_id_cotizacion_fkey FOREIGN KEY (id_cotizacion) REFERENCES public.cotizacion(id_cotizacion);

ALTER TABLE ONLY public.cotizacion
    ADD CONSTRAINT cotizacion_id_configuracion_fkey FOREIGN KEY (id_configuracion) REFERENCES public.configuracion_tarifa(id_configuracion);

ALTER TABLE ONLY public.cotizacion
    ADD CONSTRAINT cotizacion_id_publicacion_fkey FOREIGN KEY (id_publicacion) REFERENCES public.publicacion(id_publicacion);

ALTER TABLE ONLY public.exportacion_reporte
    ADD CONSTRAINT exportacion_reporte_id_administrador_fkey FOREIGN KEY (id_administrador) REFERENCES public.usuario(id_usuario);

ALTER TABLE ONLY public.verificacion_correo
    ADD CONSTRAINT fk_verificacion_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario) ON DELETE CASCADE;

ALTER TABLE ONLY public.imagen_publicacion
    ADD CONSTRAINT imagen_publicacion_id_publicacion_fkey FOREIGN KEY (id_publicacion) REFERENCES public.publicacion(id_publicacion);

ALTER TABLE ONLY public.noche_reservada
    ADD CONSTRAINT noche_reservada_id_alojamiento_fkey FOREIGN KEY (id_alojamiento) REFERENCES public.alojamiento(id_alojamiento);

ALTER TABLE ONLY public.notificacion
    ADD CONSTRAINT notificacion_id_publicacion_fkey FOREIGN KEY (id_publicacion) REFERENCES public.publicacion(id_publicacion);

ALTER TABLE ONLY public.notificacion
    ADD CONSTRAINT notificacion_id_reserva_fkey FOREIGN KEY (id_reserva) REFERENCES public.reserva(id_reserva);

ALTER TABLE ONLY public.notificacion
    ADD CONSTRAINT notificacion_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);

ALTER TABLE ONLY public.operacion_pendiente
    ADD CONSTRAINT operacion_pendiente_id_pago_fkey FOREIGN KEY (id_pago) REFERENCES public.pago(id_pago);

ALTER TABLE ONLY public.operacion_pendiente
    ADD CONSTRAINT operacion_pendiente_id_reserva_fkey FOREIGN KEY (id_reserva) REFERENCES public.reserva(id_reserva);

ALTER TABLE ONLY public.pago
    ADD CONSTRAINT pago_id_reserva_fkey FOREIGN KEY (id_reserva) REFERENCES public.reserva(id_reserva);

ALTER TABLE ONLY public.periodo_disponibilidad
    ADD CONSTRAINT periodo_disponibilidad_id_alojamiento_fkey FOREIGN KEY (id_alojamiento) REFERENCES public.alojamiento(id_alojamiento);

ALTER TABLE ONLY public.publicacion
    ADD CONSTRAINT publicacion_id_alojamiento_fkey FOREIGN KEY (id_alojamiento) REFERENCES public.alojamiento(id_alojamiento);

ALTER TABLE ONLY public.publicacion
    ADD CONSTRAINT publicacion_id_politica_fkey FOREIGN KEY (id_politica) REFERENCES public.politica_cancelacion(id_politica);

ALTER TABLE ONLY public.publicacion_servicio
    ADD CONSTRAINT publicacion_servicio_id_publicacion_fkey FOREIGN KEY (id_publicacion) REFERENCES public.publicacion(id_publicacion);

ALTER TABLE ONLY public.publicacion_servicio
    ADD CONSTRAINT publicacion_servicio_id_servicio_fkey FOREIGN KEY (id_servicio) REFERENCES public.servicio(id_servicio);

ALTER TABLE ONLY public.resena
    ADD CONSTRAINT resena_id_administrador_moderador_fkey FOREIGN KEY (id_administrador_moderador) REFERENCES public.usuario(id_usuario);

ALTER TABLE ONLY public.resena
    ADD CONSTRAINT resena_id_reserva_fkey FOREIGN KEY (id_reserva) REFERENCES public.reserva(id_reserva);

ALTER TABLE ONLY public.reserva
    ADD CONSTRAINT reserva_id_cotizacion_fkey FOREIGN KEY (id_cotizacion) REFERENCES public.cotizacion(id_cotizacion);

ALTER TABLE ONLY public.reserva
    ADD CONSTRAINT reserva_id_huesped_fkey FOREIGN KEY (id_huesped) REFERENCES public.usuario(id_usuario);

ALTER TABLE ONLY public.reserva
    ADD CONSTRAINT reserva_id_politica_aplicada_fkey FOREIGN KEY (id_politica_aplicada) REFERENCES public.politica_cancelacion(id_politica);

ALTER TABLE ONLY public.reserva_noche
    ADD CONSTRAINT reserva_noche_id_noche_fkey FOREIGN KEY (id_noche) REFERENCES public.noche_reservada(id_noche) ON DELETE CASCADE;

ALTER TABLE ONLY public.reserva_noche
    ADD CONSTRAINT reserva_noche_id_reserva_fkey FOREIGN KEY (id_reserva) REFERENCES public.reserva(id_reserva);

ALTER TABLE ONLY public.revision_publicacion
    ADD CONSTRAINT revision_publicacion_id_administrador_fkey FOREIGN KEY (id_administrador) REFERENCES public.usuario(id_usuario);

ALTER TABLE ONLY public.revision_publicacion
    ADD CONSTRAINT revision_publicacion_id_publicacion_fkey FOREIGN KEY (id_publicacion) REFERENCES public.publicacion(id_publicacion);

ALTER TABLE ONLY public.servicio_adicional
    ADD CONSTRAINT servicio_adicional_id_publicacion_fkey FOREIGN KEY (id_publicacion) REFERENCES public.publicacion(id_publicacion);

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_id_rol_fkey FOREIGN KEY (id_rol) REFERENCES public.rol(id_rol);

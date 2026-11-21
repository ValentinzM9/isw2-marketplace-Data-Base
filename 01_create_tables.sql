-- ============================================================
-- CREACION DE TABLAS
-- Proyecto: Marketplace
-- Motor: PostgreSQL
-- ============================================================

CREATE TABLE public.alojamiento (
    id_alojamiento uuid NOT NULL,
    id_anfitrion uuid NOT NULL,
    ubicacion character varying(255) NOT NULL,
    ciudad character varying(100) NOT NULL,
    tipo_alojamiento character varying(50) NOT NULL,
    capacidad integer NOT NULL,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT chk_alojamiento_capacidad CHECK ((capacidad > 0))
);

CREATE TABLE public.bandeja_salida_auditoria (
    id_evento uuid NOT NULL,
    id_usuario uuid,
    fecha_evento timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    accion character varying(100) NOT NULL,
    resultado character varying(30) NOT NULL,
    entidad_afectada character varying(50) NOT NULL,
    id_entidad_afectada uuid,
    detalle jsonb,
    id_correlacion character varying(100),
    estado_envio character varying(20) DEFAULT 'PENDIENTE'::character varying NOT NULL,
    intentos_envio integer DEFAULT 0 NOT NULL,
    proxima_ejecucion timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    fecha_envio timestamp with time zone,
    ultimo_error text,
    CONSTRAINT chk_auditoria_envio CHECK ((((estado_envio)::text <> 'ENVIADO'::text) OR (fecha_envio IS NOT NULL))),
    CONSTRAINT chk_auditoria_estado CHECK (((estado_envio)::text = ANY ((ARRAY['PENDIENTE'::character varying, 'EN_PROCESO'::character varying, 'ENVIADO'::character varying, 'ERROR'::character varying])::text[]))),
    CONSTRAINT chk_auditoria_intentos CHECK ((intentos_envio >= 0))
);

CREATE TABLE public.cancelacion (
    id_cancelacion uuid NOT NULL,
    id_reserva uuid NOT NULL,
    id_usuario uuid NOT NULL,
    fecha_cancelacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    motivo text NOT NULL,
    valor_devolucion numeric(12,2) DEFAULT 0 NOT NULL,
    estado_devolucion character varying(30) NOT NULL,
    estado_final character varying(30) NOT NULL,
    CONSTRAINT chk_cancelacion_devolucion CHECK ((valor_devolucion >= (0)::numeric)),
    CONSTRAINT chk_cancelacion_estado CHECK (((estado_devolucion)::text = ANY ((ARRAY['NO_APLICA'::character varying, 'PENDIENTE'::character varying, 'PROCESADA'::character varying, 'FALLIDA'::character varying])::text[])))
);

CREATE TABLE public.configuracion_tarifa (
    id_configuracion uuid NOT NULL,
    id_administrador uuid NOT NULL,
    porcentaje_servicio numeric(5,2) NOT NULL,
    porcentaje_descuento numeric(5,2) DEFAULT 0 NOT NULL,
    vigente_desde timestamp with time zone NOT NULL,
    vigente_hasta timestamp with time zone,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT chk_configuracion_descuento CHECK (((porcentaje_descuento >= (0)::numeric) AND (porcentaje_descuento <= (100)::numeric))),
    CONSTRAINT chk_configuracion_servicio CHECK (((porcentaje_servicio >= (0)::numeric) AND (porcentaje_servicio <= (100)::numeric))),
    CONSTRAINT chk_configuracion_vigencia CHECK (((vigente_hasta IS NULL) OR (vigente_hasta > vigente_desde)))
);

CREATE TABLE public.cotizacion (
    id_cotizacion uuid NOT NULL,
    id_publicacion uuid NOT NULL,
    id_configuracion uuid NOT NULL,
    fecha_entrada date NOT NULL,
    fecha_salida date NOT NULL,
    cantidad_huespedes integer NOT NULL,
    precio_noche_aplicado numeric(12,2) NOT NULL,
    tarifa_limpieza numeric(12,2) DEFAULT 0 NOT NULL,
    fecha_cotizacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT chk_cotizacion_fechas CHECK ((fecha_salida > fecha_entrada)),
    CONSTRAINT chk_cotizacion_huespedes CHECK ((cantidad_huespedes > 0)),
    CONSTRAINT chk_cotizacion_limpieza CHECK ((tarifa_limpieza >= (0)::numeric)),
    CONSTRAINT chk_cotizacion_precio CHECK ((precio_noche_aplicado > (0)::numeric))
);

CREATE TABLE public.cotizacion_adicional (
    id_cotizacion uuid NOT NULL,
    id_adicional uuid NOT NULL,
    cantidad integer NOT NULL,
    precio_aplicado numeric(12,2) NOT NULL,
    CONSTRAINT chk_cotad_cantidad CHECK ((cantidad > 0)),
    CONSTRAINT chk_cotad_precio CHECK ((precio_aplicado >= (0)::numeric))
);

CREATE TABLE public.exportacion_reporte (
    id_exportacion uuid NOT NULL,
    id_administrador uuid NOT NULL,
    tipo_reporte character varying(50) NOT NULL,
    formato character varying(10) NOT NULL,
    filtros jsonb,
    estado character varying(30) DEFAULT 'SOLICITADO'::character varying NOT NULL,
    fecha_solicitud timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    fecha_corte_datos timestamp with time zone,
    fecha_generacion timestamp with time zone,
    ruta_archivo character varying(500),
    CONSTRAINT chk_exportacion_estado CHECK (((estado)::text = ANY ((ARRAY['SOLICITADO'::character varying, 'EN_PROCESO'::character varying, 'COMPLETADO'::character varying, 'FALLIDO'::character varying])::text[]))),
    CONSTRAINT chk_exportacion_fechas CHECK ((((fecha_corte_datos IS NULL) OR (fecha_corte_datos >= fecha_solicitud)) AND ((fecha_generacion IS NULL) OR (fecha_generacion >= fecha_solicitud)))),
    CONSTRAINT chk_exportacion_formato CHECK (((formato)::text = ANY ((ARRAY['PDF'::character varying, 'EXCEL'::character varying])::text[]))),
    CONSTRAINT chk_exportacion_resultado CHECK ((((estado)::text <> 'COMPLETADO'::text) OR ((fecha_generacion IS NOT NULL) AND (fecha_corte_datos IS NOT NULL) AND (ruta_archivo IS NOT NULL))))
);

CREATE TABLE public.imagen_publicacion (
    id_imagen uuid NOT NULL,
    id_publicacion uuid NOT NULL,
    ruta_imagen character varying(500) NOT NULL,
    orden integer NOT NULL,
    es_portada boolean DEFAULT false NOT NULL,
    CONSTRAINT chk_imagen_orden CHECK ((orden > 0))
);

CREATE TABLE public.noche_reservada (
    id_noche uuid NOT NULL,
    id_alojamiento uuid NOT NULL,
    fecha date NOT NULL
);

CREATE TABLE public.notificacion (
    id_notificacion uuid NOT NULL,
    id_usuario uuid NOT NULL,
    id_reserva uuid,
    id_publicacion uuid,
    tipo character varying(50) NOT NULL,
    mensaje text NOT NULL,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    fecha_lectura timestamp with time zone,
    CONSTRAINT chk_notificacion_fecha CHECK (((fecha_lectura IS NULL) OR (fecha_lectura >= fecha_creacion)))
);

CREATE TABLE public.operacion_pendiente (
    id_operacion uuid NOT NULL,
    id_reserva uuid NOT NULL,
    id_pago uuid,
    tipo_operacion character varying(40) DEFAULT 'CONCILIAR_PAGO'::character varying NOT NULL,
    estado character varying(20) DEFAULT 'PENDIENTE'::character varying NOT NULL,
    intentos integer DEFAULT 0 NOT NULL,
    proxima_ejecucion timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    ultima_ejecucion timestamp with time zone,
    ultimo_error text,
    clave_idempotencia character varying(100) NOT NULL,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    fecha_actualizacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT chk_operacion_estado CHECK (((estado)::text = ANY ((ARRAY['PENDIENTE'::character varying, 'EN_PROCESO'::character varying, 'COMPLETADA'::character varying, 'FALLIDA'::character varying])::text[]))),
    CONSTRAINT chk_operacion_intentos CHECK ((intentos >= 0)),
    CONSTRAINT chk_operacion_tipo CHECK (((tipo_operacion)::text = 'CONCILIAR_PAGO'::text))
);

CREATE TABLE public.pago (
    id_pago uuid NOT NULL,
    id_reserva uuid NOT NULL,
    referencia_stripe character varying(255),
    clave_idempotencia character varying(100) NOT NULL,
    monto numeric(12,2) NOT NULL,
    estado character varying(30) DEFAULT 'PENDIENTE'::character varying NOT NULL,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    fecha_pago timestamp with time zone,
    CONSTRAINT chk_pago_estado CHECK (((estado)::text = ANY ((ARRAY['PENDIENTE'::character varying, 'PAGADO'::character varying, 'FALLIDO'::character varying, 'REEMBOLSADO'::character varying])::text[]))),
    CONSTRAINT chk_pago_fecha CHECK (((fecha_pago IS NULL) OR (fecha_pago >= fecha_creacion))),
    CONSTRAINT chk_pago_monto CHECK ((monto > (0)::numeric))
);

CREATE TABLE public.periodo_disponibilidad (
    id_periodo uuid NOT NULL,
    id_alojamiento uuid NOT NULL,
    fecha_inicio date NOT NULL,
    fecha_fin date NOT NULL,
    habilitado boolean DEFAULT true NOT NULL,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT chk_periodo_fechas CHECK ((fecha_fin > fecha_inicio))
);

CREATE TABLE public.politica_cancelacion (
    id_politica uuid NOT NULL,
    nombre character varying(50) NOT NULL,
    version integer NOT NULL,
    descripcion text,
    anticipacion_horas integer,
    porcentaje_devolucion numeric(5,2) NOT NULL,
    activa boolean DEFAULT true NOT NULL,
    CONSTRAINT chk_politica_anticipacion CHECK (((anticipacion_horas IS NULL) OR (anticipacion_horas >= 0))),
    CONSTRAINT chk_politica_devolucion CHECK (((porcentaje_devolucion >= (0)::numeric) AND (porcentaje_devolucion <= (100)::numeric))),
    CONSTRAINT chk_politica_version CHECK ((version > 0))
);

CREATE TABLE public.publicacion (
    id_publicacion uuid NOT NULL,
    id_alojamiento uuid NOT NULL,
    id_politica uuid NOT NULL,
    titulo character varying(200) NOT NULL,
    descripcion text NOT NULL,
    reglas text NOT NULL,
    precio_por_noche numeric(12,2) NOT NULL,
    tarifa_limpieza numeric(12,2) DEFAULT 0 NOT NULL,
    modo_aceptacion character varying(30) NOT NULL,
    estado character varying(30) DEFAULT 'BORRADOR'::character varying NOT NULL,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    fecha_actualizacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT chk_publicacion_aceptacion CHECK (((modo_aceptacion)::text = ANY ((ARRAY['INMEDIATA'::character varying, 'APROBACION'::character varying])::text[]))),
    CONSTRAINT chk_publicacion_estado CHECK (((estado)::text = ANY ((ARRAY['BORRADOR'::character varying, 'PENDIENTE_REVISION'::character varying, 'ACTIVA'::character varying, 'PAUSADA'::character varying, 'BLOQUEADA'::character varying])::text[]))),
    CONSTRAINT chk_publicacion_limpieza CHECK ((tarifa_limpieza >= (0)::numeric)),
    CONSTRAINT chk_publicacion_precio CHECK ((precio_por_noche > (0)::numeric))
);

CREATE TABLE public.publicacion_servicio (
    id_publicacion uuid NOT NULL,
    id_servicio uuid NOT NULL
);

CREATE TABLE public.resena (
    id_resena uuid NOT NULL,
    id_reserva uuid NOT NULL,
    calificacion integer NOT NULL,
    comentario text NOT NULL,
    visible boolean DEFAULT true NOT NULL,
    fecha_publicacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    id_administrador_moderador uuid,
    motivo_ocultamiento text,
    fecha_ocultamiento timestamp with time zone,
    CONSTRAINT chk_resena_calificacion CHECK (((calificacion >= 1) AND (calificacion <= 5))),
    CONSTRAINT chk_resena_moderacion CHECK ((((visible = true) AND (id_administrador_moderador IS NULL) AND (motivo_ocultamiento IS NULL) AND (fecha_ocultamiento IS NULL)) OR ((visible = false) AND (id_administrador_moderador IS NOT NULL) AND (motivo_ocultamiento IS NOT NULL) AND (fecha_ocultamiento IS NOT NULL))))
);

CREATE TABLE public.reserva (
    id_reserva uuid NOT NULL,
    id_huesped uuid NOT NULL,
    id_cotizacion uuid NOT NULL,
    id_politica_aplicada uuid NOT NULL,
    modo_aceptacion character varying(30) NOT NULL,
    estado character varying(30) NOT NULL,
    retencion_hasta timestamp with time zone,
    clave_idempotencia character varying(100) NOT NULL,
    requiere_revision_manual boolean DEFAULT false NOT NULL,
    fecha_solicitud timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    fecha_confirmacion timestamp with time zone,
    CONSTRAINT chk_reserva_aceptacion CHECK (((modo_aceptacion)::text = ANY ((ARRAY['INMEDIATA'::character varying, 'APROBACION'::character varying])::text[]))),
    CONSTRAINT chk_reserva_confirmacion CHECK (((fecha_confirmacion IS NULL) OR (fecha_confirmacion >= fecha_solicitud))),
    CONSTRAINT chk_reserva_estado CHECK (((estado)::text = ANY ((ARRAY['PENDIENTE_PAGO'::character varying, 'PENDIENTE_APROBACION'::character varying, 'CONFIRMADA'::character varying, 'RECHAZADA'::character varying, 'CANCELADA'::character varying, 'COMPLETADA'::character varying, 'EXPIRADA'::character varying])::text[])))
);

CREATE TABLE public.reserva_noche (
    id_noche uuid NOT NULL,
    id_reserva uuid NOT NULL
);

CREATE TABLE public.revision_publicacion (
    id_revision uuid NOT NULL,
    id_publicacion uuid NOT NULL,
    id_administrador uuid NOT NULL,
    accion character varying(50) NOT NULL,
    resultado character varying(30) NOT NULL,
    motivo text,
    fecha_revision timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE public.rol (
    id_rol uuid NOT NULL,
    nombre character varying(50) NOT NULL,
    descripcion text
);

CREATE TABLE public.servicio (
    id_servicio uuid NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion text
);

CREATE TABLE public.servicio_adicional (
    id_adicional uuid NOT NULL,
    id_publicacion uuid NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion text,
    costo numeric(12,2) NOT NULL,
    activo boolean DEFAULT true NOT NULL,
    CONSTRAINT chk_adicional_costo CHECK ((costo >= (0)::numeric))
);

CREATE TABLE public.usuario (
    id_usuario uuid NOT NULL,
    id_rol uuid NOT NULL,
    nombre character varying(50) NOT NULL,
    apellido character varying(50) NOT NULL,
    correo character varying(254) NOT NULL,
    tipo_documento character varying(30) NOT NULL,
    documento_cifrado bytea NOT NULL,
    documento_nonce bytea NOT NULL,
    documento_hash bytea NOT NULL,
    telefono character varying(20) NOT NULL,
    contrasena_hash character varying(255) NOT NULL,
    correo_verificado boolean DEFAULT false NOT NULL,
    estado character varying(30) DEFAULT 'PENDIENTE_VERIFICACION'::character varying NOT NULL,
    restringido boolean DEFAULT false NOT NULL,
    intentos_fallidos integer DEFAULT 0 NOT NULL,
    motivo_restriccion text,
    fecha_registro timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    fecha_actualizacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    motivo_bloqueo character varying(255),
    CONSTRAINT chk_documento_hash CHECK ((octet_length(documento_hash) = 32)),
    CONSTRAINT chk_documento_nonce CHECK ((octet_length(documento_nonce) = 12)),
    CONSTRAINT chk_usuario_estado CHECK (((estado)::text = ANY ((ARRAY['PENDIENTE_VERIFICACION'::character varying, 'ACTIVA'::character varying, 'INACTIVA'::character varying])::text[]))),
    CONSTRAINT chk_usuario_intentos CHECK ((intentos_fallidos >= 0)),
    CONSTRAINT chk_usuario_motivo CHECK (((restringido AND (motivo_restriccion IS NOT NULL) AND (length(btrim(motivo_restriccion)) > 0)) OR ((NOT restringido) AND (motivo_restriccion IS NULL))))
);

CREATE TABLE public.verificacion_correo (
    id_verificacion uuid NOT NULL,
    id_usuario uuid NOT NULL,
    codigo_hash character varying(255) NOT NULL,
    fecha_expiracion timestamp with time zone NOT NULL,
    verificado boolean DEFAULT false NOT NULL,
    intentos integer DEFAULT 0 NOT NULL,
    CONSTRAINT chk_intentos_verificacion CHECK ((intentos >= 0))
);

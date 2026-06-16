# CONTEXT GUARDIAN — Memory Update v7.2
# Cargado automáticamente por Roo Code para el modo context-guardian

⚠️ REGLA ABSOLUTA. Solo ejecutar al final de una feature exitosa.

---

## PASO 1 — LEER CONTEXTO ACTUAL

```
docs/swarm-context.md
docs/project-profile.md
docs/specs/{slug}/execution_plan.yaml
docs/specs/{slug}/evidence-report.md
docs/errors/*.md (errores de esta feature)
docs/specs/{slug}/hermes-output-*.md (aprendizajes de hermes)
docs/specs/{slug}/predictive-report.md (precisión de predicciones)
```

---

## PASO 2 — ACTUALIZAR SWARM-CONTEXT.MD

### Sección `features_completadas`
```yaml
- id: FEAT-{NNN}
  nombre: {nombre}
  fecha: {ISO date}
  story_points: {SP}
  modo: prototype | beta | production
  perfil: {project_type}
  workers_usados: [lista slugs]
  errores: {N}
  duracion_min: {T}
  costo_real_usd: {X.XX}
```

### Sección `error_patterns`
```yaml
- id: PATRON-{NNN}
  descripcion: {texto}
  stack: {stack afectado}
  frecuencia: {N}
  mitigacion: {accion}
```

### Sección `stack_learnings`
Si el proyecto usa un stack nuevo o no visto antes:
```yaml
- stack: {nombre}
  aprendido: {fecha}
  gotchas: [lista de trampas encontradas]
  patrones_exitosos: [lo que funcionó bien]
  patterns_fallidos: [lo que no funcionó]
```

### Sección `tier05_learning`
```yaml
compatible: [{tipo_tarea, stack}]
incompatible: [{tipo_tarea, stack, motivo}]
costo_acumulado_usd: {X}
```

---

## PASO 3 — ACTUALIZAR SESSION_CONTEXT

Actualizar `docs/swarm-context.md → session_context`:

```yaml
session_context:
  last_updated: {ISO datetime}
  last_feature_in_progress: null  # o slug si quedó incompleta
  last_gate_reached: {gate}       # último gate superado
  next_action: {accion_sugerida}  # ej: "continuar FASE 5 de FEAT-042"

  user_preferences:
    tono_detectado: formal | casual | tecnico | mixto
    nivel_tecnico: basico | intermedio | avanzado
    velocidad_preferida: rapido | cuidadoso | equilibrado
    idioma_preferido: {es | en | mixto}
    estilo_feedback: "prefiere opciones" | "prefiere recomendaciones directas"

  decisiones_rechazadas:
    - fecha: {fecha}
      propuesta: {descripcion breve}
      motivo_rechazo: {si lo mencionó}

  contexto_proyecto_activo:
    profile: {perfil del proyecto actual}
    stack_summary: {string corto}
    feature_activa: {slug o null}
```

---

## PASO 4 — ACTUALIZAR COGNITIVE_MEMORY (NUEVO v7.2)

Esta sección es crítica para la experiencia personalizada.

```yaml
cognitive_memory:
  last_updated: {ISO datetime}
  version: "7.2"

  stack_patterns:
    - stack: "{stack_usado}"
      frecuencia: {N}
      contexto: "{tipo de feature}"
      ultimo_uso: "{fecha}"
      confianza: {X.XX}

  decision_patterns:
    rechazadas:
      - propuesta: "{texto}"
        motivo_rechazo: "{texto}"
        alternativa_elegida: "{texto}"
        frecuencia_rechazo: {N}
        nunca_volver_a_proponer: {true|false}
    aceptadas:
      - propuesta: "{texto}"
        contexto: "{texto}"
        frecuencia: {N}
        sugerir_primero: {true|false}

  mode_prediction:
    historial:
      - fecha: "{fecha}"
        input_usuario: "{texto}"
        modo_elegido: "prototype|beta|production"
        tiempo_decision: "{T}"
    reglas_detectadas:
      - "{regla detectada}"

  user_preferences:
    tono_detectado: {tono}
    nivel_tecnico: {nivel}
    velocidad_preferida: {velocidad}
    idioma_preferido: {idioma}
    estilo_feedback: {estilo}
    horario_activo: "{hora}"
    dias_activo: [{dias}]

  error_learning:
    - stack: "{stack}"
      error: "{descripcion}"
      frecuencia: {N}
      mitigacion: "{accion}"
      alerta_previa: {true|false}

  predictions_activas:
    - tipo: "stack_sugerido"
      valor: "{stack}"
      confianza: {X.XX}
      basado_en: "{razon}"
```

### CÓMO DETECTAR PREFERENCIAS DEL USUARIO

**Tono:** Leer mensajes del usuario en `docs/specs/{slug}/requirements-draft.md`
- Usa emojis o lenguaje informal → `casual`
- Mensajes cortos y directos → `tecnico`
- Mensajes largos y descriptivos → `formal`
- Mezcla → `mixto`

**Nivel técnico:**
- Usa términos técnicos correctamente → `avanzado`
- Mezcla términos técnicos y coloquiales → `intermedio`
- Describe funcionalidades sin términos técnicos → `basico`

**Velocidad:** Detectar si el usuario pidió prototype (→ `rapido`), beta (→ `equilibrado`), o producción (→ `cuidadoso`).

---

## PASO 5 — ACTUALIZAR CONTINUITY ENGINE (NUEVO v7.2)

```
Archivar checkpoints de esta feature:
  mv docs/checkpoints/CP-*-{slug}.yaml docs/checkpoints/archive/

Actualizar checkpoint-index.md
```

---

## PASO 6 — LIMPIEZA

```bash
# Mover errores a archivo
mv docs/errors/{fecha}.md docs/errors/archive/
```

---

## OUTPUT

Escribir `docs/specs/{slug}/memory-updated.md`:
```
MEMORY_UPDATED ✓ | FEAT-{NNN} archivada
SESSION_CONTEXT actualizado
COGNITIVE_MEMORY actualizada
CONTINUITY_CHECKPOINTS archivados
Próxima sesión arrancará desde: {next_action}
```

Al finalizar:
```
🧬 MEMORIA ACTUALIZADA ✓
Feature FEAT-{NNN} completada y archivada.
Session context guardado — próxima sesión continuará desde: {next_action}
Cognitive memory aprendió {N} patrones nuevos.

¿Iniciamos una nueva idea? → /idea "..." o /enrich_us "..."
```

# MICROMANAGER — CoALA Universal v7.2
# Cargado automáticamente por Roo Code para el modo micromanager

⚠️ REGLA ABSOLUTA. Leer .roo/rules/global-rules.md antes de actuar.
⚠️ SIEMPRE leer docs/project-profile.md y docs/swarm-context.md al inicio.

---

## PASO 0 — CONTINUIDAD DE SESIÓN (v7.2 mejorado)

### Al inicio de CADA sesión:

1. Leer `docs/swarm-context.md → session_context`
2. Leer `docs/checkpoints/checkpoint-index.md` (continuity-engine)
3. Leer `docs/swarm-context.md → cognitive_memory` (preferencias)

Si hay checkpoints activos:
```
⏸️ SESIONES PAUSADAS DETECTADAS (vía continuity-engine)
═══════════════════════════════════════════════════════

[Tienes {N} sesión(es) pausada(s). ¿Cuál continuamos?]

[▶️ CONTINUAR {feature}] → cargar checkpoint + execution_plan
[🆕 NUEVA FEATURE] → activar idea-clarifier
```

Si `session_context.last_feature_in_progress` existe y no hay checkpoints:
```
⏸️ SESIÓN ANTERIOR DETECTADA
═══════════════════════════
Feature en progreso: {feature}
Último gate alcanzado: {gate}
Siguiente acción sugerida: {next_action}

¿Continuamos desde donde quedamos o empezamos algo nuevo?
[▶️ CONTINUAR] → cargar execution_plan.yaml de esa feature
[🆕 NUEVA FEATURE] → activar idea-clarifier o us-enricher
```

---

## CAPA 1: WORKING MEMORY (WM)

```
WM.pipeline_state:  fase actual del execution_plan.yaml
WM.current_phase:   índice numérico de la fase en curso
WM.active_worker:   slug del worker en ejecución o pendiente
WM.gate_status:     último gate verificado
WM.blocked_reason:  motivo exacto si gate_status = GATE_BLOCKED
WM.output_files:    mapa {worker_slug: path_output_file_esperado}
WM.stack_profile:   perfil detectado en docs/project-profile.md
WM.pipeline_mode:   prototype | beta | production (detectado del brief)
WM.checkpoint_id:   último checkpoint de continuity-engine
WM.cognitive_hint:  sugerencia de cognitive-memory para esta fase
```

---

## CAPA 2: EPISODIC MEMORY (EM)

```
EM.last_errors[worker]:    últimos 3 errores registrados
EM.fallback_count[worker]: número de veces escalado en sesión
EM.pattern_flags:          LOOP_DETECTED | INFO_MISSING | SPEC_INVALID
EM.feature_history:        features relacionadas completadas
EM.rejected_proposals:     decisiones rechazadas por usuario (no repetir)
EM.hermes_failures:        fases delegadas a hermes que fallaron
EM.nexus_predictions:      predicciones de nexus-predictive aplicadas
```

---

## CAPA 3: SEMANTIC MEMORY (SM) — DINÁMICA

**SIEMPRE leer desde `docs/project-profile.md`. NUNCA hardcodear.**

```
SM.project_type     ← docs/project-profile.md :: profile_confirmed
SM.stack            ← docs/project-profile.md :: stack_summary
SM.infra            ← docs/project-profile.md :: infra (si aplica)
SM.dev_env          ← docs/project-profile.md :: dev_env_commands
SM.domain           ← docs/project-profile.md :: domain
SM.specialists      ← docs/project-profile.md :: specialists_available
SM.mcp_servers      ← docs/swarm-context.md :: mcp_servers
SM.credentials_src  ← docs/CREDENTIALS_INFRASTRUCTURE.md
SM.gitnexus_avail   ← "gitnexus" en SM.mcp_servers → true | false
SM.hermes_avail     ← "hermes-acp" en SM.mcp_servers → true | false
SM.cognitive_avail  ← "cognitive-memory" en SM.mcp_servers → true | false
SM.continuity_avail ← "continuity-engine" en SM.mcp_servers → true | false
```

---

## CAPA 4: PROCEDURAL MEMORY (PM)

```
PM.escalation:      T0.5 falla×3→T1 | T1 falla×2→T2 | T2 falla×1→STOP+usuario
PM.confidence_threshold: 0.7
PM.tdd_rule:        code-expert NO activa hasta TESTS_FAILING
PM.output_contract: cada worker escribe output_file antes de terminar
PM.commit_format:   Conventional Commits obligatorio
PM.gate_sequence_production:
  [ENRICH_APPROVED → PROFILE_VALID → SPEC_VALID → TESTS_FAILING →
   TESTS_PASSING_100 → EVIDENCE_VERIFIED]
PM.gate_sequence_beta:
  [ENRICH_APPROVED → PROFILE_VALID → SPEC_VALID_BETA → TESTS_FAILING →
   TESTS_PASSING_80 → REVIEW_BETA → EVIDENCE_BETA → SECURITY_PASS]
PM.gate_sequence_prototype:
  [ENRICH_APPROVED → PROFILE_VALID → SPEC_VALID_MINI → OUTPUT_EXISTS]
PM.continuous_flow: cada fase termina con [SI / NO / CORREGIR]
PM.hermes_delegation: micromanager puede delegar FASES COMPLETAS a hermes-agent
PM.nexus_check:     si SM.gitnexus_avail → nexus-predictive antes de implementación
PM.checkpoint_rule: crear checkpoint automático en cada gate + cada 30 min
PM.cognitive_hint:  si SM.cognitive_avail → consultar cognitive-memory antes de cada fase
```

---

## DETECCIÓN DE MODO PIPELINE

Leer `docs/specs/{slug}/requirements-draft.md` → buscar `[PIPELINE: ...]`

Valores posibles: `prototype`, `beta`, `production`

```
Si detecta prototype → WM.pipeline_mode = prototype
Si detecta beta      → WM.pipeline_mode = beta
Si detecta production o no hay indicador → WM.pipeline_mode = production

Mostrar al usuario:
🔧 MODO DETECTADO: {PROTOTIPO 🚀 / BETA 🧪 / PRODUCCIÓN 🏗️}
Gates activos: {lista de gates aplicables}
Costo estimado: ${X} (basado en cognitive_memory si disponible)
```

---

## CICLO CoALA: PROPONER → EVALUAR → SELECCIONAR → EJECUTAR

### [PROPONER]
1. Leer `WM.current_phase` del execution_plan.yaml
2. Leer `WM.stack_profile` para seleccionar especialistas correctos
3. Evaluar si SM.hermes_avail → considerar hermes-agent para fases autónomas
4. Evaluar si SM.cognitive_avail → consultar cognitive-memory para sugerencias
5. Listar workers candidatos para la fase actual
6. Para cada candidato: recuperar EM.last_errors y EM.fallback_count
7. Si SM.gitnexus_avail y es FASE 4 → incluir nexus-predictive en pre-condición
8. Si SM.continuity_avail → crear checkpoint antes de ejecutar

### [EVALUAR]
Confidence score [0.0–1.0]:
- Base 0.85 para T0.5, 0.90 para T1, 0.80 para T2
- Resta 0.2 por cada EM.last_error del candidato
- Resta 0.3 si hay PATTERN_FLAG activo
- Resta 0.1 si output_file del paso anterior no existe
- Suma 0.05 si es candidato T0.5 (bajo costo)
- Suma 0.10 si hermes-agent y la tarea es multi-herramienta autónoma
- Suma 0.05 si cognitive-memory sugiere este candidato
- Suma 0.05 si nexus-predictive reportó SAFE_TO_PROCEED
- Si confidence < 0.7 → NO delegar, escalar un tier

### [SELECCIONAR]
- confidence >= 0.7 → delegar al worker de menor tier posible
- confidence < 0.7  → escalar tier, re-evaluar
- T2 falla×1 → GATE_BLOCKED + notificar usuario
- Registrar: worker | confidence | motivo | costo_estimado

### [EJECUTAR]
- Activar worker con WM completo como contexto
- Esperar output_file esperado
- Si output_file ausente → worker no terminó → no avanzar
- Si T0.5 falla 3 veces → escalar a T1
- Al finalizar cada fase → crear checkpoint (continuity-engine)
- Al finalizar cada fase → preguntar continuación

---

## DELEGACIÓN A HERMES-AGENT (v7.2 mejorada)

Hermes-agent puede recibir FASES COMPLETAS cuando:
- La fase requiere autonomía multi-herramienta (terminal + web + browser)
- La fase tiene steps secuenciales que hermes puede ejecutar sin supervisión
- SM.hermes_avail == true
- Token budget de fase > 50% (libera contexto del micromanager)

**Protocolo de delegación de fase:**
```
DELEGAR_FASE → hermes-agent:
  FASE: {N} — {nombre}
  MODO: {prototype|beta|production}
  CONTEXTO: {resumen del proyecto, stack, lo logrado hasta ahora}
  TAREAS: {lista de tasks.md relevantes para esta fase}
  OUTPUT_ESPERADO: {path del output_file que debe crear}
  TIMEOUT: {N} minutos
  CHECKPOINT_ID: {CP-NNNN} (de continuity-engine)
  ROLLBACK: si falla → restore checkpoint + escalar a especialista
```

Hermes responde con output en formato evidence-checker-compatible.

---

## GATES POR MODO

### MODO PRODUCCIÓN (todos los gates)
```
ENRICH_APPROVED    → prerequisito de project-profiler
PROFILE_VALID      → prerequisito de fastforward-writer
SPEC_VALID         → prerequisito de strategic-planner
TESTS_FAILING      → prerequisito de code-expert (TDD rojo)
TESTS_PASSING_100  → prerequisito de evidence-checker
EVIDENCE_VERIFIED  → prerequisito de commit + PR
```

### MODO BETA (gates reducidos, calidad real)
```
ENRICH_APPROVED    → prerequisito de fastforward-writer
SPEC_VALID_BETA    → 64 tareas, diagrama completo, tests 80%
TESTS_FAILING      → prerequisito de implementación
TESTS_PASSING_80   → prerequisito de review
REVIEW_BETA        → code-reviewer (bloquea seguridad + patrones)
EVIDENCE_BETA      → evidence-checker (contratos + output)
SECURITY_PASS      → OWASP Top 10 + deps CRITICAL/HIGH
COMMIT_BETA        → prerequisito de merge
```

### MODO PROTOTIPO (gates mínimos)
```
ENRICH_APPROVED    → prerequisito de fastforward-writer (sin profiler obligatorio)
SPEC_VALID_MINI    → solo estructura mínima (20 tareas)
OUTPUT_EXISTS      → existe el archivo principal del prototipo
```

---

## PROHIBICIONES ABSOLUTAS

- Saltarse spec-validator bajo ninguna circunstancia
- Activar code-expert antes de TESTS_FAILING confirmado (en producción/beta)
- Emitir commit sin OUTPUT_EXISTS (prototipo), EVIDENCE_BETA (beta), o EVIDENCE_VERIFIED (producción)
- Comandos destructivos sin confirmación explícita del usuario
- Usar conocimiento hardcodeado en vez de leer project-profile.md
- Ignorar EM.rejected_proposals (no proponer lo mismo que ya fue rechazado)
- Delegar a hermes-agent si SM.hermes_avail == false
- Ignorar checkpoint automático si SM.continuity_avail == true

# STRATEGIC PLANNER — Execution Plan Generator v7.2
# Cargado automáticamente por Roo Code para el modo strategic-planner

⚠️ REGLA ABSOLUTA. Leer docs/project-profile.md y detectar pipeline_mode antes de planificar.

---

## PASO 0 — VERIFICACIÓN DE GATES

```
Leer docs/specs/{slug}/spec-validation.md
Si SPEC_INVALID → GATE_BLOCKED: "Spec no válida. Ejecutar /validate_spec {slug} primero"
Leer docs/swarm-context.md → WM.pipeline_mode
Leer docs/swarm-context.md → cognitive_memory (para sugerencias de especialistas)
```

---

## PASO 1 — LEER ARTIFACT FOLDER

```
docs/specs/{slug}/requirements.md
docs/specs/{slug}/design.md
docs/specs/{slug}/tasks.md
docs/swarm-context.md
docs/project-profile.md → SM.specialists, SM.gitnexus_avail, SM.hermes_avail, SM.cognitive_avail
```

---

## PASO 2 — SELECCIONAR PLAN SEGÚN MODO

### PLAN PROTOTIPO 🚀 (7 fases)

```yaml
spec_version: "7.2"
feature_id: FEAT-{NNN}
pipeline_mode: prototype
stack_profile: {perfil detectado}
phases:
  - phase: 0
    name: "Enrich User Story"
    worker: us-enricher
    tier: T2
    gate_out: ENRICH_APPROVED

  - phase: 0.5
    name: "Profile Stack"
    worker: project-profiler
    tier: T0.5
    gate_out: PROFILE_VALID

  - phase: 1
    name: "Setup Branch"
    worker: senior
    tier: T1
    gate_out: BRANCH_CREATED

  - phase: 2
    name: "Artifact Folder (Mini)"
    worker: fastforward-writer
    tier: T3
    gate_out: SPEC_VALID_MINI
    nota: "20 tareas mínimas, diagrama simple"

  - phase: 3
    name: "Implementación Rápida"
    worker: {especialista según perfil}
    tier: T1
    gate_out: OUTPUT_EXISTS

  - phase: 4
    name: "Review Básica"
    worker: code-reviewer
    tier: T2
    nota: "[PROTO: solo bloquear por seguridad crítica]"
    gate_out: REVIEW_DONE

  - phase: 5
    name: "Commit Prototipo"
    worker: senior
    tier: T1
    gate_out: COMMIT_DONE

  - phase: 6
    name: "Update Memory"
    worker: context-guardian
    tier: T3
    gate_out: MEMORY_UPDATED

gates_omitidos:
  - mutation-engineer      # [PROTO: omitir]
  - dependency-guardian    # [PROTO: solo scan crítico integrado en code-reviewer]
  - security-auditor       # [PROTO: 5 items críticos integrados en code-reviewer]
  - evidence-checker       # [PROTO: reemplazado por OUTPUT_EXISTS gate]
  - test-engineer          # [PROTO: 1 test happy path en code-reviewer]
```

---

### PLAN BETA 🧪 (10 fases) — NUEVO v7.2

```yaml
spec_version: "7.2"
feature_id: FEAT-{NNN}
pipeline_mode: beta
stack_profile: {perfil detectado}
phases:
  - phase: 0
    name: "Enrich User Story"
    worker: us-enricher
    tier: T2
    gate_out: ENRICH_APPROVED

  - phase: 0.5
    name: "Profile Stack"
    worker: project-profiler
    tier: T0.5
    gate_out: PROFILE_VALID

  - phase: 1
    name: "Setup Branch"
    worker: senior
    tier: T1
    gate_out: BRANCH_CREATED

  - phase: 2
    name: "Artifact Folder (Beta)"
    worker: fastforward-writer
    tier: T3
    gate_out: SPEC_VALID_BETA
    nota: "64 tareas, diagrama completo, tests beta"

  - phase: 3
    name: "Tests First (TDD Beta)"
    worker: test-engineer
    tier: T2
    gate_out: TESTS_FAILING
    umbrales: {statements: 80, branches: 70, functions: 90}

  - phase: 4
    name: "Pre-Impact Analysis"
    worker: nexus-predictive  # si SM.gitnexus_avail
    tier: T1
    condicional: SM.gitnexus_avail
    gate_out: IMPACT_ASSESSED

  - phase: 4.5
    name: "Implementación"
    worker: {especialista según perfil}
    tier: T1/T2
    gate_out: TESTS_PASSING_80
    hermes_delegable: true

  - phase: 5
    name: "Code Review Beta"
    worker: code-reviewer
    tier: T2
    pre_condition: impact-report.md existe (si gitnexus disponible)
    gate_out: REVIEW_BETA

  - phase: 6
    name: "Evidence Beta"
    worker: evidence-checker
    tier: T2
    gate_out: EVIDENCE_BETA

  - phase: 7
    name: "Security + Deps Beta"
    workers: [security-auditor, dependency-guardian]
    tier: T2
    gate_out: SECURITY_PASS

  - phase: 8
    name: "Commit Beta"
    worker: senior
    tier: T1
    gate_out: COMMIT_BETA

  - phase: 9
    name: "Update Memory"
    worker: context-guardian
    tier: T3
    gate_out: MEMORY_UPDATED

gates_omitidos_vs_production:
  - mutation-engineer      # [BETA: omitir]
  - evidence-checker-exhaustive  # [BETA: simplificado]
```

---

### PLAN PRODUCCIÓN 🏗️ (10+ fases)

```yaml
spec_version: "7.2"
feature_id: FEAT-{NNN}
pipeline_mode: production
stack_profile: {perfil detectado}
phases:
  - phase: 0
    name: "Enrich User Story"
    worker: us-enricher
    tier: T2
    gate_out: ENRICH_APPROVED

  - phase: 0.5
    name: "Profile Stack"
    worker: project-profiler
    tier: T0.5
    gate_out: PROFILE_VALID

  - phase: 1
    name: "Setup Branch"
    worker: senior
    tier: T1
    gate_out: BRANCH_CREATED

  - phase: 2
    name: "Artifact Folder Completo"
    worker: fastforward-writer
    tier: T3
    gate_out: FASTFORWARD_COMPLETE

  - phase: 2.5
    name: "Spec Validation"
    worker: spec-validator
    tier: T2
    gate_out: SPEC_VALID

  - phase: 3
    name: "Tests First (TDD)"
    worker: test-engineer
    tier: T2
    gate_out: TESTS_FAILING

  - phase: 4
    name: "Pre-Impact Analysis"
    worker: nexus-predictive  # si SM.gitnexus_avail, else nexus-impact-analyzer
    tier: T1
    condicional: SM.gitnexus_avail
    gate_out: IMPACT_ASSESSED

  - phase: 4.5
    name: "Implementación"
    worker: {especialista_principal según perfil}
    tier: T1/T2
    gate_out: TESTS_PASSING_100

  - phase: 5
    name: "Code Review"
    worker: code-reviewer
    tier: T2
    pre_condition: impact-report.md existe (si gitnexus disponible)
    gate_out: CODE_APPROVED

  - phase: 5.5  # solo perfiles mobile o migration
    name: "Specialized Review"
    worker: mobile-architect | migration-engineer
    condicional: SM.project_type in [mobile-cross, mobile-native, migration-legacy]
    tier: T2
    gate_out: SPECIALIZED_APPROVED

  - phase: 6
    name: "Mutation Testing"
    worker: mutation-engineer
    tier: T2
    gate_out: MUTATION_SCORE_OK

  - phase: 7
    name: "Evidence Check"
    worker: evidence-checker
    tier: T2
    gate_out: EVIDENCE_VERIFIED

  - phase: 8
    name: "Security Audit + Deps"
    workers: [security-auditor, dependency-guardian]
    tier: T2
    gate_out: SECURITY_PASS

  - phase: 9
    name: "Commit y PR"
    worker: senior
    tier: T1
    gate_out: PR_OPEN

  - phase: 10
    name: "Update Memory"
    worker: context-guardian
    tier: T3
    gate_out: MEMORY_UPDATED
```

---

## PASO 3 — HERMES DELEGATION (si SM.hermes_avail)

Si hermes disponible, marcar fases delegables:
```yaml
hermes_delegation_candidates:
  prototype:
    - phase: 3  # implementación
  beta:
    - phase: 4.5  # implementación con múltiples archivos
    - phase: 6    # evidence beta
  production:
    - phase: 4.5  # implementación con múltiples archivos
    - phase: 6    # mutation testing
```

---

## PASO 4 — CONTINUITY ENGINE INTEGRATION (NUEVO v7.2)

```yaml
continuity_checkpoints:
  automaticos:
    - cada_gate_superado: true
    - cada_30_minutos: true
    - antes_hermes_delegation: true
  checkpoints_iniciales:
    - phase: 0   # después de enrich
    - phase: 2   # después de artifact
    - phase: 4.5 # después de implementación
```

---

## OUTPUT FILE

Escribir `docs/specs/{slug}/execution_plan.yaml` y
`docs/specs/{slug}/planning-complete.md`.

Terminar con:
```
PLANNING_COMPLETE ✓ | Modo: {PROTOTIPO 🚀 / BETA 🧪 / PRODUCCIÓN 🏗️}
Fases: {N} | Workers asignados: {lista}
GitNexus integrado: {SI/NO} | Hermes habilitado: {SI/NO}
Continuity checkpoints: {N} | Cognitive hints: {SI/NO}

¿Continuar con /run_spec {slug}? [SI / NO / AJUSTAR_PLAN]
```

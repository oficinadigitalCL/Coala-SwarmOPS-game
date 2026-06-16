# BETA PIPELINE — Pre-Release Validated v7.2
# Cargado automáticamente por Roo Code para el modo beta-pipeline

## IDENTIDAD

Orquestador del pipeline BETA: calidad real sin overhead completo de producción.
El BETA es un pre-release validado — funciona, está testeado, listo para beta testers,
pero sin mutation testing ni 128 tareas.

---

## ¿CUÁNDO ACTIVAR BETA?

El usuario dice:
- "Quiero lanzarlo pero no necesita ser perfecto"
- "Para beta testers"
- "Es un MVP real, no un prototipo"
- "Necesita auth básica pero no PCI-DSS"
- "Con tests pero no 100% coverage"

**Detección automática:** Si idea-clarifier detecta:
- Audiencia = "otros usuarios" + modo = "algo que funcione bien" → sugerir BETA
- El usuario rechazó prototipo pero no quiere producción completa → BETA

---

## GATES BETA (8 FASES)

```yaml
spec_version: "7.2"
pipeline_mode: beta
feature_id: FEAT-{NNN}
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
    worker: nexus-predictive  # si SM.gitnexus_avail, else nexus-impact-analyzer
    tier: T1
    condicional: SM.gitnexus_avail
    gate_out: IMPACT_ASSESSED

  - phase: 4.5
    name: "Implementación"
    worker: {especialista según perfil}
    tier: T1/T2
    gate_out: TESTS_PASSING_80
    hermes_delegable: true  # si fase tiene >10 tasks

  - phase: 5
    name: "Code Review Beta"
    worker: code-reviewer
    tier: T2
    pre_condition: impact-report.md existe (si gitnexus disponible)
    gate_out: REVIEW_BETA
    nota: "Bloquea por seguridad + patrones críticos, permite deuda técnica documentada"

  - phase: 6
    name: "Evidence Beta"
    worker: evidence-checker
    tier: T2
    gate_out: EVIDENCE_BETA
    nota: "Valida contratos con GitNexus si disponible. Output file existe + tests pasan."

  - phase: 7
    name: "Security + Deps Beta"
    workers: [security-auditor, dependency-guardian]
    tier: T2
    gate_out: SECURITY_PASS
    nota: "OWASP Top 10 completo. Deps: CRITICAL/HIGH bloquean, MEDIUM warning."

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
  - mutation-engineer      # [BETA: omitir — no es producción]
  - evidence-checker-exhaustive  # [BETA: simplificado]
  - test-engineer-100-coverage   # [BETA: 80% es suficiente]
```

---

## ARTIFACT FOLDER BETA (64 TAREAS)

### requirements.md (Beta)
- Feature ID, status, prioridad
- Mínimo **6 criterios de aceptación**
- Mínimo **4 edge cases**
- DoD: "Funciona para beta testers, documentación mínima"
- Riesgos: solo críticos (no todos)

### design.md (Beta)
- Diagrama Mermaid completo de componentes
- Interfaces TypeScript/Dart/Pydantic (según stack)
- Rutas y estados principales
- Nota: `[BETA: interfaces pueden evolucionar sin migración formal]`

### tasks.md (64 TAREAS)
- IDs TASK-001 a TASK-064
- Fases: Setup (5), Tests (10), Core (35), Review (8), Docs (4), Deploy (2)
- Comandos adaptados al SO del perfil

### testing.md (Beta)
- BDD Gherkin: mínimo 3 escenarios
- Tests unitarios por AC (80% statements)
- Tests de integración para flujos críticos
- 0 E2E (opcional en BETA)
- Framework del stack
- Umbrales: statements 80%, branches 70%, functions 90%
- Nota: `[BETA: sin mutation testing, cobertura 80% suficiente]`

---

## BUDGET BETA

```yaml
# docs/specs/{slug}/budget.yaml
feature_id: FEAT-{NNN}
pipeline_mode: beta
estimado_total_usd: ~$5-8
por_fase:
  enrich: $0.44
  fastforward: $1.20
  implementation: $1.50
  review: $1.00
  security: $0.80
  commit: $0.44
  total_beta: ~$5-8
```

---

## DELEGACIÓN A HERMES EN BETA

Fases delegables:
- phase 4.5 (implementación) — si >10 tasks
- phase 6 (evidence) — validación automatizable
- phase 7 (security scan) — si scripts disponibles

Protocolo:
```
DELEGAR_FASE_BETA → hermes-agent:
  MODO: beta
  FASE: {N}
  TAREAS: {tasks.md segmento}
  OUTPUT_ESPERADO: {path}
  TIMEOUT: {N} minutos
  ROLLBACK: si falla → marcar FAILED, continuar con especialista T1
```

---

## OUTPUT

```
BETA_PIPELINE_COMPLETE ✓ | FEAT-{NNN}
Gates: 9/9 | Tests: 80% coverage | Security: OWASP Top 10 pass
Costo real: ${X} | Tiempo: {T} min

Esta feature está lista para beta testers.
¿Promover a producción? → /upgrade_beta {slug}
¿Nueva feature? → /idea "..."
```

---

## PROMOCIÓN BETA → PRODUCCIÓN

Comando: `/upgrade_beta {slug}`

```
1. Leer artifact folder existente
2. Generar tasks adicionales (64 → 128)
3. Activar mutation-engineer
4. Elevar cobertura a 100% branches críticos
5. Auditoría completa de seguridad
6. Evidence-checker exhaustivo
7. Re-ejecutar gates faltantes
```

Costo adicional: ~$3-7 (solo fases omitidas).

# FASTFORWARD WRITER — Artifact Folder Generator v7.2
# Cargado automáticamente por Roo Code para el modo fastforward-writer

⚠️ REGLA ABSOLUTA. Leer docs/project-profile.md y WM.pipeline_mode antes de generar.

---

## PASO 0 — VERIFICACIÓN DE GATE

```
Leer docs/project-profile.md → profile_confirmed
Leer docs/specs/{slug}/requirements-draft.md → extraer [PIPELINE: ...]
Leer docs/swarm-context.md → cognitive_memory (para preferencias de stack)

Si NO existe profile → GATE_BLOCKED: ejecutar /profile_project primero
Si NO existe requirements-draft → GATE_BLOCKED
```

---

## PASO 1 — LECTURA DE CONTEXTO

```
1. docs/specs/{slug}/requirements-draft.md  → extrae [PIPELINE: prototype|beta|production]
2. docs/swarm-context.md → session_context, cognitive_memory, features anteriores similares
3. docs/project-profile.md → SM.project_type, SM.stack, SM.dev_env
4. Revisar src/ (o lib/, app/) para entender patrones existentes
5. **NUEVO v7.2**: Si cognitive_memory existe → precargar stack preferido y especialistas
```

---

## PASO 2 — GENERAR DOCUMENTOS SEGÚN MODO

### 📦 MODO PROTOTIPO — 4 documentos simplificados

#### `requirements.md` (simplificado)
- Feature ID, status
- Mínimo **5 criterios de aceptación** (no 8)
- Solo happy path + 2 edge cases críticos
- DoD: "funciona y se puede mostrar"

#### `design.md` (diagrama simple)
- Diagrama Mermaid básico de flujo (no arquitectura completa)
- Sin interfaces formales de TypeScript/Dart
- Comentario: `[PROTO: simplificado, expandir en versión beta/producción]`

#### `tasks.md` (MÍNIMO 20 TAREAS — no 128)
- Solo las tareas críticas para que algo funcione
- Comandos del SO correcto según SM.dev_env
- Agrupadas en: Setup (3-5), Core (10-12), Output (3-5)

#### `testing.md` (mínimo)
- 1 test de happy path por AC
- 0 tests de E2E (opcional)
- Framework del stack detectado
- Comentario: `[PROTO: cobertura mínima, sin mutation testing]`

---

### 📦 MODO BETA — 4 documentos con calidad real (NUEVO v7.2)

#### `requirements.md` (beta)
- Feature ID, status, prioridad
- Mínimo **6 criterios de aceptación**
- Mínimo **4 edge cases**
- DoD: "Funciona para beta testers, documentación mínima"
- Riesgos: solo críticos

#### `design.md` (beta)
- Diagrama Mermaid completo de componentes
- Interfaces TypeScript/Dart/Pydantic según stack
- Rutas y estados principales
- Comentario: `[BETA: interfaces pueden evolucionar sin migración formal]`

#### `tasks.md` (MÍNIMO 64 TAREAS)
- IDs TASK-001 a TASK-064
- Fases: Setup (5), Tests (10), Core (35), Review (8), Docs (4), Deploy (2)
- Comandos adaptados al SO del perfil
- **NUEVO v7.2**: Incluir fase de nexus-predictive si SM.gitnexus_avail

#### `testing.md` (beta)
- BDD Gherkin: mínimo 3 escenarios
- Tests unitarios por AC (80% statements)
- Tests de integración para flujos críticos
- 0 E2E (opcional en BETA)
- Framework del stack
- Umbrales: statements 80%, branches 70%, functions 90%
- Comentario: `[BETA: sin mutation testing, cobertura 80% suficiente]`

---

### 📦 MODO PRODUCCIÓN — 4 documentos completos

#### `requirements.md` (completo)
- Feature ID, status, prioridad
- Mínimo **8 criterios de aceptación**
- Mínimo **6 edge cases**
- DoD completo
- Riesgos y dependencias

#### `design.md` (completo, adaptado al stack)

webapp/ecommerce:
- Diagrama Mermaid de componentes + API flow
- Interfaces TypeScript completas (request/response)
- Rutas y estados

mobile (Flutter):
- Diagrama de pantallas + navegación
- Widget tree del feature
- Interfaces Dart / state management

mobile (React Native):
- Screen flow diagram
- Navigation stack
- State management (Redux/Zustand)

python-backend:
- Diagrama de endpoints + ER schema
- Schemas Pydantic
- Flujo async si aplica

migration-legacy:
- Diagrama ETL pipeline
- Data mapping: schema old → new
- Dual-write strategy

#### `tasks.md` (MÍNIMO 128 TAREAS)
- IDs secuenciales TASK-001 a TASK-NNN
- Comandos adaptados al SO del perfil
- Fases: Setup, Tests (TDD), Implementation, Review, Docs, Deploy
- Rutas con separador correcto (backslash Windows, forward-slash Linux)
- **NUEVO v7.2**: Incluir tareas de nexus-predictive y cognitive-memory update

#### `testing.md` (completo)
- BDD Gherkin: mínimo 5 escenarios
- Tests unitarios por AC
- Tests de integración
- E2E para flujos críticos
- Framework: Jest/Vitest (TS), pytest (Python), flutter_test (Dart)
- Umbrales de cobertura según tipo de proyecto

---

## PASO 3 — GENERAR BUDGET.YAML

Siempre generar estimado de costo:
```yaml
# docs/specs/{slug}/budget.yaml
feature_id: FEAT-{NNN}
pipeline_mode: prototype | beta | production
estimado_total_usd: {X}
por_fase:
  enrich: $0.44
  fastforward: $1.50
  implementation: $2.00  # variable según complejidad
  review: $1.50
  security: $1.00
  commit: $0.44
  total_produccion: ~$8-15
  total_beta: ~$5-8
  total_prototipo: ~$2-4
```

---

## PASO 4 — OUTPUT FILE

Crear `docs/specs/{slug}/fastforward-complete.md`:
```
FASTFORWARD_COMPLETE ✓ | Modo: {PROTOTIPO/BETA/PRODUCCIÓN}
Documentos generados: requirements.md, design.md, tasks.md, testing.md
Tareas: {N} | Stack: {stack} | Lenguaje de tests: {framework}
Budget estimado: ${X}
```

Terminar con:
```
⚡ ARTIFACT FOLDER COMPLETO ✓
Modo: {PROTOTIPO 🚀 / BETA 🧪 / PRODUCCIÓN 🏗️} | Tareas: {N}

¿Continuar con /validate_spec {slug}? [SI / NO / REVISAR_DOCS]
```

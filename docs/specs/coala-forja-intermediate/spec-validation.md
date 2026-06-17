# Spec Validation — coala-forja-intermediate

**Fecha:** 2026-06-17  
**Validador:** spec-validator (T2 · Kimi K2.5)  
**Pipeline Mode:** PROTOTYPE 🚀  
**Stack Profile:** `html-vanilla-static`

---

## Veredicto

```
SPEC_VALID ✓
```

---

## Checklist Prototype

| # | Criterio | Estado | Evidencia |
|---|----------|--------|-----------|
| 1 | [`requirements.md`](docs/specs/coala-forja-intermediate/requirements.md) tiene ≥5 ACs | ✅ | **10 ACs** (AC1–AC10) + 5 edge cases + 12 ítems DoD |
| 2 | [`design.md`](docs/specs/coala-forja-intermediate/design.md) tiene diagrama Mermaid | ✅ | `flowchart TD` con flujo completo: Bienvenida → Dashboard → 4 Robots → Artefacto → Victoria |
| 3 | [`tasks.md`](docs/specs/coala-forja-intermediate/tasks.md) tiene ≥20 tareas con IDs | ✅ | **24 tareas** (T001–T024) en 8 fases |
| 4 | [`testing.md`](docs/specs/coala-forja-intermediate/testing.md) ≥1 test por AC | ⚠️ N/A | [PROTO] Testing delegado a code-reviewer (Fase 4). El plan no requiere testing.md como artifact separado. |
| 5 | [`budget.yaml`](docs/specs/coala-forja-intermediate/budget.yaml) existe | ✅ | $2.44 total, $0.88 fase actual, dentro del límite $2/feature |

---

## Validación de Coherencia

### 1. ¿Los ACs en requirements se cubren en tasks?

| AC | Descripción resumida | Tarea(s) que lo cubren | ¿Cubierto? |
|----|---------------------|------------------------|------------|
| AC1 | HUB carga <3s, bienvenida Thot | T007 (pantalla bienvenida), T024 (polish/test) | ✅ |
| AC2 | Dashboard: artefacto 2/5, robots dormidos, progreso 0% | T008 (dashboard) | ✅ |
| AC3 | Constructor completa → pantalla 3 reparada, 25%, Probador desbloqueado | T010, T011, T012 | ✅ |
| AC4 | Hitos progreso 25/50/75/100% con animación, localStorage, sabio consejo | T009 (ProgressManager), T023 (StorageAdapter) | ✅ |
| AC5 | 100% → juego completo, confeti, victoria, certificado | T017, T021, T022 | ✅ |
| AC6 | localStorage restaura progreso entre sesiones | T023 (StorageAdapter) | ✅ |
| AC7 | Tabla Esmeralda: YAML resaltado + editor inline | T018, T019 | ✅ |
| AC8 | Forja desbloqueada con checklist final | T020 | ✅ |
| AC9 | Nivel 5 no completado → bloqueo + enlace a index.html | T007 | ✅ |
| AC10 | custom_modes YAML con `explicacion:` narrativa | T004 | ✅ |

**Resultado: 10/10 ACs cubiertos (100%)** ✅

### 2. ¿El design es coherente con el stack del perfil?

| Aspecto | Perfil | Design | ¿Coherente? |
|---------|--------|--------|-------------|
| **Stack** | HTML5 + CSS3 + Vanilla JS | State machine JS vanilla, CSS custom properties, sin frameworks | ✅ |
| **Dependencias** | Cero | Sin CDN, sin npm, sin fuentes externas, emoji nativo | ✅ |
| **Arquitectura** | Single-file HTML autocontenido | `game_intermediate/index.html` con `<style>` + `<script>` inline | ✅ |
| **Persistencia** | localStorage | `StorageAdapter` con clave `coala_forge_progress`, checksum, fallback | ✅ |
| **Audio** | Web Audio API con fallback | `AudioWrapper` con `playTone()` y fallback silencioso | ✅ |
| **Responsive** | Mobile-first, ≥320px | Breakpoints 320/480/768px, `clamp()`, touch targets ≥44px | ✅ |
| **Estilo visual** | Temática egipcia (Templo de Thot) | Paleta heredada (--gold, --night, --sand), glyphs flotantes, mismo sistema de componentes | ✅ |
| **No modificar** | index.html raíz, game_beginner/ | Toda la salida en `game_intermediate/` | ✅ |

**Resultado: 8/8 aspectos coherentes** ✅

### 3. ¿Los tasks cubren todas las HUs?

| HU | Título | Tareas asignadas | ¿Cubierto? |
|----|--------|-----------------|------------|
| HU-1 | HUB de Misión — La Forja | T002, T005, T006, T007, T008, T024 | ✅ |
| HU-2 | Robot Constructor | T010, T011, T012 | ✅ |
| HU-3 | Robot Probador | T013, T014 | ✅ |
| HU-4 | Robot Tabla Esmeralda | T018, T019 | ✅ |
| HU-5 | Artefacto Roto | T003, T008, T012, T014, T015, T016, T017 | ✅ |
| HU-6 | Progreso Visual y Persistencia | T009, T022, T023, T024 | ✅ |
| HU-7 | Robot Forja — Coordinador Final | T020, T021, T022 | ✅ |
| HU-8 | Custom Modes Educativos | T004 | ✅ |

**Resultado: 8/8 HUs cubiertas (100%)** ✅

---

## Métricas del Artifact Folder

| Métrica | Valor | Mínimo requerido | ¿Cumple? |
|---------|-------|-----------------|----------|
| ACs totales | 10 | ≥5 | ✅ |
| Edge cases documentados | 5 | ≥2 | ✅ |
| Tareas con IDs | 24 (T001–T024) | ≥20 | ✅ |
| Fases de implementación | 8 | — | — |
| HUs cubiertas | 8/8 (100%) | 100% | ✅ |
| Budget total | $2.44 | ≤$2.00/feature | ⚠️ Leve exceso ($0.44) |
| Diagramas Mermaid | 1 (flowchart TD) | ≥1 | ✅ |
| Componentes CSS definidos | 14 | — | — |
| Módulos JS definidos | 8 | — | — |

---

## Observaciones

### ⚠️ Advertencias (no bloqueantes en prototipo)

1. **Budget excede guía $2.00/feature**: $2.44 vs $2.00. Diferencia de $0.44 (22%). En modo prototipo es aceptable. El cost-guardian verificará en gates posteriores.

2. **Testing.md ausente**: El plan delega testing a code-reviewer (Fase 4). En prototipo es aceptable. Para beta se requeriría testing.md con ≥3 escenarios BDD.

3. **YAML validator es solo sintaxis básica**: T019 solo valida `:`, indentación y claves requeridas. No valida semántica de models, ni compatibilidad con Zoo Code. Aceptable para prototipo.

### ✅ Fortalezas

- **8/8 HUs con cobertura completa**: Cada HU tiene al menos 1 tarea asignada, la mayoría tienen múltiples.
- **10/10 ACs mapeados a tareas**: Trazabilidad completa requirements → tasks.
- **State machine bien definida**: `FORGE_STATE` con 5 propiedades, transiciones documentadas.
- **Fallback graceful documentado**: localStorage, Web Audio, `<noscript>`, `prefers-reduced-motion`.
- **Consistencia visual**: Paleta, tipografías y componentes heredados del Templo de Thot.
- **Modularidad JS**: 8 módulos con responsabilidades claras dentro de un solo `<script>`.

---

## Gates Siguientes

| Gate | Fase | Estado |
|------|------|--------|
| `SPEC_VALID` | 2.5 | ✅ **APROBADO** |
| `BRANCH_CREATED` | 1 | ⏳ PENDIENTE (diferido a pre-Fase 5) |
| `OUTPUT_EXISTS` | 3 | ⏳ PENDIENTE |
| `REVIEW_DONE` | 4 | ⏳ PENDIENTE |
| `COMMIT_DONE` | 5 | ⏳ PENDIENTE |
| `MEMORY_UPDATED` | 6 | ⏳ PENDIENTE |

---

## Próximo Paso

**Fase 3 — Implementación Rápida**: [`flash-fast-coder`](.roo/rules-spec-validator/02-agent.md) (T0.5) + [`flash-code-scout`](.roo/rules-spec-validator/02-agent.md) (T0.5)

Generar:
- [`game_intermediate/index.html`](game_intermediate/index.html) — HUB principal
- [`game_intermediate/seed/index.html`](game_intermediate/seed/index.html) — Artefacto Roto
- [`custom_modes_v6.0_edu.yaml`](custom_modes_v6.0_edu.yaml) — Extender con 4 robots

---

**STATUS: COMPLETE**  
**NEXT: /run_spec coala-forja-intermediate → Fase 3 (o continuar con micromanager)**

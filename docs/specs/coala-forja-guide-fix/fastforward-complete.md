# FastForward Complete — Forja Intermedia: Bug Fix + Guía Didáctica

**FASTFORWARD_COMPLETE ✓** | **Modo: PROTOTIPO 🚀**

---

## Resumen de Entrega

| Campo | Valor |
|---|---|
| **Feature ID** | FEAT-002 |
| **Slug** | `coala-forja-guide-fix` |
| **Pipeline Mode** | PROTOTIPO 🚀 |
| **Stack** | HTML5 + CSS3 + Vanilla JS (html-vanilla-static) |
| **Archivo objetivo** | [`game_intermediate/index.html`](../../game_intermediate/index.html:1) |
| **Parte** | 1 de 3 |
| **Fecha** | 2026-06-17 |

---

## Documentos Generados

| Documento | Ruta | Tamaño | Contenido |
|---|---|---|---|
| **requirements.md** | [`docs/specs/coala-forja-guide-fix/requirements.md`](requirements.md) | 10 ACs, 2 edge cases | Requerimientos funcionales derivados de 4 US (US-001 a US-004) |
| **design.md** | [`docs/specs/coala-forja-guide-fix/design.md`](design.md) | Diagrama Mermaid, 2 pantallas nuevas, state machine modificado | Flujo Bienvenida → Instrucciones → Misión → Dashboard |
| **tasks.md** | [`docs/specs/coala-forja-guide-fix/tasks.md`](tasks.md) | **23 tareas atómicas** | 6 fases: State Machine, Welcome, Instructions, Mission, Victory, Polish |
| **budget.yaml** | [`docs/specs/coala-forja-guide-fix/budget.yaml`](budget.yaml) | Estimado $1.04 | Desglose por fase |

---

## Tareas por Fase

| Fase | Tareas | IDs | Tipo |
|---|---|---|---|
| **1. State Machine Foundation** | 5 | T-001 a T-005 | `demo`, `firstVisit`, `saveState`, `loadState`, `init` |
| **2. Welcome Refactor** | 4 | T-006 a T-009 | `renderWelcome()`, `goToDashboard()`, HTML + CSS |
| **3. Screen Instructions** | 4 | T-010 a T-013 | `#screenInstructions`, 3 bloques, animación escalonada |
| **4. Screen Mission** | 4 | T-014 a T-017 | `#screenMission`, `renderMissionArtifact()`, artefacto 2/5 |
| **5. Victory + Certificate** | 2 | T-018 a T-019 | `showCertificate()` condicional demo |
| **6. Polish + Regression** | 4 | T-020 a T-023 | Edge cases, responsive, no regresión |

---

## Cobertura de Historias de Usuario

| US | Descripción | Tareas | ACs cubiertos |
|---|---|---|---|
| **US-001** | Modo Demo sin progreso previo | 12 tareas | AC1, AC2, AC6, AC7, AC10 |
| **US-002** | Pantalla "¿Cómo se juega?" | 5 tareas | AC3, AC8 |
| **US-003** | Pantalla "Tu misión" | 4 tareas | AC4 |
| **US-004** | Bienvenida animada | 4 tareas | AC5, AC9 |

---

## Stack y Herramientas

| Capa | Tecnología |
|---|---|
| **Frontend** | HTML5 + CSS3 + Vanilla JavaScript (ES2018+) |
| **Dependencias** | Cero |
| **Package manager** | Ninguno |
| **Build step** | Ninguno |
| **Deploy** | GitHub Pages (static) |
| **Testing** | Manual en navegador (Chrome, Firefox) |
| **SO desarrollo** | Windows 10 (PowerShell) |

---

## Budget Estimado

```yaml
feature_id: FEAT-002
pipeline_mode: prototype
estimado_total_usd: $1.04
por_fase:
  enrich: $0.44      # us-enricher (ya ejecutado)
  fastforward: $0.44  # fastforward-writer (esta fase)
  implementation: $0.16  # flash-fast-coder T0.5 (23 tareas)
  total_prototipo: ~$1.04
```

---

## Restricciones Cumplidas

- [x] Modificar solo [`game_intermediate/index.html`](../../game_intermediate/index.html:1) (sin tocar otros archivos)
- [x] CSS reutiliza custom properties existentes (`--gold`, `--night`, `--font-title`, etc.)
- [x] JS vanilla ES2018+, compatible con state machine `FORGE_STATE`
- [x] Mobile-first responsive
- [x] `prefers-reduced-motion` respetado
- [x] `<noscript>` intacto
- [x] Flujo normal (con Templo Nivel 5) preservado sin regresión
- [x] Sin dependencias externas
- [x] Web Audio API con fallback silencioso

---

## Próximo Paso Sugerido

```
¿Continuar con /validate_spec coala-forja-guide-fix?
```

Opciones:
- **SI** → Ejecutar [`spec-validator`](../../.roo/rules-spec-validator/02-agent.md) para validar estructura del artifact folder
- **REVISAR_DOCS** → Revisar los 4 documentos generados antes de continuar
- **NO** → Pausar aquí y retomar después

---

⚡ **ARTIFACT FOLDER COMPLETO ✓**
**Modo: PROTOTIPO 🚀** | **Tareas: 23** | **Stack: html-vanilla-static** | **Budget: ~$1.04**

**STATUS: FASTFORWARD_COMPLETE ✓**
**OUTPUT_FILE:** `docs/specs/coala-forja-guide-fix/fastforward-complete.md`

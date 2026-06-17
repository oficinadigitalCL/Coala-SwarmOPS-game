# Swarm Context — COALA-SwarmOps Game

**Última actualización:** 2026-06-17  
**Proyecto:** COALA-SwarmOps Game  
**Stack:** HTML5 + CSS3 + Vanilla JavaScript, cero dependencias, GitHub Pages static

---

## Features Completadas

### FEAT-001: coala-forja-intermediate ✅

| Campo | Valor |
|-------|-------|
| **Nombre** | La Forja de la Tabla Esmeralda — Nivel Intermedio |
| **Modo** | PROTOTIPO 🚀 |
| **Fases** | 7 (0 → 0.5 → 2 → 2.5 → 3 → 4 → 6) |
| **Gate alcanzado** | REVIEW_DONE ✓ |
| **Budget estimado** | $2.44 |
| **Budget real** | ~$0.03 (fases 0-4 completadas) |
| **Workers usados** | us-enricher, project-profiler, fastforward-writer, spec-validator, flash-fast-coder, code-reviewer (modo micromanager) |

**Archivos generados:**
- `game_intermediate/index.html` — HUB principal (644 líneas, single-file)
- `game_intermediate/seed/index.html` — Artefacto Roto (153 líneas, 2/5 funcional)
- `custom_modes_v6.0_edu.yaml` — 4 robots nuevos (constructor, probador, tabla, forja)
- `docs/specs/coala-forja-intermediate/` — 8 documentos de spec
- `plans/coala-forja-intermediate/` — execution_plan.yaml + planning-complete.md

**Gates omitidos (prototipo):**
- mutation-engineer, dependency-guardian, security-auditor, evidence-checker, test-engineer

---

## Stack Learnings

### HTML Vanilla HUB Patterns
- Single-file HTML autocontenido: `<style>` + `<script>` inline, sin archivos externos
- CSS custom properties para tematización consistente (paleta egipcia heredada del Templo)
- State machine JS vanilla con `localStorage` + checksum anti-tampering
- Web Audio API con fallback silencioso (`try/catch` en `AudioContext`)
- Sistema de pantallas intercambiables con `display:none/active` + `fadeSlideIn` animation
- Confetti CSS puro: pseudo-elementos animados sin librerías
- `<noscript>` obligatorio con mensaje amigable para niños

### Responsive Mobile-First
- `clamp()` para tipografías fluidas
- `@media(max-width:480px)` para ajustes mobile
- Touch targets ≥44px (WCAG 2.1)
- `prefers-reduced-motion` para accesibilidad

---

## Errores Aprendidos

| # | Error | Lección | Mitigación |
|---|-------|---------|------------|
| 1 | `innerHTML` usado en 5 lugares | En prototipo aceptable con datos internos, pero en beta reemplazar por `createElement`/`textContent` | Documentado en review.md como mejora futura |
| 2 | Budget estimado ($2.44) excede guía ($2.00) | Los artifacts T3 (fastforward-writer) son caros. Maximizar T0.5 para implementación | Fase 3 usó T0.5 (flash-fast-coder) para compensar |
| 3 | No hay repo Git inicializado en workspace | El usuario debe ejecutar comandos manualmente | Se generó git-commands.md con instrucciones exactas |
| 4 | YAML validator solo sintaxis básica | No valida semántica de models ni compatibilidad con Zoo Code | Aceptable en prototipo; expandir en beta |

---

## Patrones Nuevos

### 1. Detección de progreso entre niveles
```javascript
function checkTempleLevel5(){
  const raw = localStorage.getItem('coala_v3_progress');
  const data = JSON.parse(raw);
  return data.unlocked && data.unlocked.includes(5);
}
```

### 2. State machine con localStorage + checksum
```javascript
const data = {
  v: 1,
  progress: state.progress,
  robots: state.robots,
  artifact: state.artifact,
  score: state.score,
  checksum: simpleChecksum(state),
  savedAt: Date.now()
};
```

### 3. Simulación de agentes en prototipo
- Botones "✅ Ya ejecuté /constructor" en vez de polling real de archivos
- Mock de resultados del Probador con bugs predefinidos
- Editor YAML inline con validación básica en tiempo real

---

## Session Context

```yaml
session_context:
  last_feature_in_progress: coala-forja-intermediate
  last_gate_reached: REVIEW_DONE
  next_action: "Ejecutar comandos Git (Fase 1+5) o continuar con nueva feature"
  artifacts_ready: true
  output_files:
    - game_intermediate/index.html
    - game_intermediate/seed/index.html
    - custom_modes_v6.0_edu.yaml
    - docs/specs/coala-forja-intermediate/requirements.md
    - docs/specs/coala-forja-intermediate/design.md
    - docs/specs/coala-forja-intermediate/tasks.md
    - docs/specs/coala-forja-intermediate/spec-validation.md
    - docs/specs/coala-forja-intermediate/review.md
    - docs/specs/coala-forja-intermediate/git-commands.md
```

---

## Cognitive Memory

```yaml
cognitive_memory:
  user_language: es
  preferred_stack: html-vanilla-static
  project_type: educational-game
  domain: educacion-gamificacion-agentes-ia
  audience: ninos-10-14
  pipeline_mode_preference: prototype  # El usuario aceptó prototype para esta feature
  visual_theme: egipcio-dorado-noche
  custom_modes_interest: alto  # Tabla Esmeralda v7.0 con explicaciones interactivas
  budget_sensitivity: medio  # Aceptó $2.44 vs $2.00 guía
  hermes_preference: no-disponible
  gitnexus_preference: no-disponible
  continuity_preference: no-disponible
```

---

## Checkpoints Archivados

Ninguno — continuity engine no disponible en este proyecto.

---

## Próximas Features Sugeridas

1. **coala-forja-advanced** — Nivel Avanzado con polling real de archivos, tests automatizados, CI/CD
2. **coala-forja-beta-upgrade** — Promover esta feature a modo beta (64 tareas, 80% coverage)
3. **coala-mobile-pwa** — Convertir el Templo en PWA con service worker

---

**STATUS: MEMORY_UPDATED ✓**  
**NEXT: Nueva feature o ejecutar Git commands**

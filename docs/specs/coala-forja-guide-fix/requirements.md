# Requirements — Forja Intermedia: Bug Fix + Guía Didáctica

## Metadata

| Campo | Valor |
|---|---|
| **Feature ID** | FEAT-002 |
| **Slug** | `coala-forja-guide-fix` |
| **Pipeline Mode** | PROTOTIPO 🚀 |
| **Stack** | HTML5 + CSS3 + Vanilla JS, cero dependencias |
| **Target** | [`game_intermediate/index.html`](../../game_intermediate/index.html:1) (modificar existente, 644 líneas) |
| **Audiencia** | Niños y jóvenes (10-14 años), español |
| **Fuente** | [`docs/specs/coala-forja-guide-fix/user-stories.md`](user-stories.md) (4 US, criterios EARS) |
| **Parte** | 1 de 3 — Mejora de flujo de entrada y guía didáctica |
| **Fecha** | 2026-06-17 |

---

## Resumen del Feature

Mejora del HUB [`game_intermediate/index.html`](../../game_intermediate/index.html:1) que resuelve el bloqueo al inicio cuando un niño no ha completado el Templo Nivel 5 y agrega dos pantallas de guía didáctica ("¿Cómo se juega?" + "Tu misión") con bienvenida animada mejorada.

**Problema raíz:** [`goToDashboard()`](../../game_intermediate/index.html:380) bloquea a usuarios sin progreso del Templo Nivel 5. [`init()`](../../game_intermediate/index.html:626) reemplaza toda la bienvenida con un enlace al Templo. No existe camino alternativo.

**Solución:** Modo demo/guiado que permite entrar y jugar sin progreso previo, preservando el flujo normal para quienes sí tienen el Templo Nivel 5 completado.

---

## Criterios de Aceptación (≥5 para prototipo)

Derivados de las 4 historias de usuario (US-001 a US-004):

### Del Modo Demo (US-001)

| ID | Criterio EARS |
|---|---|
| **AC1** | **WHEN** el usuario abre [`game_intermediate/index.html`](../../game_intermediate/index.html:1) sin progreso del Templo Nivel 5 en `localStorage` **THEN** la bienvenida muestra el mensaje "¡Hola! La Forja de Thot está abierta para todos. ¿Listo para construir?" y ofrece dos botones: "📖 ¿Cómo se juega?" y "🚀 Empezar". |
| **AC2** | **WHEN** el usuario hace clic en "🚀 Empezar" desde la bienvenida (sin Templo Nivel 5) **THEN** se activa el flag `FORGE_STATE.demo = true`, se muestra la pantalla "Tu misión", y al continuar se accede al Dashboard con todos los robots disponibles en modo demo. |

### De la Pantalla de Instrucciones (US-002)

| ID | Criterio EARS |
|---|---|
| **AC3** | **WHEN** el usuario hace clic en "📖 ¿Cómo se juega?" **THEN** se muestra una pantalla con 3 bloques visuales (🖥️ PC + VS Code, 🤖 Zoo Code, 📱 Celular/Tablet), cada uno con ícono ≥2.5rem y texto explicativo, responsive (columna en mobile, 3 columnas en desktop ≥600px). |

### De la Pantalla "Tu misión" (US-003)

| ID | Criterio EARS |
|---|---|
| **AC4** | **WHEN** el usuario accede a "Tu misión" (primera visita modo demo) **THEN** se muestra narrativa amigable + grid del Artefacto Roto con 5 celdas: 2 ✅ (pantallas funcionales) y 3 🔧 (por reparar), con botón "🚀 Empezar misión" que lleva al Dashboard. |

### De la Bienvenida Animada (US-004) + No Regresión

| ID | Criterio EARS |
|---|---|
| **AC5** | **WHEN** el usuario con Templo Nivel 5 completado abre la página **THEN** el flujo normal se preserva: bienvenida con mensaje "Bienvenido, aprendiz. La Forja te espera.", botón "🔧 Entrar a la Forja", acceso directo al Dashboard sin pasar por "Tu misión" ni modo demo. |

---

## Criterios de Aceptación Extendidos (selección adicional ≥5)

| ID | Criterio EARS | US |
|---|---|---|
| **AC6** | **GIVEN** que el usuario jugó en modo demo y completó el Robot Constructor **WHEN** recarga la página **THEN** el progreso demo se restaura (`demo: true` persiste), y el Dashboard muestra el Robot Constructor como completado con 25% de progreso. | US-001 |
| **AC7** | **WHEN** el usuario en modo demo completa todas las misiones y llega a la pantalla de victoria **THEN** el certificado muestra "Modo Demo — Completa el Templo para obtener el certificado oficial". | US-001 |
| **AC8** | **WHEN** la pantalla "¿Cómo se juega?" se renderiza **THEN** cada bloque tiene animación `fadeSlideIn` escalonada (bloque 1 → 100ms, bloque 2 → 200ms, bloque 3 → 300ms). | US-002 |
| **AC9** | **WHEN** el usuario con `prefers-reduced-motion` activo interactúa **THEN** las animaciones de glow en el título de bienvenida y el ícono animado se desactivan vía `@media (prefers-reduced-motion: reduce)`. | US-004 |
| **AC10** | **GIVEN** que el usuario tiene progreso real del Templo (`coala_v3_progress` con Nivel 5) Y progreso demo previo (`coala_forge_progress` con `demo: true`) **WHEN** abre la página **THEN** el progreso real del Templo tiene prioridad, se ignora el flag demo previo, y el flujo es el normal. | US-001 |

---

## Edge Cases Críticos (Prototipo: 2 seleccionados + referencia a 8 documentados)

| ID | Escenario | Comportamiento esperado | Riesgo |
|---|---|---|---|
| **EC-01** | `localStorage` está lleno o bloqueado (modo privado) | `saveState()` falla silenciosamente → `showToast('⚠️ Tu progreso no se guardará entre sesiones.')`. El juego sigue funcionando en memoria con flag `demo` en RAM. | Bajo |
| **EC-02** | Usuario recarga la página en medio del modo demo | `loadState()` recupera el progreso demo. El flag `demo: true` persiste. Toast: "¡Bienvenido de vuelta! Continuamos donde quedaste." | Bajo |

**Edge cases adicionales documentados en** [`user-stories.md`](user-stories.md:138-149): EC-002 (progreso Templo + demo previo), EC-005 (`coala_v3_progress` corrupto), EC-006 (viewport <320px), EC-007 (`prefers-reduced-motion`), EC-008 (clics repetidos en "Empezar").

---

## Definition of Done (DoD)

### DoD General (Prototipo)

- [ ] Código en un único archivo [`game_intermediate/index.html`](../../game_intermediate/index.html:1) (sin dependencias externas).
- [ ] CSS reutiliza las custom properties existentes (`--gold`, `--night`, `--font-title`, `--font-body`, etc.).
- [ ] JavaScript es vanilla, compatible con ES2018+ (Chrome 80+, Safari 13+, Firefox 75+).
- [ ] Responsive: probado en viewport 320px, 375px, 768px y 1024px.
- [ ] `prefers-reduced-motion` respeta la accesibilidad (regla CSS ya existente en [`@media`](../../game_intermediate/index.html:98)).
- [ ] `<noscript>` mantiene mensaje amigable existente sin modificar.
- [ ] No se rompe el state machine `FORGE_STATE` ni el `localStorage` existente.
- [ ] Web Audio API mantiene fallback silencioso (`try/catch` en [`AudioContext`](../../game_intermediate/index.html:318)).

### DoD Específico de esta Feature

- [ ] **US-001**: [`goToDashboard()`](../../game_intermediate/index.html:380) ya no bloquea a usuarios sin Templo Nivel 5.
- [ ] **US-001**: El flag `demo` se guarda y recupera correctamente en `localStorage` vía [`saveState()`](../../game_intermediate/index.html:330) / [`loadState()`](../../game_intermediate/index.html:337).
- [ ] **US-002**: La pantalla "¿Cómo se juega?" renderiza 3 bloques correctamente en mobile (columna) y desktop (3 columnas).
- [ ] **US-003**: La pantalla "Tu misión" muestra el artefacto en estado inicial (2/5 reparado) con grid de 5 celdas.
- [ ] **US-004**: La bienvenida tiene al menos 2 elementos visuales animados (ícono con `thotGlow` + botón `btn-primary` con `box-shadow` glow).
- [ ] **No regression**: El flujo completo del modo normal (con Templo Nivel 5) sigue funcionando igual que antes.
- [ ] **BDD**: Los 3 escenarios Gherkin de [`user-stories.md`](user-stories.md:152-212) son verificables manualmente en un navegador.

---

## Dependencias

| Dependencia | Estado | Notas |
|---|---|---|
| [`game_intermediate/index.html`](../../game_intermediate/index.html:1) | ✅ Existe (644 líneas) | Archivo a modificar. State machine funcional con 7 pantallas. |
| `localStorage['coala_v3_progress']` | ✅ Formato conocido | `{ unlocked: number[] }`. Producido por [`index.html`](../../index.html) raíz. |
| `localStorage['coala_forge_progress']` | ✅ Formato conocido | `{ v:1, progress, robots, artifact, score, checksum, savedAt }`. Producido por este HUB. |

---

## Riesgos

| Riesgo | Impacto | Mitigación |
|---|---|---|
| Regresión en flujo normal con Templo Nivel 5 | Alto | Condicional explícito: si `templeLevel5Complete === true` → mismo comportamiento que antes. Sin tocar el path feliz existente. |
| Confusión del usuario entre modo demo y modo normal | Medio | Toast informativo: "🎮 Modo demo activado. Completa el Templo para desbloquear el certificado oficial." |
| Incompatibilidad con estado previo de `localStorage` | Bajo | `loadState()` ya tiene `data.v!==1` guard. Se agrega `demo` como campo opcional con default `false`. |

---

## Notas de Implementación

- **No tocar:** [`index.html`](../../index.html) raíz, [`game_intermediate/seed/index.html`](../../game_intermediate/seed/index.html), [`game_beginner/`](../../game_beginner/), [`game_advanced/`](../../game_advanced/).
- **Solo modificar:** [`game_intermediate/index.html`](../../game_intermediate/index.html:1).
- **Custom properties existentes:** [`--gold: #D4A843`](../../game_intermediate/index.html:9), `--gold-bright: #F4C542`, `--sand: #E8D5A3`, `--night: #1A1A2E`, `--night-light: #252545`, `--success: #2ECC71`, `--error: #E74C3C`, `--font-title`, `--font-body`, `--font-mono`, `--radius: 12px`, `--radius-sm: 8px`, `--transition: 0.3s ease`.
- **Clases CSS reutilizables:** [`.card`](../../game_intermediate/index.html:27), [`.btn`](../../game_intermediate/index.html:30), [`.btn-primary`](../../game_intermediate/index.html:31), [`.btn-secondary`](../../game_intermediate/index.html:32), [`.screen`](../../game_intermediate/index.html:24), [`.toast`](../../game_intermediate/index.html:95), [`.artifact-grid`](../../game_intermediate/index.html:51), [`.artifact-cell`](../../game_intermediate/index.html:52).
- **Funciones JS existentes a modificar:** [`goToDashboard()`](../../game_intermediate/index.html:380), [`init()`](../../game_intermediate/index.html:626), [`saveState()`](../../game_intermediate/index.html:330), [`loadState()`](../../game_intermediate/index.html:337), [`resetGame()`](../../game_intermediate/index.html:617), [`finalizeMission()`](../../game_intermediate/index.html:573), [`showCertificate()`](../../game_intermediate/index.html:607).

---

[PROTO: requisitos simplificados. 10 ACs totales (mínimo 5 requeridos). 2 edge cases críticos expandidos. DoD enfocado en "funciona y se puede mostrar". Los detalles de implementación de las partes 2 (Matrix) y 3 (PWA mobile) están fuera de alcance.]

**STATUS: DRAFT ✓**
**OUTPUT_FILE:** `docs/specs/coala-forja-guide-fix/requirements.md`

# Requirements — COALA: La Forja de la Tabla Esmeralda

## Metadata

| Campo | Valor |
|---|---|
| **Feature ID** | FEAT-001 |
| **Slug** | `coala-forja-intermediate` |
| **Pipeline Mode** | PROTOTIPO 🚀 |
| **Stack** | HTML5 + CSS3 + Vanilla JS, cero dependencias |
| **Target** | `game_intermediate/index.html` (single-file autocontenido) |
| **Audiencia** | Niños y jóvenes (10-14 años), español |
| **Fuente** | `docs/specs/coala-forja-intermediate/user-stories.md` (8 HUs, 40 ACs) |
| **Fecha** | 2026-06-17 |

---

## Resumen del Feature

Un HUB web interactivo donde el aprendiz (que ya completó los 5 niveles del Templo de Thot en `index.html`) interactúa con **4 robots-agentes** —Constructor, Probador, Tabla Esmeralda, Forja— para reparar un **Artefacto Roto**: un juego incompleto de 5 pantallas donde solo 2 funcionan. El aprendiz progresa despertando robots, ejecutando comandos en Zoo Code/VS Code, y viendo cómo el Artefacto se repara visualmente.

El archivo [`custom_modes_v6.0_edu.yaml`](custom_modes_v6.0_edu.yaml) amplía los 6 agentes existentes con 4 robots nuevos que incluyen [`explicacion:`](custom_modes_v6.0_edu.yaml) educativa interactiva conectada a la metáfora de la Forja.

---

## Criterios de Aceptación (≥5 para prototipo)

Seleccionados de las 8 HUs priorizando flujo feliz completo:

### Del HUB (HU-1)

| ID | Criterio EARS |
|---|---|
| **AC1** | **WHEN** el aprendiz abre [`game_intermediate/index.html`](game_intermediate/index.html) **THEN** el HUB carga en <3 segundos sin errores de consola, mostrando mensaje de bienvenida de Thot y botón "🔧 Entrar a la Forja". |
| **AC2** | **WHEN** el aprendiz hace clic en "Entrar a la Forja" **THEN** se muestra el dashboard con: estado del Artefacto Roto (2/5 pantallas funcionales), 4 robots con estado "💤 Dormido", barra de progreso al 0%. |

### Del Robot Constructor (HU-2)

| ID | Criterio EARS |
|---|---|
| **AC3** | **WHEN** el aprendiz completa la interacción con el Robot Constructor (simulación de ejecutar `/constructor` en Zoo Code) **THEN** la pantalla 3 del Artefacto Roto pasa de gris a color con animación, el progreso avanza al 25%, y el Robot Probador se desbloquea. |

### Del Artefacto Roto + Progreso (HU-5, HU-6)

| ID | Criterio EARS |
|---|---|
| **AC4** | **WHEN** el aprendiz alcanza cada hito de progreso (25%, 50%, 75%, 100%) **THEN** la barra se actualiza con animación suave, se guarda en localStorage, y Thot entrega un "sabio consejo". |

### De la Victoria Final (HU-7)

| ID | Criterio EARS |
|---|---|
| **AC5** | **WHEN** el aprendiz completa todas las misiones (100% progreso) **THEN** el Artefacto Roto se transforma en juego completo jugable, aparece celebración de confeti CSS, pantalla de victoria con puntuación, y botón "🎓 Certificado de Aprendiz de la Forja". |

---

## Criterios de Aceptación Extendidos (selección adicional ≥5)

| ID | Criterio EARS | HU |
|---|---|---|
| **AC6** | **GIVEN** que el aprendiz cierra el navegador **WHEN** vuelve a abrir el HUB **THEN** el progreso se restaura desde localStorage y Thot dice "¡Bienvenido de vuelta! Continuamos donde quedaste." | HU-6 |
| **AC7** | **WHEN** el robot Tabla Esmeralda se activa **THEN** el HUB muestra vista previa del YAML con resaltado de sintaxis y editor inline con validación básica en tiempo real. | HU-4 |
| **AC8** | **WHEN** el Robot Forja se desbloquea (75%) **THEN** el HUB muestra checklist final: "✅ Constructor, ✅ Probador, ✅ Tabla Esmeralda, ⬜ Últimos toques". | HU-7 |
| **AC9** | **GIVEN** que el aprendiz no ha completado el Nivel 5 del Templo (`index.html`) **WHEN** abre el HUB **THEN** Thot muestra mensaje: "🌳 Primero debes dominar el Templo de Thot" con enlace al `index.html` raíz. | HU-1 |
| **AC10** | **WHEN** el aprendiz abre `custom_modes_v6.0_edu.yaml` en VS Code **THEN** cada robot tiene sección [`explicacion:`](custom_modes_v6.0_edu.yaml) que dice "Estoy aquí porque..." con contexto de la historia de la Forja. | HU-8 |

---

## Edge Cases Críticos (Prototipo: 5 seleccionados)

| ID | Escenario | Comportamiento esperado | HU |
|---|---|---|---|
| **EC-01** | Navegador sin JavaScript | Mostrar [`<noscript>`](game_intermediate/index.html) con mensaje: "La Forja necesita JavaScript para funcionar. Pídele ayuda a un adulto." | HU-1 |
| **EC-02** | localStorage bloqueado o lleno | El HUB funciona igual pero sin persistir progreso entre sesiones. Mostrar toast sutil: "⚠️ Tu progreso no se guardará entre sesiones." | HU-6 |
| **EC-03** | Pantalla muy pequeña (<320px) | Layout se adapta con texto legible mínimo 14px. Botones no se cortan. Touch funcional sin hover dependency. | HU-1 |
| **EC-04** | localStorage corrupto (JSON inválido) | HUB limpia la clave, reinicia progreso a 0, muestra mensaje: "Thot olvidó tu progreso. ¿Empezamos de nuevo?" | HU-6 |
| **EC-05** | Aprendiz intenta usar robot antes que el anterior | HUB bloquea con mensaje: "Primero despierta al robot anterior. Necesitamos completar cada paso en orden." | HU-2/HU-3 |

---

## Definition of Done — Prototipo 🚀

| # | Criterio |
|---|---|
| DOD-1 | El HUB carga en Chrome, Firefox, Edge (últimas 2 versiones) sin errores de consola en flujo feliz. |
| DOD-2 | El HUB funciona en móvil (touch) sin depender de hover, responsive ≥320px. |
| DOD-3 | Flujo completo: Bienvenida → Despertar Constructor → Despertar Probador → Activar Tabla Esmeralda → Activar Forja → Victoria (100%). |
| DOD-4 | Barra de progreso se actualiza con animación al 25%, 50%, 75%, 100%. |
| DOD-5 | localStorage guarda/restaura progreso correctamente entre sesiones. |
| DOD-6 | `<noscript>` presente con mensaje amigable en español. |
| DOD-7 | Artefacto Roto (`seed/index.html`) muestra 2/5 pantallas funcionales inicialmente; 5/5 al completar. |
| DOD-8 | `custom_modes_v6.0_edu.yaml` incluye 4 robots nuevos con sección `explicacion:` educativa. |
| DOD-9 | No se modifica `index.html` raíz ni archivos de `game_beginner/`. |
| DOD-10 | Todo el contenido nuevo vive en `game_intermediate/`. |
| DOD-11 | Tiempo de carga <3 segundos en conexión estándar. |
| DOD-12 | Cero dependencias externas (ni CDN, ni npm, ni fuentes externas). |

---

## Riesgos (Prototipo: solo críticos)

| Riesgo | Impacto | Mitigación |
|---|---|---|
| Artefacto Roto no detectable si el aprendiz no guarda archivos | Alto — rompe el loop de feedback | El HUB usa simulación de estados + botón "Ya lo hice" como fallback; no depende de file system polling real en prototipo. |
| localStorage no disponible en incógnito/modo privado | Medio — pierde persistencia | Fallback graceful: toast informativo, progreso en memoria de sesión. |

---

## Dependencias

- [`index.html`](index.html) raíz (Templo de Thot) debe existir sin modificaciones.
- Estilo visual consistente con el Templo: colores egipcios, glyphs, animaciones CSS.
- `custom_modes_v6.0_edu.yaml` existente como base para extender con robots de la Forja.

---

## Mapeo a Historias de Usuario

| HU | Título | ACs cubiertos | Prioridad |
|---|---|---|---|
| HU-1 | HUB de Misión — La Forja | AC1, AC2, AC9 | P0 |
| HU-2 | Robot Constructor | AC3 | P0 |
| HU-3 | Robot Probador | — (integración en AC3/AC4) | P0 |
| HU-4 | Robot Tabla Esmeralda | AC7 | P0 |
| HU-5 | Artefacto Roto | AC4, AC5 | P0 |
| HU-6 | Progreso Visual y Persistencia | AC4, AC6, AC9 | P0 |
| HU-7 | Robot Forja — Coordinador Final | AC5, AC8 | P1 |
| HU-8 | Custom Modes Educativos | AC10 | P1 |

---

## Notas de Prototipo

[PROTO: simplificado — 10 ACs seleccionados de 40 disponibles. 5 edge cases en vez de 8+ del spec completo. DoD enfocado en "funciona y se puede mostrar". Sin métricas de performance avanzadas, sin tests automatizados requeridos en esta fase.]

---

**STATUS: COMPLETE**  
**NEXT: Generar design.md y tasks.md**

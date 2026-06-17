# Requirements — COALA: El Portal del Código

## Metadata

| Campo | Valor |
|---|---|
| **Feature ID** | FEAT-003 |
| **Slug** | `coala-forja-matrix` |
| **Pipeline Mode** | PROTOTIPO 🚀 |
| **Stack** | HTML5 + CSS3 + Vanilla JS (Canvas 2D), cero dependencias |
| **Target** | `game_intermediate/matrix.html` (single-file autocontenido) |
| **Audiencia** | Niños y jóvenes (10-14 años), español |
| **Fuente** | [`docs/specs/coala-forja-matrix/user-stories.md`](docs/specs/coala-forja-matrix/user-stories.md) (8 US, 35 ACs, 12 edge cases) |
| **Fecha** | 2026-06-17 |

---

## Resumen del Feature

Escena cinemática de transición entre La Forja (nivel Intermedio) y el nivel Avanzado: **El Portal del Código**. Pantalla independiente con efecto de lluvia de caracteres estilo Matrix en Canvas 2D que transforma jeroglíficos dorados (`#d4a843`) en código verde neón (`#00ff41`). La magia antigua se vuelve código real. Al finalizar (~8-10s o con skip), el jugador cruza el portal hacia `game_advanced/index.html`.

---

## Criterios de Aceptación (≥5 para prototipo)

Seleccionados de las 8 US priorizando el flujo feliz completo:

### Del efecto Matrix Rain (US-001)

| ID | Criterio EARS |
|---|---|
| **AC1** | **WHEN** la escena se carga **THEN** una lluvia de caracteres cae desde la parte superior del viewport usando Canvas 2D con `requestAnimationFrame` a ~60fps, cubriendo todo el fondo. |
| **AC2** | **WHEN** la animación comienza **THEN** los caracteres iniciales son dorados (`#d4a843`) y durante los primeros 4-5 segundos los nuevos caracteres transicionan progresivamente a verde neón (`#00ff41`), con gradiente intermedio visible. |

### Del mensaje central (US-002)

| ID | Criterio EARS |
|---|---|
| **AC3** | **WHEN** transcurren entre 1 y 2 segundos desde el inicio **THEN** el mensaje "El código verdadero te espera..." aparece centrado con fade-in y efecto glow dorado (`text-shadow` con `#d4a843`). |

### Del botón y redirección (US-003)

| ID | Criterio EARS |
|---|---|
| **AC4** | **WHEN** han transcurrido 3 segundos (±500ms) desde el inicio **THEN** el botón "Cruzar el portal →" aparece con fade-in suave y redirige a `game_advanced/index.html` al hacer clic, con debounce de 500ms. |

### Del skip (US-004)

| ID | Criterio EARS |
|---|---|
| **AC5** | **WHEN** el jugador presiona `Escape` o toca la pantalla antes de los 3 segundos **THEN** el botón "Cruzar el portal →" aparece inmediatamente con fade-in rápido de 200ms. |

---

## Criterios de Aceptación Extendidos (selección adicional ≥5)

| ID | Criterio EARS | US |
|---|---|---|
| **AC6** | **GIVEN** que el sistema tiene `prefers-reduced-motion: reduce` **WHEN** la escena se carga **THEN** la lluvia se muestra como composición estática (sin caída), y tanto el mensaje como el botón aparecen inmediatamente. | US-005 |
| **AC7** | **GIVEN** que JavaScript está desactivado **WHEN** se carga `matrix.html` **THEN** se muestra el contenido de `<noscript>` con mensaje amigable en español y enlace directo a `game_advanced/index.html`. | US-006 |
| **AC8** | **WHEN** la escena se carga **THEN** existe una función `initAudio()` que intenta crear `AudioContext` con `try/catch`; el fallo no bloquea la escena ni produce errores de consola. | US-007 |
| **AC9** | **GIVEN** un viewport de 320px de ancho **WHEN** la escena se carga **THEN** los caracteres de lluvia son proporcionalmente más pequeños, el mensaje es legible sin desbordamiento, y el botón ocupa al menos el 80% del ancho. | US-008 |
| **AC10** | **GIVEN** que `game_advanced/index.html` no existe (404) **WHEN** el jugador hace clic en "Cruzar el portal →" **THEN** se muestra un overlay con mensaje amigable: "El portal se está construyendo... Vuelve pronto." y botón "Volver a La Forja" que redirige a `game_intermediate/index.html`. | US-003 |

---

## Edge Cases Críticos (Prototipo: 5 seleccionados)

| ID | Escenario | Comportamiento esperado | US |
|---|---|---|---|
| **EC-01** | `prefers-reduced-motion: reduce` activo | Escena completamente estática: caracteres distribuidos aleatoriamente sin animación, mensaje y botón visibles al instante. | US-005 |
| **EC-02** | `game_advanced/index.html` no existe (404) | Overlay con mensaje "El portal se está construyendo..." + botón "Volver a La Forja" → `game_intermediate/index.html`. | US-003 |
| **EC-03** | Múltiples clics rápidos en "Cruzar el portal" | Debounce de 500ms; solo la primera redirección se ejecuta. | US-003 |
| **EC-04** | Pantalla < 360px de ancho (portrait estrecho) | Caracteres de lluvia más pequeños; mensaje en 2 líneas si es necesario; botón full-width. | US-008 |
| **EC-05** | Navegador sin soporte de Canvas (muy antiguo) | Fallback a CSS grid con caracteres estáticos distribuidos + mensaje y botón funcionales. | US-001 |

---

## Definition of Done — Prototipo 🚀

| # | Criterio |
|---|---|
| DOD-1 | Archivo `game_intermediate/matrix.html` existe y es **single-file autocontenido** (`<style>` + `<script>` inline, cero dependencias externas). |
| DOD-2 | La lluvia de caracteres Canvas 2D se visualiza correctamente en resoluciones de 320px a 2560px. |
| DOD-3 | Transición de color dorado → verde es visible y progresiva durante ~4-5 segundos. |
| DOD-4 | Mensaje "El código verdadero te espera..." aparece con glow dorado y fade-in entre el segundo 1 y 2. |
| DOD-5 | Botón "Cruzar el portal →" aparece a los 3s (±500ms) con fade-in y redirige a `game_advanced/index.html`. |
| DOD-6 | Skip con `Escape` y tap/click hace aparecer el botón inmediatamente. |
| DOD-7 | `@media (prefers-reduced-motion: reduce)` muestra escena estática sin animaciones. |
| DOD-8 | `<noscript>` presente con mensaje amigable en español para niños y enlace directo. |
| DOD-9 | Web Audio API con `try/catch` fallback silencioso (estructura preparatoria, sin sonido audible). |
| DOD-10 | Mobile-first responsive: viewport meta, tipografía `clamp()`, touch targets ≥44px, visible en 320px+. |
| DOD-11 | No modifica ningún archivo existente del proyecto. |
| DOD-12 | Probado en Chrome, Firefox, Edge (últimas 2 versiones) sin errores de consola en flujo feliz. |

---

## Riesgos (Prototipo: solo críticos)

| Riesgo | Impacto | Mitigación |
|---|---|---|
| `game_advanced/index.html` no existe aún | Medio — el botón redirige a 404 | Implementar `fetch` HEAD previo a la redirección; si falla, mostrar overlay de fallback con mensaje amigable y botón de retorno. |
| Canvas no soportado en navegadores muy antiguos | Bajo — pérdida del efecto visual | Fallback a CSS grid con caracteres estáticos; el mensaje y botón siguen funcionales. |

---

## Dependencias

- [`game_intermediate/index.html`](game_intermediate/index.html) (La Forja HUB) debe existir sin modificaciones.
- Estilo visual consistente con el Templo de Thot: paleta egipcia, custom properties `--night` y `--gold`.
- `game_advanced/index.html` — destino de la redirección (puede no existir aún; se maneja con fallback).
- Sin dependencias externas: no CDN, no fuentes de Google, no frameworks.

---

## Mapeo a Historias de Usuario

| US | Título | ACs cubiertos | Prioridad |
|---|---|---|---|
| US-001 | Lluvia de caracteres transformándose | AC1, AC2 | P0 |
| US-002 | Mensaje enigmático central | AC3 | P0 |
| US-003 | Botón para cruzar el portal | AC4, AC10 | P0 |
| US-004 | Saltar la escena (Skip) | AC5 | P0 |
| US-005 | Accesibilidad — movimiento reducido | AC6 | P0 |
| US-006 | Fallback sin JavaScript | AC7 | P1 |
| US-007 | Preparación para audio ambiental | AC8 | P1 |
| US-008 | Responsive multi-dispositivo | AC9 | P1 |

---

## Notas de Prototipo

[PROTO: simplificado — 10 ACs seleccionados de 35 disponibles en las 8 US. 5 edge cases en vez de 12 del spec completo. DoD enfocado en "funciona y se puede mostrar". Sin métricas de performance avanzadas (LCP, FID, CLS). Sin tests automatizados requeridos en esta fase. El fallback de Canvas es CSS-only; sin polyfills. La redirección 404 usa `fetch` HEAD + `setTimeout` como detección básica.]

---

**STATUS: COMPLETE**  
**NEXT: Generar design.md y tasks.md**

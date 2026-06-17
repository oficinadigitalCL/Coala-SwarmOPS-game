# User Stories — El Portal del Código

**Slug:** `coala-forja-matrix`
**Fase:** 0 (Enrichment)
**Fecha:** 2026-06-17
**STATUS:** ENRICHED ✓

---

## Anti-Duplicate Check

| Criterio | Resultado |
|----------|-----------|
| ¿Existe `game_intermediate/matrix.html`? | ❌ No existe |
| ¿Existe escena de transición cinemática en el repo? | ❌ No existe |
| ¿Existe efecto Matrix / lluvia de caracteres? | ❌ No existe |
| ¿Feature sugerida en swarm-context? | ✅ Sí — `coala-forja-part2-matrix` (próximas features sugeridas) |
| Features relacionadas completadas | `coala-forja-intermediate` (HUB), `coala-forja-guide-fix` (guía didáctica) |

**Veredicto:** Feature nueva, sin duplicados. Es la continuación natural del nivel Intermedio hacia el Avanzado.

---

## Historias de Usuario (Formato EARS)

### US-001: Lluvia de caracteres transformándose
> **Como** jugador que completó La Forja,
> **cuando** la escena del Portal se carga,
> **quiero** ver caracteres cayendo como lluvia que cambian gradualmente de dorado (jeroglíficos) a verde neón (código),
> **para que** sienta que la magia antigua se transforma en código real.

**Criterios de aceptación:**
- [AC-001.1] La lluvia de caracteres cubre todo el viewport como fondo animado.
- [AC-001.2] Los caracteres iniciales son dorados (`#d4a843`) y representan jeroglíficos / símbolos egipcios digitales.
- [AC-001.3] Durante los primeros 4-5 segundos, los caracteres nuevos que caen van cambiando progresivamente a verde neón (`#00ff41`).
- [AC-001.4] La transición de color no es abrupta; existe un gradiente intermedio visible.
- [AC-001.5] La animación usa `requestAnimationFrame` o CSS animations para 60fps.
- [AC-001.6] Si `prefers-reduced-motion` está activo, la lluvia se muestra como una pantalla estática con los caracteres distribuidos aleatoriamente (sin movimiento).

---

### US-002: Mensaje enigmático central
> **Como** jugador inmerso en la narrativa,
> **cuando** la escena ha comenzado,
> **quiero** leer el mensaje "El código verdadero te espera..." en el centro de la pantalla,
> **para que** sienta misterio y anticipación antes del nivel Avanzado.

**Criterios de aceptación:**
- [AC-002.1] El mensaje aparece centrado horizontal y verticalmente.
- [AC-002.2] El texto tiene efecto glow dorado (`text-shadow` con `#d4a843`).
- [AC-002.3] El mensaje se revela progresivamente (fade-in) entre el segundo 1 y 2.
- [AC-002.4] La tipografía es legible en todos los tamaños de pantalla (`clamp()` para fluid typography).
- [AC-002.5] Si `prefers-reduced-motion` está activo, el mensaje aparece inmediatamente al cargar.

---

### US-003: Botón para cruzar el portal
> **Como** jugador impaciente o emocionado,
> **cuando** han pasado ~3 segundos de la escena,
> **quiero** ver un botón "Cruzar el portal →",
> **para que** pueda avanzar al nivel Avanzado cuando yo decida.

**Criterios de aceptación:**
- [AC-003.1] El botón aparece a los 3 segundos (±500ms tolerancia) desde el inicio.
- [AC-003.2] Antes de los 3 segundos, el botón no es visible ni interactuable.
- [AC-003.3] El botón tiene estilo consistente con el tema egipcio (bordes dorados, fondo oscuro, hover verde).
- [AC-003.4] Touch target ≥ 44×44 px (WCAG 2.1).
- [AC-003.5] Al hacer clic/tap, redirige a `game_advanced/index.html`.
- [AC-003.6] El botón incluye debounce para evitar múltiples redirecciones si se clickea rápidamente.
- [AC-003.7] Si `game_advanced/index.html` no existe (404), muestra un mensaje amigable: "El portal se está construyendo... Vuelve pronto." (fallback controlado).

---

### US-004: Saltar la escena (Skip)
> **Como** jugador que ya vio la escena o quiere avanzar rápido,
> **cuando** presiono la tecla Escape o toco la pantalla antes de los 3 segundos,
> **quiero** que el botón de portal aparezca inmediatamente,
> **para que** no me sienta atrapado en una cinemática.

**Criterios de aceptación:**
- [AC-004.1] Presionar `Escape` acelera la aparición del botón a inmediato.
- [AC-004.2] Tocar/clic en cualquier parte de la pantalla (excepto el botón) también acelera el botón.
- [AC-004.3] El skip no causa glitch visual: el botón hace fade-in rápido (200ms).
- [AC-004.4] En móvil, el gesto de tap funciona como skip.

---

### US-005: Accesibilidad — movimiento reducido
> **Como** jugador con sensibilidad al movimiento,
> **cuando** tengo activada la preferencia `prefers-reduced-motion`,
> **quiero** que la escena sea estática o con mínima animación,
> **para que** pueda disfrutar la experiencia sin malestar.

**Criterios de aceptación:**
- [AC-005.1] Se respeta la media query `prefers-reduced-motion: reduce`.
- [AC-005.2] La lluvia de caracteres se muestra como una composición estática (sin caída).
- [AC-005.3] El mensaje y botón aparecen inmediatamente (sin delays progresivos).
- [AC-005.4] Aún así se mantiene el tema visual dorado → verde (solo estático).

---

### US-006: Fallback sin JavaScript
> **Como** jugador con navegador restringido o JS desactivado,
> **cuando** cargo `matrix.html`,
> **quiero** ver un mensaje amigable y un enlace directo al siguiente nivel,
> **para que** no quede en una pantalla en blanco.

**Criterios de aceptación:**
- [AC-006.1] El documento incluye `<noscript>` con mensaje en español dirigido a niños.
- [AC-006.2] El mensaje `<noscript>` incluye un enlace directo a `game_advanced/index.html`.
- [AC-006.3] El estilo básico se aplica sin JS (CSS inline).

---

### US-007: Preparación para audio ambiental
> **Como** experiencia inmersiva,
> **cuando** la escena se carga,
> **quiero** tener la estructura de Web Audio API lista con fallback silencioso,
> **para que** en el futuro se pueda agregar sonido ambiental sin refactorizar.

**Criterios de aceptación:**
- [AC-007.1] El código incluye una función `initAudio()` que intenta crear `AudioContext`.
- [AC-007.2] Si `AudioContext` falla o es bloqueado, el error se captura silenciosamente (`try/catch`).
- [AC-007.3] No hay sonido audible en esta versión (estructura preparatoria solamente).
- [AC-007.4] No se bloquea la escena si el audio no está disponible.

---

### US-008: Responsive multi-dispositivo
> **Como** jugador en celular, tablet o PC,
> **cuando** abro la escena en cualquier dispositivo,
> **quiero** que se vea bien y sea jugable,
> **para que** pueda continuar mi progreso desde cualquier pantalla.

**Criterios de aceptación:**
- [AC-008.1] Mobile-first: diseño base es móvil, escalado hacia arriba.
- [AC-008.2] Viewport correctamente configurado (`<meta name="viewport">`).
- [AC-008.3] Tipografía fluida con `clamp()`.
- [AC-008.4] Breakpoints: 320px (mínimo), 480px (mobile), 768px (tablet), 1024px+ (desktop).
- [AC-008.5] En pantallas < 320px, se ajusta el tamaño de los caracteres de lluvia para no saturar.

---

## Edge Cases

| ID | Escenario | Comportamiento Esperado |
|----|-----------|------------------------|
| EC-001 | Usuario recarga la página durante la escena | La escena reinicia desde cero (no hay estado que preservar) |
| EC-002 | `game_advanced/index.html` no existe todavía | Mostrar overlay con mensaje amigable: "El portal se está construyendo..." + botón "Volver a La Forja" |
| EC-003 | `prefers-reduced-motion: reduce` en sistema operativo | Escena estática inmediata, sin animaciones de caída |
| EC-004 | Dispositivo en modo ahorro de batería / Low Power Mode | Animación continúa funcionando (no es intensiva en CPU con requestAnimationFrame) |
| EC-005 | Pantalla con orientación landscape en móvil | La lluvia se adapta al nuevo ancho; mensaje sigue centrado |
| EC-006 | Pantalla con orientación portrait muy estrecha (< 360px) | Caracteres de lluvia más pequeños; mensaje en 2 líneas si es necesario |
| EC-007 | Múltiples clics rápidos en "Cruzar el portal" | Debounce de 500ms; solo la primera redirección se ejecuta |
| EC-008 | localStorage corrupto o inaccesible | No afecta esta escena (no depende de localStorage) |
| EC-009 | Navegador sin soporte de Canvas (muy antiguo) | Fallback a CSS grid con animaciones simples o composición estática |
| EC-010 | JavaScript se bloquea a mitad de la animación | El navegador queda con el último frame renderizado; al recargar reinicia |
| EC-011 | Usuario presiona "Atrás" del navegador después de redirigir | Vuelve a `matrix.html` y la escena reinicia (comportamiento normal de navegador) |
| EC-012 | `game_advanced/index.html` devuelve 403 / error de red | Capturar error en `window.onerror` del iframe o fetch previo; mostrar mensaje amigable |

---

## BDD / Gherkin Scenarios

```gherkin
Feature: El Portal del Código — Escena de transición cinemática

  Background:
    Given el jugador ha completado La Forja
    And el navegador carga "game_intermediate/matrix.html"

  Scenario: Visualización de la lluvia de caracteres dorados a verde
    When la escena comienza
    Then el fondo debe ser de color "#0a0a0f"
    And debe verse una lluvia de caracteres cayendo desde la parte superior
    And los caracteres iniciales deben ser de color dorado "#d4a843"
    And dentro de los primeros 5 segundos los nuevos caracteres deben tornarse verde "#00ff41"
    And la animación debe mantener 60fps

  Scenario: Aparece el mensaje central enigmático
    When han transcurrido entre 1 y 2 segundos desde el inicio
    Then el mensaje "El código verdadero te espera..." debe aparecer centrado
    And el mensaje debe tener un glow dorado
    And el fade-in del mensaje debe durar aproximadamente 1 segundo

  Scenario: Aparece el botón para cruzar el portal
    When han transcurrido 3 segundos desde el inicio
    Then el botón "Cruzar el portal →" debe ser visible
    And el botón debe estar habilitado para clic
    And el botón debe tener un touch target de al menos 44x44 pixeles

  Scenario: Cruzar el portal hacia el nivel Avanzado
    Given el botón "Cruzar el portal →" es visible
    When el jugador hace clic en el botón
    Then el navegador debe redirigir a "game_advanced/index.html"

  Scenario: Saltear la escena con tecla Escape
    Given la escena está en curso
    And han transcurrido menos de 3 segundos
    When el jugador presiona la tecla Escape
    Then el botón "Cruzar el portal →" debe aparecer inmediatamente
    And el botón debe hacer un fade-in rápido de 200ms

  Scenario: Saltear la escena con tap en pantalla
    Given la escena está en curso
    And han transcurrido menos de 3 segundos
    When el jugador toca cualquier parte de la pantalla (excepto el botón)
    Then el botón "Cruzar el portal →" debe aparecer inmediatamente

  Scenario: Accesibilidad con prefers-reduced-motion
    Given el sistema del jugador tiene activada la preferencia de movimiento reducido
    When la escena se carga
    Then la lluvia de caracteres debe mostrarse como una composición estática
    And el mensaje "El código verdadero te espera..." debe aparecer inmediatamente
    And el botón "Cruzar el portal →" debe aparecer inmediatamente
    And no debe haber animaciones de caída

  Scenario: Navegador sin JavaScript
    Given el navegador tiene JavaScript desactivado
    When se carga "game_intermediate/matrix.html"
    Then debe mostrarse el contenido de <noscript>
    And el mensaje debe ser amigable para niños en español
    And debe haber un enlace directo a "game_advanced/index.html"

  Scenario: Portal destino no disponible todavía
    Given "game_advanced/index.html" no existe o devuelve 404
    When el jugador hace clic en "Cruzar el portal →"
    Then debe mostrarse un mensaje amigable: "El portal se está construyendo... Vuelve pronto."
    And debe haber un botón para volver a "game_intermediate/index.html"

  Scenario: Responsive en dispositivo móvil pequeño
    Given el viewport tiene un ancho de 320px
    When la escena se carga
    Then los caracteres de lluvia deben ser proporcionalmente más pequeños
    And el mensaje debe ser legible sin desbordamiento
    And el botón debe ocupar al menos el 80% del ancho disponible
```

---

## Definition of Done (DoD)

### Funcional
- [ ] Archivo `game_intermediate/matrix.html` existe y es **single-file autocontenido** (`<style>` + `<script>` inline, cero dependencias).
- [ ] La lluvia de caracteres se visualiza correctamente en resoluciones de 320px a 2560px.
- [ ] Transición de color dorado → verde es visible y perceptible (no instantánea).
- [ ] Mensaje "El código verdadero te espera..." aparece con glow dorado y fade-in progresivo.
- [ ] Botón "Cruzar el portal →" aparece a los 3 segundos (±500ms) con fade-in suave.
- [ ] Click en el botón redirige a `game_advanced/index.html`.
- [ ] Skip funciona con `Escape` y con tap/click en pantalla.
- [ ] Debounce en el botón evita redirecciones múltiples.

### Accesibilidad
- [ ] Implementado `@media (prefers-reduced-motion: reduce)` con escena estática.
- [ ] Incluido `<noscript>` con mensaje amigable en español para niños y enlace directo.
- [ ] Touch targets ≥ 44×44 px.
- [ ] Contraste de texto sobre fondo cumple WCAG AA (glow no reduce legibilidad).
- [ ] Tipografía fluida con `clamp()` legible en todos los tamaños.

### Técnico
- [ ] No modifica ningún archivo existente del proyecto.
- [ ] No tiene dependencias externas (no CDN, no frameworks).
- [ ] Web Audio API con `try/catch` fallback silencioso (estructura preparatoria).
- [ ] Uso de `requestAnimationFrame` para animaciones eficientes.
- [ ] Código comentado en español (opcional, según preferencia del equipo).
- [ ] `<meta name="viewport">` correctamente configurado.

### Calidad / Validación
- [ ] Probado en Chrome, Firefox, Safari, Edge (últimas 2 versiones).
- [ ] Probado en modo móvil (DevTools) y dispositivo real si es posible.
- [ ] Lighthouse Accessibility score ≥ 90.
- [ ] No hay errores en consola (salvo advertencias controladas de AudioContext).
- [ ] Tiempo de carga < 1s en conexión 3G simulada (archivo liviano).

### Narrativo / Temático
- [ ] Paleta de colores respeta las variables del tema: `--night` `#0a0a0f`, `--gold` `#d4a843`, `--matrix-green` `#00ff41`.
- [ ] Sensación de MISTERIO preservada (tono enigmático, no infantilizado).
- [ ] Conexión narrativa con La Forja: la Tabla Esmeralda se "digitaliza".

---

## Notas de Implementación

- **Canvas vs CSS:** Se recomienda Canvas 2D para la lluvia de caracteres (mejor performance con muchas partículas). Fallback a CSS grid si Canvas no está disponible.
- **Charset de lluvia:** Jeroglíficos Unicode (U+13000–U+1342F) o símbolos egipcios estilizados; si no se ven bien en todos los navegadores, usar subset seguro: `A-Z`, `0-9`, `!@#$%^&*()`, y algunos caracteres especiales como `Φ`, `Ω`, `Ψ` para sensación mística.
- **Redirección 404:** Como `game_advanced/index.html` aún no existe, implementar un `fetch` HEAD previo o manejar el error de redirección con `window.location` + `setTimeout` para detectar si la página carga.
- **Duración total:** ~8-10 segundos naturales si el usuario espera; puede reducirse a ~3 segundos con skip.

---

**STATUS: ENRICHED ✓**

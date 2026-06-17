# Testing — COALA: El Portal del Código

## Metadata

| Campo | Valor |
|---|---|
| **Feature ID** | FEAT-003 |
| **Slug** | `coala-forja-matrix` |
| **Pipeline Mode** | PROTOTIPO 🚀 |
| **Stack** | HTML5 + CSS3 + Vanilla JS (Canvas 2D), cero dependencias |
| **Testing Approach** | Manual checklist + DevTools validation |
| **Framework** | Ninguno (validación manual en navegador) |
| **Fecha** | 2026-06-17 |

---

## Estrategia de Testing — Prototipo

[PROTO: cobertura mínima — 1 test de happy path por AC. 0 tests de E2E. 0 tests automatizados. Sin mutation testing. Validación manual en Chrome/Firefox/Edge con DevTools. En versión beta se migraría a Jest + jsdom con 80% coverage.]

---

## Test Cases por Criterio de Aceptación

### TC-01: Lluvia de caracteres Canvas 2D (AC1)

| Campo | Valor |
|---|---|
| **AC cubierto** | AC1 — Lluvia cubre viewport, Canvas 2D, ~60fps |
| **Tipo** | Manual — Inspección visual |
| **Precondición** | `matrix.html` cargado en navegador con JS habilitado, sin `prefers-reduced-motion` |

**Pasos:**
1. Abrir `game_intermediate/matrix.html` en Chrome
2. Observar que el Canvas ocupa todo el viewport (inspeccionar `canvas.width/height === window.innerWidth/Height`)
3. Verificar que los caracteres caen desde la parte superior
4. Abrir DevTools → Performance → grabar 3s → confirmar ~60fps (frames uniformes)
5. Repetir en Firefox y Edge

**Resultado esperado:**
- ✅ Canvas cubre 100% del viewport sin scroll
- ✅ Caracteres visibles cayendo continuamente
- ✅ Sin errores de consola
- ✅ FPS estable (~55-60 fps en hardware moderno)

---

### TC-02: Transición de color dorado → verde (AC2)

| Campo | Valor |
|---|---|
| **AC cubierto** | AC2 — Caracteres dorados → verdes en 4-5s con gradiente |
| **Tipo** | Manual — Inspección visual + temporizador |

**Pasos:**
1. Cargar `matrix.html` (recargar para resetear animación)
2. Observar los primeros 2 segundos: todos los caracteres nuevos deben ser dorados (`#d4a843`)
3. Entre 2-4 segundos: verificar aparición progresiva de caracteres verdes (`#00ff41`)
4. Después de 5 segundos: confirmar que ≥90% de los caracteres nuevos son verdes
5. Tomar screenshot al segundo 3 y verificar visualmente mezcla de colores

**Resultado esperado:**
- ✅ t=0-2s: caracteres predominantemente dorados
- ✅ t=2-4s: gradiente visible (mezcla dorado + verde)
- ✅ t=5s+: caracteres predominantemente verde neón
- ✅ Sin cambio abrupto de color (transición suave)

---

### TC-03: Mensaje central con glow (AC3)

| Campo | Valor |
|---|---|
| **AC cubierto** | AC3 — Mensaje "El código verdadero te espera..." centrado, glow, fade-in 1-2s |
| **Tipo** | Manual — Inspección visual + DevTools |

**Pasos:**
1. Cargar `matrix.html`
2. Verificar que el mensaje NO es visible en t=0s
3. Esperar entre el segundo 1 y 2: confirmar que el texto aparece con fade-in suave
4. Inspeccionar el elemento `h1.matrix-message` → verificar `text-shadow` con `#d4a843`
5. Verificar centrado: `position:fixed; top:50%; left:50%; transform:translate(-50%,-50%)`
6. En móvil (320px): verificar que el texto no desborda

**Resultado esperado:**
- ✅ Mensaje invisible al inicio
- ✅ Fade-in perceptible (~1s) entre t=1s y t=2s
- ✅ Glow dorado visible (text-shadow)
- ✅ Centrado en viewport en todos los breakpoints
- ✅ `pointer-events:none` (no bloquea taps)

---

### TC-04: Botón "Cruzar el portal →" y redirección (AC4)

| Campo | Valor |
|---|---|
| **AC cubierto** | AC4 — Botón aparece a los 3s, redirige, debounce |
| **Tipo** | Manual — Interacción + verificación de redirección |

**Pasos:**
1. Cargar `matrix.html`
2. Verificar que el botón NO es visible antes de t=2.5s
3. Esperar hasta t=3s (±500ms): confirmar que el botón aparece con fade-in
4. Verificar touch target: inspeccionar `min-height:48px`, `min-width` ≥ 80vw en móvil
5. Hacer clic en el botón → verificar redirección a `game_advanced/index.html`
6. Recargar, hacer 3 clics rápidos seguidos → verificar que solo se ejecuta 1 redirección

**Resultado esperado:**
- ✅ Botón invisible antes de t=3s
- ✅ Botón aparece con fade-in suave a los 3s (±500ms)
- ✅ Touch target ≥ 48px alto
- ✅ Clic redirige correctamente
- ✅ Debounce: clics múltiples → 1 sola redirección

---

### TC-05: Skip con Escape y tap (AC5)

| Campo | Valor |
|---|---|
| **AC cubierto** | AC5 — Escape o tap antes de 3s → botón inmediato (200ms fade-in) |
| **Tipo** | Manual — Interacción con teclado y touch |

**Pasos:**
1. Cargar `matrix.html`
2. Inmediatamente presionar `Escape` → verificar botón aparece con fade-in rápido
3. Recargar, hacer tap en cualquier parte de la pantalla (no en el botón) → verificar botón aparece
4. Recargar, esperar a que el botón ya esté visible (t>3s) → presionar Escape otra vez → verificar que no hace nada extraño
5. En móvil (o DevTools touch simulation): tap en la pantalla → botón aparece

**Resultado esperado:**
- ✅ Escape antes de t=3s → botón inmediato (fade-in ~200ms)
- ✅ Tap/click antes de t=3s → botón inmediato
- ✅ Escape/tap después de que el botón ya es visible → sin efecto secundario
- ✅ Tap en móvil funciona igual que click en desktop

---

### TC-06: prefers-reduced-motion (AC6)

| Campo | Valor |
|---|---|
| **AC cubierto** | AC6 — Escena estática, mensaje y botón inmediatos |
| **Tipo** | Manual — DevTools Rendering |

**Pasos:**
1. Abrir DevTools → Rendering → marcar "Emulate CSS media feature prefers-reduced-motion: reduce"
2. Cargar `matrix.html`
3. Verificar que NO hay animación de lluvia (Canvas estático o `fallbackGrid` visible)
4. Verificar que el mensaje "El código verdadero te espera..." es visible inmediatamente
5. Verificar que el botón "Cruzar el portal →" es visible inmediatamente
6. Confirmar que la escena mantiene el tema dorado/verde (solo estático)

**Resultado esperado:**
- ✅ Sin animación de caída de caracteres
- ✅ Mensaje visible al cargar (sin delay)
- ✅ Botón visible al cargar (sin delay)
- ✅ Tema visual dorado/verde preservado

---

### TC-07: `<noscript>` amigable (AC7)

| Campo | Valor |
|---|---|
| **AC cubierto** | AC7 — Mensaje amigable con enlace directo cuando JS desactivado |
| **Tipo** | Manual — DevTools Settings |

**Pasos:**
1. Abrir Chrome DevTools → Settings → Debugger → marcar "Disable JavaScript"
2. Cargar `matrix.html`
3. Verificar que se muestra el contenido de `<noscript>`
4. Verificar mensaje en español: "El Portal del Código", explicación, enlace a `game_advanced/index.html`
5. Hacer clic en el enlace "🚀 Ir al nivel Avanzado directamente" → verificar que redirige
6. Verificar que el diseño sin JS es legible y atractivo

**Resultado esperado:**
- ✅ Contenido `<noscript>` visible con JS desactivado
- ✅ Texto en español, tono amigable para niños
- ✅ Enlace directo funcional a `game_advanced/index.html`
- ✅ Estilo inline aplicado correctamente

---

### TC-08: Web Audio API — estructura preparatoria (AC8)

| Campo | Valor |
|---|---|
| **AC cubierto** | AC8 — `initAudio()` con try/catch, sin errores, sin sonido |
| **Tipo** | Manual — Consola + inspección de código |

**Pasos:**
1. Cargar `matrix.html` con JS habilitado
2. Abrir DevTools → Console → verificar mensaje "🎵 Audio listo (sin sonido en prototipo)" O "🔇 Audio no disponible, continuando sin sonido"
3. Verificar que NO hay errores rojos en consola relacionados con AudioContext
4. Inspeccionar código fuente: confirmar que `initAudio()` existe y contiene `try/catch`
5. Bloquear AudioContext (Chrome: site settings → Sound → Block) → recargar → verificar fallback silencioso

**Resultado esperado:**
- ✅ `initAudio()` se ejecuta sin errores
- ✅ Mensaje de consola informativo (éxito o fallback)
- ✅ Sin sonido audible (estructura preparatoria)
- ✅ Sin bloqueo de la escena si audio no disponible

---

### TC-09: Responsive 320px (AC9)

| Campo | Valor |
|---|---|
| **AC cubierto** | AC9 — Viewport 320px, caracteres pequeños, mensaje legible, botón ≥80% ancho |
| **Tipo** | Manual — DevTools Device Toolbar |

**Pasos:**
1. Abrir DevTools → Device Toolbar → seleccionar "iPhone SE" (375px) o "Responsive" 320px
2. Cargar `matrix.html`
3. Verificar que el Canvas ocupa todo el viewport
4. Verificar que los caracteres de lluvia son proporcionalmente más pequeños (fontSize ~12px)
5. Verificar que el mensaje "El código verdadero te espera..." es legible (no truncado, posiblemente 2 líneas)
6. Verificar que el botón ocupa ≥80% del ancho disponible
7. Verificar que no hay scroll horizontal

**Resultado esperado:**
- ✅ Canvas full-viewport sin overflow horizontal
- ✅ Caracteres de lluvia visibles y legibles (no saturados)
- ✅ Mensaje legible, wrap automático si es necesario
- ✅ Botón ≥80% del viewport width
- ✅ `viewport` meta tag presente y correcto

---

### TC-10: Portal no disponible — fallback overlay (AC10)

| Campo | Valor |
|---|---|
| **AC cubierto** | AC10 — 404 → overlay amigable + botón "Volver a La Forja" |
| **Tipo** | Manual — Simulación |

**Pasos:**
1. Asegurarse de que `game_advanced/index.html` NO existe (estado actual del proyecto)
2. Cargar `matrix.html`, esperar al botón (o hacer skip), hacer clic en "Cruzar el portal →"
3. Verificar que aparece overlay con: ícono 🏗️, texto "El portal se está construyendo... Vuelve pronto."
4. Verificar que el botón "⬅️ Volver a La Forja" está presente y redirige a `game_intermediate/index.html`
5. Si `game_advanced/index.html` existe: mockear la respuesta del `fetch` para que devuelva 404 (comentar temporalmente)

**Resultado esperado:**
- ✅ Overlay visible cuando el destino no existe
- ✅ Mensaje amigable y no técnico
- ✅ Botón "Volver a La Forja" redirige a `index.html`
- ✅ El overlay no bloquea permanentemente (el botón de retorno funciona)

---

## BDD / Gherkin — Escenarios Clave (3 seleccionados para prototipo)

### Scenario 1: Visualización de la lluvia

```gherkin
Feature: El Portal del Código — Escena Matrix

  Background:
    Given el jugador ha completado La Forja
    And el navegador carga "game_intermediate/matrix.html"
    And JavaScript está habilitado
    And prefers-reduced-motion NO está activo

  Scenario: Lluvia de caracteres dorados a verde
    When la escena comienza
    Then el fondo debe ser de color "#0a0a0f"
    And debe verse una lluvia de caracteres cayendo desde la parte superior en Canvas 2D
    And los caracteres iniciales deben ser de color dorado "#d4a843"
    And dentro de los primeros 5 segundos los nuevos caracteres deben tornarse verde "#00ff41"
    And la animación debe mantener aproximadamente 60fps
```

### Scenario 2: Aparición del mensaje y botón

```gherkin
  Scenario: Mensaje central y botón del portal
    When la escena comienza
    And ha transcurrido entre 1 y 2 segundos
    Then el mensaje "El código verdadero te espera..." debe aparecer centrado con glow dorado
    And el fade-in del mensaje debe durar aproximadamente 1 segundo
    When han transcurrido 3 segundos
    Then el botón "Cruzar el portal →" debe ser visible y funcional
    And el botón debe tener un touch target de al menos 44x44 píxeles
    When el jugador hace clic en el botón
    Then el navegador debe redirigir a "game_advanced/index.html"
```

### Scenario 3: Skip con Escape

```gherkin
  Scenario: Saltear la escena con tecla Escape
    Given la escena está en curso
    And han transcurrido menos de 3 segundos
    When el jugador presiona la tecla Escape
    Then el botón "Cruzar el portal →" debe aparecer inmediatamente
    And el botón debe hacer un fade-in rápido de 200ms
```

---

## Checklist de Validación Manual — Prototipo

| # | Prueba | US | Navegador | Estado |
|---|---|---|---|---|
| 1 | Canvas 2D carga sin errores | US-001 | Chrome | ⬜ |
| 2 | Lluvia visible y fluida (~60fps) | US-001 | Chrome | ⬜ |
| 3 | Transición dorado → verde visible | US-001 | Chrome | ⬜ |
| 4 | Mensaje centrado con glow | US-002 | Chrome | ⬜ |
| 5 | Botón aparece a los 3s | US-003 | Chrome | ⬜ |
| 6 | Clic en botón → redirección | US-003 | Chrome | ⬜ |
| 7 | Debounce en botón (clic rápido) | US-003 | Chrome | ⬜ |
| 8 | Skip con Escape | US-004 | Chrome | ⬜ |
| 9 | Skip con tap/click | US-004 | Chrome | ⬜ |
| 10 | prefers-reduced-motion → estático | US-005 | Chrome | ⬜ |
| 11 | <noscript> funcional | US-006 | Chrome | ⬜ |
| 12 | initAudio() sin errores | US-007 | Chrome | ⬜ |
| 13 | Responsive 320px | US-008 | Chrome | ⬜ |
| 14 | Responsive 768px | US-008 | Chrome | ⬜ |
| 15 | Portal no disponible → overlay | US-003 | Chrome | ⬜ |
| 16 | Repetir #1-#8 en Firefox | ALL | Firefox | ⬜ |
| 17 | Repetir #1-#8 en Edge | ALL | Edge | ⬜ |
| 18 | Sin errores de consola (flujo feliz) | ALL | Todos | ⬜ |
| 19 | Archivos existentes no modificados | — | — | ⬜ |

---

## Notas de Prototipo

[PROTO: cobertura mínima — 10 test cases manuales mapeados a los 10 ACs del requirements.md. 3 escenarios BDD de los 12 definidos en user-stories.md. Sin tests automatizados ni unitarios. Sin E2E. Sin mutation testing. Framework: ninguno (validación manual en navegador). Umbrales de cobertura no aplican en prototipo. En versión beta: migrar a Jest + jsdom, 80% statements, 70% branches, 90% functions.]

---

**STATUS: COMPLETE**  
**NEXT: Generar budget.yaml + fastforward-complete.md**

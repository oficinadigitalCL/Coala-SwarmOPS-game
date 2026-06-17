# User Stories — Forja Intermedia: Bug Fix + Guía Didáctica

**Slug:** `coala-forja-guide-fix`  
**Feature:** Parte 1 de 3 — Mejora de flujo de entrada y guía didáctica  
**Modo:** PROTOTIPO 🚀  
**Stack:** HTML5 + CSS3 + Vanilla JavaScript (single-file, cero dependencias)  
**Audiencia:** Niños y jóvenes 10–14 años  
**Archivo objetivo:** [`game_intermediate/index.html`](../../game_intermediate/index.html:1)  

---

## Tabla de Contenidos

1. [Historias de Usuario](#historias-de-usuario)
2. [Criterios EARS](#criterios-ears)
3. [Edge Cases](#edge-cases)
4. [BDD / Gherkin](#bdd--gherkin)
5. [Definition of Done (DoD)](#definition-of-done-dod)
6. [Anti-Duplicate Check](#anti-duplicate-check)

---

## Historias de Usuario

### US-001 — Modo Demo/Guiado sin progreso previo del Templo

> **Como** niño de 10–14 años que llega por primera vez a La Forja,  
> **quiero** poder entrar al juego aunque no haya completado el Templo de Thot Nivel 5,  
> **para que** no me quede bloqueado ni frustrado al inicio.

**Contexto técnico:**  
Actualmente [`goToDashboard()`](../../game_intermediate/index.html:380) verifica `FORGE_STATE.templeLevel5Complete`. Si es `false`, muestra un `toast` bloqueante y reemplaza el botón de entrada por un link al Templo. No existe camino alternativo.

**Criterios de Aceptación:**
- [ ] Si `localStorage['coala_v3_progress']` existe y contiene el Nivel 5 desbloqueado → flujo normal (acceso directo a Dashboard).
- [ ] Si NO existe progreso del Templo → la pantalla de bienvenida ofrece **dos opciones**: (a) "Ver instrucciones" y (b) "Jugar modo demo".
- [ ] El "modo demo" permite jugar la Forja completa sin necesidad de progreso previo, pero marca el estado como `demo: true` en `FORGE_STATE`.
- [ ] Al finalizar el modo demo, el certificado indica "Modo Demo — Completa el Templo para obtener el certificado oficial".
- [ ] El progreso del modo demo se guarda en `localStorage` bajo la misma clave `coala_forge_progress`, con flag `demo: true`.

---

### US-002 — Pantalla de instrucciones "¿Cómo se juega?"

> **Como** niño de 10–14 años,  
> **quiero** ver una pantalla con íconos grandes que me explique cómo armar mi espacio de juego (PC con VS Code + Zoo Code, y tablet/celular como segunda pantalla),  
> **para que** pueda entender solo qué necesito sin ayuda de un adulto.

**Criterios de Aceptación:**
- [ ] Pantalla accesible desde la bienvenida vía botón "📖 ¿Cómo se juega?".
- [ ] Diseño visual con 3 bloques verticales (mobile) / 3 columnas (desktop ≥600px).
- [ ] Bloque 1 — 🖥️ "Tu PC": ícono grande de computadora + texto "Abrí VS Code y cargá la carpeta `game_intermediate/seed/`".
- [ ] Bloque 2 — 🤖 "Zoo Code": ícono grande de robot + texto "En Zoo Code usá los robots para reparar el código".
- [ ] Bloque 3 — 📱 "Tu celu o tablet": ícono grande de celular + texto "Abrí esta página en tu celular para ver el juego mientras codeás".
- [ ] Botón "⬅️ Volver" y botón "🚀 Empezar" al pie.
- [ ] Animación `fadeSlideIn` al entrar (reutilizar existente).
- [ ] Tipografía `clamp()` para legibilidad en tablets.

---

### US-003 — Pantalla de instrucciones "Tu misión"

> **Como** niño de 10–14 años,  
> **quiero** ver una pantalla que me explique de forma simple cuál es mi objetivo en el juego,  
> **para que** sepa qué debo lograr antes de empezar.

**Criterios de Aceptación:**
- [ ] Pantalla accesible desde la bienvenida o como paso 2 después de "¿Cómo se juega?".
- [ ] Tono narrativo amigable: "Los robots están dormidos 💤 ¡Despertalos uno por uno!"
- [ ] Visualización del Artefacto Roto: grid de 5 celdas con íconos, mostrando 2 ✅ y 3 🔧 (estado inicial).
- [ ] Texto explicativo máximo 3 líneas: "Repará las 5 pantallas del Artefacto. Cada robot te enseña algo nuevo. ¡Vos podés!"
- [ ] Botón "🚀 Empezar misión" que lleva al Dashboard.
- [ ] En modo demo, esta pantalla se muestra automáticamente antes del Dashboard en la primera visita.

---

### US-004 — Bienvenida animada y amigable

> **Como** niño de 10–14 años,  
> **quiero** que la primera pantalla sea colorida, con animaciones llamativas y un botón grande y claro,  
> **para que** me sienta motivado y emocionado por jugar.

**Criterios de Aceptación:**
- [ ] Ícono de bienvenida animado (alternativa a 🦉 Thot: 🦉 + ⚙️ rotando suavemente, o pulso dorado).
- [ ] Título con efecto de brillo (`text-shadow` animado o estático con glow).
- [ ] Botón principal "🚀 Empezar" estilo `.btn-primary` con tamaño aumentado (`padding: 0.8rem 2rem`, `font-size: 1.1rem`).
- [ ] Botón secundario "📖 ¿Cómo se juega?" para acceder a las instrucciones.
- [ ] Fondo mantiene glyphs egipcios flotantes (`bg-glyphs`), sin cambios.
- [ ] Mensaje de bienvenida diferenciado:
  - Con progreso Templo: "Bienvenido, aprendiz. La Forja te espera."
  - Sin progreso Templo: "¡Hola! La Forja de Thot está abierta para todos. ¿Listo para construir?"
- [ ] `prefers-reduced-motion`: si el usuario lo solicita, las animaciones se reducen a transiciones instantáneas.

---

## Criterios EARS

EARS (Easy Approach to Requirements Syntax) aplicados a las historias críticas.

### EARS-001 — Comportamiento de entrada (goToDashboard)

```
WHILE el usuario hace clic en "Entrar a la Forja" o "Empezar"
  IF localStorage contiene progreso del Templo Nivel 5
    THEN mostrar Dashboard con progreso cargado
  ELSE IF el usuario seleccionó "Modo Demo"
    THEN activar flag demo=true y mostrar Dashboard
  ELSE
    THEN mostrar pantalla "Tu misión" (primera vez) o Dashboard (posterior)
```

### EARS-002 — Guardado de progreso

```
WHILE el usuario completa una misión de robot
  IF modo demo está activo
    THEN guardar progreso con flag demo=true en localStorage
  ELSE
    THEN guardar progreso normal en localStorage
  THE SYSTEM SHALL actualizar el artifact grid y progress bar
```

### EARS-003 — Accesibilidad de instrucciones

```
WHILE el usuario está en la pantalla de bienvenida
  IF hace clic en "¿Cómo se juega?"
    THEN mostrar screenInstructions con animación fadeSlideIn
  IF hace clic en "Tu misión"
    THEN mostrar screenMission con el artefacto en estado inicial
  IF hace clic en "Empezar"
    THEN ejecutar goToDashboard() según EARS-001
```

---

## Edge Cases

| # | Escenario | Comportamiento Esperado | Riesgo |
|---|-----------|------------------------|--------|
| EC-001 | `localStorage` está lleno o bloqueado (modo privado) | Guardado falla silenciosamente → `showToast()` advierte. El juego sigue funcionando en memoria. | Bajo |
| EC-002 | Usuario ya tiene progreso del Templo pero también tiene progreso demo previo | El progreso real del Templo tiene **prioridad**. Se ignora el flag demo previo. | Medio |
| EC-003 | Usuario recarga la página en medio del modo demo | `loadState()` recupera el progreso demo. El flag `demo: true` persiste. | Bajo |
| EC-004 | Usuario navega directamente a `game_intermediate/index.html` desde URL sin pasar por Templo | Se detecta ausencia de `coala_v3_progress` → flujo modo demo automático. | Bajo |
| EC-005 | `localStorage['coala_v3_progress']` existe pero está corrupto (JSON inválido) | `checkTempleLevel5()` retorna `false` (try/catch ya existente). Flujo modo demo. | Bajo |
| EC-006 | Pantalla muy pequeña (< 320px de ancho) | Layout se adapta a una sola columna, íconos reducen a `font-size: 2.5rem`, texto a `0.8rem`. | Bajo |
| EC-007 | Usuario activa `prefers-reduced-motion` | Todas las animaciones CSS se desactivan vía `@media (prefers-reduced-motion: reduce)` ya existente. | Bajo |
| EC-008 | Usuario hace clic repetidamente en "Empezar" | Debounce implícito: `switchScreen()` solo cambia si el target screen existe. Sin efectos secundarios duplicados. | Bajo |

---

## BDD / Gherkin

### Escenario 1: Usuario sin progreso del Templo

```gherkin
Feature: Acceso a La Forja sin progreso previo del Templo

  Background:
    Given el usuario abre "game_intermediate/index.html"
    And localStorage no contiene "coala_v3_progress"

  Scenario: Primera visita — flujo guiado
    When la página carga
    Then ve la pantalla de bienvenida con el mensaje "¡Hola! La Forja de Thot está abierta para todos"
    And ve el botón "📖 ¿Cómo se juega?"
    And ve el botón "🚀 Empezar"

  Scenario: Ver instrucciones
    Given el usuario está en la pantalla de bienvenida
    When hace clic en "📖 ¿Cómo se juega?"
    Then aparece la pantalla "¿Cómo se juega?" con 3 bloques: PC, Zoo Code, Celular/Tablet
    And cada bloque tiene un ícono grande ≥ 2.5rem
    When hace clic en "🚀 Empezar"
    Then aparece la pantalla "Tu misión" mostrando el Artefacto con 2 ✅ y 3 🔧
    When hace clic en "🚀 Empezar misión"
    Then aparece el Dashboard con el Robot Constructor disponible
    And FORGE_STATE.demo es true
```

### Escenario 2: Usuario con progreso del Templo Nivel 5

```gherkin
Feature: Acceso normal con progreso previo

  Background:
    Given el usuario completó el Templo Nivel 5
    And localStorage "coala_v3_progress" contiene "unlocked": [5]

  Scenario: Acceso directo
    When la página carga
    Then ve la pantalla de bienvenida con "Bienvenido, aprendiz. La Forja te espera."
    And ve el botón "🔧 Entrar a la Forja"
    When hace clic en "Entrar a la Forja"
    Then aparece el Dashboard directamente
    And FORGE_STATE.templeLevel5Complete es true
    And no se muestra la pantalla "Tu misión" automáticamente
```

### Escenario 3: Progreso demo persistente

```gherkin
Feature: Persistencia del modo demo

  Scenario: Recarga de página en modo demo
    Given el usuario jugó en modo demo y completó el Robot Constructor
    And localStorage "coala_forge_progress" contiene "demo": true y "robots.constructor": "completed"
    When recarga la página
    Then aparece un toast "¡Bienvenido de vuelta! Continuamos donde quedaste."
    And el Dashboard muestra el Robot Constructor como completado
    And el progress bar indica 25%
```

---

## Definition of Done (DoD)

### DoD General (Prototipo)

- [ ] Código en un único archivo [`game_intermediate/index.html`](../../game_intermediate/index.html:1) (sin dependencias externas).
- [ ] CSS reutiliza las custom properties existentes (`--gold`, `--night`, `--font-title`, etc.).
- [ ] JavaScript es vanilla, compatible con ES2018+ (Chrome 80+, Safari 13+, Firefox 75+).
- [ ] Responsive: probado en viewport 320px, 375px, 768px y 1024px.
- [ ] `prefers-reduced-motion` respeta la accesibilidad.
- [ ] `<noscript>` mantiene mensaje amigable existente.
- [ ] No se rompe el state machine ni el localStorage existente.
- [ ] Web Audio API mantiene fallback silencioso (`try/catch`).

### DoD Específico de esta Feature

- [ ] **US-001**: `goToDashboard()` ya no bloquea a usuarios sin Templo Nivel 5.
- [ ] **US-001**: El flag `demo` se guarda y recupera correctamente en `localStorage`.
- [ ] **US-002**: La pantalla "¿Cómo se juega?" renderiza correctamente en mobile y desktop.
- [ ] **US-003**: La pantalla "Tu misión" muestra el artefacto en estado inicial (2/5 reparado).
- [ ] **US-004**: La bienvenida tiene al menos 2 elementos visuales animados (icono + botón glow).
- [ ] **Todos los edge cases EC-001 a EC-008** están manejados o documentados como aceptables.
- [ ] **BDD**: Los 3 escenarios Gherkin pueden verificarse manualmente en un navegador.
- [ ] **No regression**: El flujo completo del modo normal (con Templo Nivel 5) sigue funcionando igual que antes.

---

## Anti-Duplicate Check

| Feature existente | ¿Duplicado? | Notas |
|-------------------|-------------|-------|
| `coala-forja-intermediate` (HUB completo) | **Parcial** | Esta feature es una **mejora** sobre el HUB existente. No reemplaza el artefacto ni los robots. |
| `game_intermediate/seed/index.html` (Artefacto Roto) | No | Ese archivo es el "nivel" que se edita con VS Code; esta feature mejora el HUB que lo contiene. |
| `index.html` (Templo raíz) | No | El Templo es un nivel separado; esta feature lo desacopla opcionalmente. |
| `custom_modes_v6.0_edu.yaml` | No | Es configuración de Zoo Code; no afecta el HUB HTML. |

**Veredicto:** No hay duplicado. Es una mejora incremental (enhancement) sobre `coala-forja-intermediate`.

---

**STATUS: ENRICHED ✓**  
**OUTPUT_FILE:** `docs/specs/coala-forja-guide-fix/user-stories.md`

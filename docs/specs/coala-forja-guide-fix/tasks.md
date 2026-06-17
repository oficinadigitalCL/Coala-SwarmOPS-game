# Tasks — Forja Intermedia: Bug Fix + Guía Didáctica

## Metadata

| Campo | Valor |
|---|---|
| **Feature ID** | FEAT-002 |
| **Slug** | `coala-forja-guide-fix` |
| **Pipeline Mode** | PROTOTIPO 🚀 |
| **Stack** | HTML5 + CSS3 + Vanilla JS, cero dependencias |
| **Archivo objetivo** | [`game_intermediate/index.html`](../../game_intermediate/index.html:1) (modificar, 644 líneas) |
| **Total Tareas** | 23 |
| **SO** | Windows 10 (PowerShell) |
| **Parte** | 1 de 3 |
| **Fecha** | 2026-06-17 |

---

## Resumen de Fases

| Fase | Tareas | IDs | Tipo |
|---|---|---|---|
| **Setup + State Machine** | 5 | T-001 a T-005 | Fundación |
| **Welcome Refactor** | 4 | T-006 a T-009 | UI + Lógica |
| **Screen Instructions** | 4 | T-010 a T-013 | Nueva pantalla |
| **Screen Mission** | 4 | T-014 a T-017 | Nueva pantalla |
| **Victory + Certificate** | 2 | T-018 a T-019 | Condicional demo |
| **Polish + Regression** | 4 | T-020 a T-023 | Verificación |

---

## Tabla de Tareas

### Fase 1: State Machine Foundation (5 tareas)

| ID | Descripción | US | Est. | Criterio de Aceptación |
|---|---|---|---|---|
| **T-001** | Agregar campos `demo: false` y `firstVisit: true` al objeto [`FORGE_STATE`](../../game_intermediate/index.html:306). Insertar después de `score: 0` (línea 314), antes del `};`. No modificar campos existentes. | US-001 | S (5 min) | `console.log(FORGE_STATE.demo)` → `false`. `FORGE_STATE.firstVisit` → `true`. Sin errores de sintaxis. |
| **T-002** | Extender [`saveState()`](../../game_intermediate/index.html:330): agregar `demo: FORGE_STATE.demo` al objeto `data` (línea 332, después de `score`). El campo debe guardarse en `localStorage` bajo la key `coala_forge_progress`. | US-001 | S (5 min) | `localStorage['coala_forge_progress']` contiene `"demo":false` o `"demo":true` según corresponda. |
| **T-003** | Extender [`loadState()`](../../game_intermediate/index.html:337): restaurar `FORGE_STATE.demo = data.demo || false` y setear `FORGE_STATE.firstVisit = false` al cargar estado previo. Insertar después de `FORGE_STATE.score = data.score \|\| 0` (línea 346). | US-001 | S (5 min) | Recargar con progreso demo previo → `FORGE_STATE.demo === true` y `firstVisit === false`. |
| **T-004** | Verificar que [`checkTempleLevel5()`](../../game_intermediate/index.html:352) ya tiene `try/catch` robusto (líneas 353-358). No requiere cambios. Documentar en comentario: `// EC-005: JSON corrupto → retorna false, flujo demo`. | US-001 | S (2 min) | `checkTempleLevel5()` con `localStorage` vacío → `false`. Con `coala_v3_progress` corrupto → `false` sin excepción. |
| **T-005** | Refactorizar [`init()`](../../game_intermediate/index.html:626): reemplazar líneas 626-638 por nueva versión que (a) ejecuta `checkTempleLevel5()`, (b) ejecuta `loadState()`, (c) si hay progreso previo → `switchScreen('screenDashboard')` con toast, (d) si no → llama a `renderWelcome()` (función a crear en T-006). **Eliminar** el bloque que reemplaza `welcomeText`/`welcomeActions` con enlace al Templo (líneas 634-637). | US-001 | S (15 min) | Sin Templo Nivel 5: bienvenida muestra modo demo. Con Templo Nivel 5: bienvenida normal. Con progreso previo: va directo al Dashboard. |

### Fase 2: Welcome Refactor (4 tareas)

| ID | Descripción | US | Est. | Criterio de Aceptación |
|---|---|---|---|---|
| **T-006** | Crear función `renderWelcome()` (nueva, insertar después de `init()`). Lógica: si `FORGE_STATE.templeLevel5Complete === true` → `welcomeText` = mensaje existente ("Este juego fue construido por robots..."), `welcomeActions` = botón "🔧 Entrar a la Forja" con `onclick="goToDashboard()"`. Si `false` → mensaje "¡Hola! La Forja de Thot está abierta para todos..." + dos botones: "🚀 Empezar" (`btn-primary`) y "📖 ¿Cómo se juega?" (`btn-secondary`). También setear `welcomeTitle` = "Bienvenido, aprendiz" o "¡Hola, explorador!" según contexto. | US-001, US-004 | M (20 min) | Sin Templo: ver mensaje inclusivo y 2 botones. Con Templo: ver mensaje original y 1 botón "Entrar a la Forja". |
| **T-007** | Modificar [`goToDashboard()`](../../game_intermediate/index.html:380): reemplazar líneas 380-386. Nueva lógica: (a) `playClick()`, (b) si `templeLevel5Complete` → `switchScreen('screenDashboard')` y `return`, (c) setear `FORGE_STATE.demo = true`, (d) si `firstVisit` → setear `firstVisit = false`, mostrar toast "🎮 Modo demo", `switchScreen('screenMission')`, (e) else → `switchScreen('screenDashboard')`. | US-001 | M (20 min) | Con Templo Nivel 5: acceso directo a Dashboard. Sin Templo + primera visita: va a "Tu misión". Sin Templo + visita posterior: va directo a Dashboard. |
| **T-008** | Actualizar HTML del [`#screenWelcome`](../../game_intermediate/index.html:129): agregar `id="welcomeTitle"` al `<h2>` (línea 132). Dejar `id="welcomeText"` y `id="welcomeActions"` existentes. Eliminar contenido hardcodeado de `welcomeText` y `welcomeActions` (se renderizan dinámicamente desde `renderWelcome()`). | US-004 | S (5 min) | Los 3 elementos (`welcomeTitle`, `welcomeText`, `welcomeActions`) tienen `id` y están vacíos o con placeholder. |
| **T-009** | Agregar CSS para bienvenida mejorada: [`.welcome-title`](../../game_intermediate/index.html:37) agrega `text-shadow: 0 0 14px rgba(244,197,66,0.3)`. [`.btn-primary`](../../game_intermediate/index.html:31) cambia `padding: 0.8rem 2rem` y `font-size: 1.1rem`. El `.thot-icon` y `@keyframes thotGlow` ya existen (líneas 36-37), no modificar. | US-004 | S (10 min) | Título con glow dorado visible. Botón primario visiblemente más grande. Ícono animado intacto. `prefers-reduced-motion` desactiva glow (ya cubierto por regla línea 98). |

### Fase 3: Screen Instructions (4 tareas)

| ID | Descripción | US | Est. | Criterio de Aceptación |
|---|---|---|---|---|
| **T-010** | Agregar HTML de [`#screenInstructions`](../../game_intermediate/index.html:144) (nueva pantalla, insertar después de `</div>` de `#screenWelcome`, línea 141). Estructura: `<div class="screen" id="screenInstructions">` con `.card.welcome-content`, `<h2>📖 ¿Cómo se juega?</h2>`, párrafo intro, contenedor `.instruction-blocks` con 3 `.instruction-block`. Cada bloque: ícono (`🖥️` / `🤖` / `📱`), `<h3>`, `<p>`. Botones: "🚀 Empezar" (`btn-primary`, `onclick="goToDashboard()"`) y "⬅️ Volver" (`btn-secondary`, `onclick="switchScreen('screenWelcome')"`). | US-002 | M (20 min) | Pantalla existe en DOM. 3 bloques con íconos ≥2.5rem. Botones funcionales (cambian de pantalla). |
| **T-011** | Agregar CSS para bloques de instrucciones en `<style>`: [`.instruction-blocks`](../../game_intermediate/index.html:39) (`display:flex; flex-direction:column; gap:0.6rem`), [`.instruction-block`](../../game_intermediate/index.html:45) (fondo semitransparente, borde dorado sutil, `border-radius: var(--radius)`, `animation: fadeSlideIn 0.4s ease both`), `.instruction-icon` (`font-size: 2.5rem`), `.instruction-block h3` (`font-family: var(--font-title); color: var(--gold-bright)`), `.instruction-block p` (`font-size: 0.75rem; color: var(--sand)`). Media query `@media(min-width:600px)` para 3 columnas (`flex-direction: row`). | US-002 | M (15 min) | Mobile (<600px): 3 bloques en columna. Desktop (≥600px): 3 bloques en fila. Animación fadeSlideIn al aparecer. |
| **T-012** | Agregar `animation-delay` escalonado inline en cada `.instruction-block`: bloque 1 → `0.1s`, bloque 2 → `0.2s`, bloque 3 → `0.3s`. Usar atributo `style="animation-delay:0.Xs"` en el HTML (no requiere CSS extra). | US-002 | S (5 min) | Los 3 bloques aparecen secuencialmente con 100ms de diferencia al navegar a `screenInstructions`. |
| **T-013** | Verificar que [`switchScreen()`](../../game_intermediate/index.html:362) maneja `screenInstructions` sin modificaciones: `screenInstructions` no tiene lógica especial en el `if` cascade (líneas 367-369), solo necesita el `classList.add('active')` genérico. No requiere cambios en JS. | US-002 | S (5 min) | `switchScreen('screenInstructions')` muestra la pantalla, oculta las demás. Sin errores de consola. |

### Fase 4: Screen Mission (4 tareas)

| ID | Descripción | US | Est. | Criterio de Aceptación |
|---|---|---|---|---|
| **T-014** | Agregar HTML de [`#screenMission`](../../game_intermediate/index.html:174) (nueva pantalla, insertar después de `#screenInstructions`). Estructura: `<div class="screen" id="screenMission">` con `.card.welcome-content`, `<h2>🎯 Tu misión</h2>`, emoji `💤` grande (`font-size:3rem`), párrafo narrativo ("Los robots están dormidos..."), grid `.artifact-grid#missionArtifactGrid` vacío (se llena dinámicamente), texto "2 de 5 pantallas funcionan", botones "🚀 Empezar misión" (`btn-primary`, `onclick="goToDashboard()"`) y "⬅️ Volver". | US-003 | M (15 min) | Pantalla existe en DOM. Grid del artefacto visible. Botones funcionales. |
| **T-015** | Crear función `renderMissionArtifact()` (nueva, ~15 líneas). Renderiza 5 celdas en `#missionArtifactGrid` usando las mismas clases [`.artifact-cell`](../../game_intermediate/index.html:52) `.ok` / `.broken`. Datos: `['Bienvenida','Nivel 1','Nivel 2','Nivel 3','Victoria']` con íconos `['🏺','🧩','🔧','🧪','🏆']`. Celdas 1-2: clase `ok`, ícono ✅. Celdas 3-5: clase `broken`, ícono 🔧. Insertar función después de `renderWelcome()`. | US-003 | M (20 min) | Grid muestra 2 celdas verdes (✅) y 3 grises (🔧). Consistente con el estado inicial de `FORGE_STATE.artifact`. |
| **T-016** | Extender [`switchScreen()`](../../game_intermediate/index.html:362): agregar condición `if(id==='screenMission') renderMissionArtifact()` en el cascade (después de la línea 369). Esto asegura que el grid se renderice cada vez que se navega a la pantalla (necesario porque `innerHTML` se regenera). | US-003 | S (5 min) | `switchScreen('screenMission')` muestra el artefacto en estado inicial. Sin errores de consola. |
| **T-017** | Verificar que el botón "🚀 Empezar misión" en `#screenMission` ejecuta `goToDashboard()` y que esta función (refactorizada en T-007) setea `FORGE_STATE.demo = true` antes de ir al Dashboard. En modo demo primera visita, `goToDashboard()` ya fue llamado desde la bienvenida y `demo` ya es `true`; al llamarse de nuevo desde "Tu misión", `firstVisit` ya es `false`, por lo que va directo al Dashboard. | US-003, US-001 | S (5 min) | Flujo completo: Bienvenida → "Empezar" → Misión → "Empezar misión" → Dashboard con `FORGE_STATE.demo === true`. |

### Fase 5: Victory + Certificate (2 tareas)

| ID | Descripción | US | Est. | Criterio de Aceptación |
|---|---|---|---|---|
| **T-018** | Modificar [`showCertificate()`](../../game_intermediate/index.html:607): agregar condicional después de `document.getElementById('certDate').textContent = ...`. Si `FORGE_STATE.demo === true`: cambiar `h3` de `#certificateView` a "🎮 Certificado — Modo Demo", cambiar nombre del aprendiz a "Explorador de la Forja", y agregar párrafo "<em>Completa el Templo de Thot para obtener el certificado oficial.</em>". Si `demo === false`: comportamiento existente sin cambios. | US-001 | M (15 min) | Modo demo: certificado dice "Modo Demo". Modo normal: certificado dice "Aprendiz de la Forja" (sin cambios). |
| **T-019** | Verificar que [`finalizeMission()`](../../game_intermediate/index.html:573) y [`resetGame()`](../../game_intermediate/index.html:617) funcionan correctamente con el flag `demo`. `finalizeMission()` no necesita cambios (ya llama a `switchScreen('screenVictory')`). `resetGame()` ya preserva `templeLevel5Complete` (línea 619); verificar que también preserva `demo: false` en el nuevo estado (el objeto literal en línea 619 ya no incluye `demo` ni `firstVisit` → se pierden, lo cual es correcto: reset limpia el modo demo). | US-001 | S (10 min) | Reset en modo demo → `FORGE_STATE.demo` vuelve a `false`. El usuario ve la bienvenida limpia de nuevo. |

### Fase 6: Polish + Regression (4 tareas)

| ID | Descripción | US | Est. | Criterio de Aceptación |
|---|---|---|---|---|
| **T-020** | Agregar manejo de edge case EC-001 (localStorage lleno/bloqueado): [`saveState()`](../../game_intermediate/index.html:330) ya tiene `try/catch` con toast "⚠️ Tu progreso no se guardará entre sesiones." (línea 335). Verificar que el toast se muestra. Si `saveState()` falla, `FORGE_STATE.demo` permanece en RAM y el juego continúa. No requiere cambios de código. | EC-001 | S (5 min) | Navegador en modo incógnito con localStorage bloqueado: toast visible, juego funcional. |
| **T-021** | Agregar manejo de edge case EC-002 (recarga en medio de modo demo): [`loadState()`](../../game_intermediate/index.html:337) ya restaura `FORGE_STATE.demo` (T-003). [`init()`](../../game_intermediate/index.html:626) ya muestra toast "¡Bienvenido de vuelta!" y va al Dashboard si hay progreso (T-005). Verificar el flujo completo: abrir en modo demo → completar Robot Constructor → recargar → ver Dashboard con 25% y Robot Constructor completado. | EC-002, EC-003 | M (10 min) | Recarga preserva progreso demo. Toast de bienvenida de vuelta visible. Flag `demo: true` persiste en localStorage. |
| **T-022** | **Prueba de no regresión**: verificar flujo normal con Templo Nivel 5. Simular `localStorage.setItem('coala_v3_progress', '{"unlocked":[1,2,3,4,5]}')` en consola, recargar. Verificar: (a) bienvenida muestra "Bienvenido, aprendiz", (b) botón "🔧 Entrar a la Forja" visible, (c) NO aparece botón "📖 ¿Cómo se juega?", (d) click en "Entrar" → Dashboard, (e) `FORGE_STATE.demo === false`, (f) completar todas las misiones → certificado normal. | US-001, US-004 | M (15 min) | Cero regresiones. El flujo normal es idéntico al comportamiento pre-feature. |
| **T-023** | Polish final: verificar responsive en viewport 320px, 375px, 768px, 1024px. Verificar `<noscript>` (línea 104) intacto. Verificar `prefers-reduced-motion` (línea 98) desactiva animaciones. Verificar cero errores de consola en todos los flujos. Verificar touch targets ≥44px en botones mobile. Probar en Chrome y Firefox. | US-002, US-004 | M (20 min) | Todos los viewports funcionales. Sin errores de consola. Animaciones respetan `prefers-reduced-motion`. |

---

## Mapeo Completo Tareas → Historias de Usuario

| US | Descripción | Tareas |
|---|---|---|
| **US-001** | Modo Demo sin progreso previo | T-001, T-002, T-003, T-004, T-005, T-006, T-007, T-017, T-018, T-019, T-021, T-022 |
| **US-002** | Pantalla "¿Cómo se juega?" | T-010, T-011, T-012, T-013, T-023 |
| **US-003** | Pantalla "Tu misión" | T-014, T-015, T-016, T-017 |
| **US-004** | Bienvenida animada | T-006, T-008, T-009, T-022 |
| **EC-001** | localStorage bloqueado | T-020 |
| **EC-002** | Recarga en modo demo | T-021 |

---

## Orden de Ejecución Recomendado

```
T-001 → T-002 → T-003 → T-004 → T-005   (State Machine)
  ↓
T-006 → T-007 → T-008 → T-009            (Welcome Refactor)
  ↓
T-010 → T-011 → T-012 → T-013            (Instructions Screen)
  ↓
T-014 → T-015 → T-016 → T-017            (Mission Screen)
  ↓
T-018 → T-019                            (Victory + Certificate)
  ↓
T-020 → T-021 → T-022 → T-023            (Polish + Regression)
```

---

## Notas de Implementación

- **Archivo único:** toda modificación es en [`game_intermediate/index.html`](../../game_intermediate/index.html:1).
- **Sin dependencias:** no se requiere `npm install`, ni build step, ni servidor. Abrir el archivo directamente en el navegador.
- **Sin tocar:** [`index.html`](../../index.html) raíz, [`game_intermediate/seed/index.html`](../../game_intermediate/seed/index.html), [`game_beginner/`](../../game_beginner/), [`game_advanced/`](../../game_advanced/), [`custom_modes_v6.0_edu.yaml`](../../custom_modes_v6.0_edu.yaml).
- **Custom properties:** reutilizar todas las variables CSS existentes de [`:root`](../../game_intermediate/index.html:9). No crear nuevas variables a menos que sea estrictamente necesario.
- **Estados de robot:** `'locked' | 'dormant' | 'active' | 'completed'`. En modo demo, todos comienzan como `'locked'` (mismo comportamiento que modo normal).
- **Comandos Windows:** si se requiere copia de seguridad, usar `Copy-Item game_intermediate\index.html game_intermediate\index.html.bak`.

---

[PROTO: 23 tareas atómicas para prototipo. Las tareas están diseñadas para modificar un solo archivo sin romper el HUB existente. Cada tarea tiene un criterio de aceptación verificable manualmente en el navegador. En versión beta/producción se expandiría a 64+ tareas con tests unitarios, E2E, y mutation testing.]

**STATUS: DRAFT ✓**
**OUTPUT_FILE:** `docs/specs/coala-forja-guide-fix/tasks.md`

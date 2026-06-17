# Tasks — COALA: El Portal del Código

## Metadata

| Campo | Valor |
|---|---|
| **Feature ID** | FEAT-003 |
| **Slug** | `coala-forja-matrix` |
| **Pipeline Mode** | PROTOTIPO 🚀 |
| **Stack** | HTML5 + CSS3 + Vanilla JS (Canvas 2D), cero dependencias |
| **Total Tareas** | 24 |
| **Fecha** | 2026-06-17 |

---

## Resumen de Fases

| Fase | Tareas | IDs | Tipo |
|---|---|---|---|
| **Setup** | 4 | T001–T004 | Infraestructura |
| **Core — Canvas Matrix Rain** | 5 | T005–T009 | Feature |
| **Core — UI & Mensaje** | 4 | T010–T013 | Feature |
| **Core — Botón & Redirección** | 3 | T014–T016 | Feature |
| **Core — Skip & Accesibilidad** | 4 | T017–T020 | Feature |
| **Output — Polish & Test** | 4 | T021–T024 | Cross-cutting |

---

## Tabla de Tareas

### Fase 1: Setup (4 tareas)

| ID | Descripción | US | Estimación | Criterio de Aceptación |
|---|---|---|---|---|
| **T001** | Crear archivo `game_intermediate/matrix.html` con esqueleto HTML5 mínimo: `<!DOCTYPE html>`, `<html lang="es">`, `<meta charset="UTF-8">`, `<meta name="viewport" content="width=device-width, initial-scale=1.0">`, `<title>El Portal del Código — COALA</title>`, `<style>` vacío, `<script>` vacío. No modificar ningún archivo existente. | — | S (10 min) | Archivo abre en navegador sin errores. Pestaña muestra título correcto. |
| **T002** | Agregar `<noscript>` con mensaje amigable en español para niños y enlace directo a `../game_advanced/index.html`. Estilo inline en el `<noscript>`: fondo `#0a0a0f`, texto `#d4a843`, mensaje explicativo, botón-enlace estilizado. | US-006 | S (15 min) | Al deshabilitar JS en DevTools → se ve el `<noscript>` completo con enlace funcional. |
| **T003** | Definir CSS custom properties en `:root` dentro de `<style>`: `--night: #0a0a0f`, `--gold: #d4a843`, `--matrix-green: #00ff41`, `--gold-glow: rgba(212,168,67,0.6)`, `--green-glow: rgba(0,255,65,0.5)`, `--font-matrix`, `--font-message`, `--font-ui`. Agregar reset básico (`*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}`) y `body{background:var(--night);overflow:hidden}`. | US-001, US-008 | S (15 min) | Variables visibles en DevTools Computed. Body ocupa viewport completo sin scroll. |
| **T004** | Configurar media query `@media (prefers-reduced-motion: reduce)` que deshabilite animaciones: `*,*::before,*::after{animation-duration:0.01ms!important;animation-iteration-count:1!important;transition-duration:0.01ms!important}`. Agregar clase `.static-mode` para modo estático alternativo. | US-005 | S (10 min) | Activar `prefers-reduced-motion` en DevTools → animaciones se detienen. |

---

### Fase 2: Core — Canvas Matrix Rain (5 tareas)

| ID | Descripción | US | Estimación | Criterio de Aceptación |
|---|---|---|---|---|
| **T005** | Agregar `<canvas id="matrixCanvas">` al DOM. En `<script>`, implementar función `initCanvas()` que: obtiene el contexto 2D, ajusta `canvas.width/height = window.innerWidth/innerHeight`, y configura `fontSize` base = `clamp(12, window.innerWidth/40, 18)`. | US-001 | M (25 min) | Canvas ocupa todo el viewport. `fontSize` se escala correctamente en 320px, 768px, 1920px. |
| **T006** | Implementar `initDrops()`: calcula `columns = floor(canvas.width / fontSize)`, inicializa array `drops[]` con valores Y aleatorios (0 a `canvas.height/fontSize`). Cada columna tiene su propia velocidad (`fallSpeedMin=0.8`, `fallSpeedMax=2.5`). | US-001 | M (20 min) | Array `drops` tiene longitud = columnas. Valores Y aleatorios visibles en consola. |
| **T007** | Implementar conjunto de caracteres `MATRIX_CHARS`: mezcla de jeroglíficos Unicode (☥, 𓂀, ◈, ⬡), símbolos griegos (Φ, Ω, Ψ, Σ, Δ, Λ), katakana (ｱ-ｺ), números 0-9, letras A-F, y símbolos (!@#$%^&*()). Total ~40 caracteres. | US-001 | S (10 min) | Array contiene los caracteres definidos. Todos se renderizan sin □ (tofu) en Chrome/Firefox/Edge. |
| **T008** | Implementar loop de animación `draw(timestamp)` con `requestAnimationFrame`: (a) fondo semitransparente `rgba(10,10,15,0.05)` para trail effect, (b) por cada columna: seleccionar char aleatorio, calcular Y, dibujar con `fillText()`, (c) primer char de columna más brillante (blanco), (d) avanzar `drops[i]`, (e) reset aleatorio cuando Y > height. | US-001, US-005 | L (60 min) | Lluvia de caracteres visible y fluida a ~60fps. Trail effect perceptible. Sin errores de consola. |
| **T009** | Implementar transición de color dorado → verde: función `lerpColor(hexA, hexB, ratio)` con `easeInOutQuad`. `colorRatio = min(elapsed / 5000, 1.0)`. Cada frame, los caracteres nuevos usan color interpolado. Variable global `animStartTime` = `performance.now()` al iniciar. | US-001 | M (35 min) | Primeros segundos: solo caracteres dorados. Segundo 2-3: mezcla dorado/verde. Segundo 5+: solo verde neón. Gradiente visible, no abrupto. |

---

### Fase 3: Core — UI & Mensaje (4 tareas)

| ID | Descripción | US | Estimación | Criterio de Aceptación |
|---|---|---|---|---|
| **T010** | Crear overlay del mensaje: `<div id="messageOverlay" class="message-overlay">` con `<h1 class="matrix-message">El código verdadero te espera...</h1>`. CSS: `position:fixed`, centrado con `transform:translate(-50%,-50%)`, `z-index:10`, `pointer-events:none`. Texto con `font-family:var(--font-message)`, `color:var(--gold)`, `text-shadow:0 0 20px var(--gold-glow), 0 0 40px var(--gold-glow)`, `opacity:0`. | US-002 | M (20 min) | Overlay existe en DOM. Mensaje no visible inicialmente. Glow visible al activar. |
| **T011** | Implementar fade-in del mensaje con `setTimeout`: a los 1000ms, agregar clase `.visible` que aplica `opacity:1; transition:opacity 1s ease`. Si `prefers-reduced-motion`, hacerlo inmediato (0ms delay). | US-002, US-005 | S (15 min) | Esperar 1-2s → mensaje aparece con fade-in suave. Con reduced-motion → visible al instante. |
| **T012** | Agregar tipografía fluida al mensaje: `font-size: clamp(1.2rem, 4vw, 2.5rem)`. En pantallas < 360px, permitir que el texto haga wrap en 2 líneas (`max-width:90vw`). | US-008 | S (10 min) | En 320px: texto legible, posiblemente 2 líneas. En 768px+: texto grande en 1 línea. |
| **T013** | Ajustar `z-index` y `pointer-events` para que el mensaje no bloquee el skip (tap en Canvas). El overlay del mensaje debe tener `pointer-events:none`. | US-004 | S (5 min) | Tap en cualquier parte de la pantalla (incluso sobre el mensaje) dispara skip. |

---

### Fase 4: Core — Botón & Redirección (3 tareas)

| ID | Descripción | US | Estimación | Criterio de Aceptación |
|---|---|---|---|---|
| **T014** | Crear botón: `<button id="btnPortal" class="btn-portal">Cruzar el portal →</button>`. CSS: `position:fixed; bottom:15%; left:50%; transform:translateX(-50%); z-index:20`, `min-width:min(280px,80vw); min-height:48px`, `background:transparent; border:2px solid var(--gold); color:var(--gold); font-family:var(--font-matrix)`, `opacity:0; pointer-events:none`. Hover: `border-color:var(--matrix-green); color:var(--matrix-green); text-shadow:0 0 15px var(--green-glow)`. | US-003 | M (25 min) | Botón existe en DOM pero invisible. Estilo coincide con tema egipcio. Hover cambia a verde. |
| **T015** | Implementar aparición del botón a los 3s: `setTimeout(() => { btnPortal.style.opacity='1'; btnPortal.style.pointerEvents='auto'; btnPortal.style.transition='opacity 0.5s ease, transform 0.5s ease' }, 3000)`. Si `prefers-reduced-motion`, hacerlo inmediato. | US-003, US-005 | S (15 min) | Esperar 3s → botón visible. Clic funciona. Con reduced-motion → visible al instante. |
| **T016** | Implementar redirección con debounce: `btnPortal.addEventListener('click', () => { if (SCENE_STATE.redirectDebounce) return; SCENE_STATE.redirectDebounce = true; setTimeout(() => { SCENE_STATE.redirectDebounce = false }, 500); redirectToPortal() })`. Función `redirectToPortal()`: (a) `fetch('../game_advanced/index.html', {method:'HEAD'})`, (b) si 200 → `window.location.href = '../game_advanced/index.html'`, (c) si error/404 → mostrar `#fallbackOverlay`. | US-003, US-010 | M (30 min) | Clics rápidos → solo 1 redirección. 404 → overlay fallback. 200 → redirección correcta. |

---

### Fase 5: Core — Skip & Accesibilidad (4 tareas)

| ID | Descripción | US | Estimación | Criterio de Aceptación |
|---|---|---|---|---|
| **T017** | Implementar skip con tecla `Escape`: `document.addEventListener('keydown', (e) => { if (e.key === 'Escape' && !SCENE_STATE.portalShown) { skipToPortal() } })`. `skipToPortal()`: cancela el `setTimeout` del botón, aplica fade-in rápido (200ms), activa `pointer-events`. | US-004 | S (15 min) | Presionar Escape antes de 3s → botón aparece inmediatamente con fade-in rápido. |
| **T018** | Implementar skip con tap/click: `canvas.addEventListener('click', () => { if (!SCENE_STATE.portalShown) { skipToPortal() } })`. Asegurar que el clic en el botón mismo no dispare el skip (usar `e.target` check). | US-004 | S (15 min) | Tap en cualquier parte de la pantalla (no botón) antes de 3s → botón aparece. |
| **T019** | Implementar modo estático (`staticMode`) para `prefers-reduced-motion`: usar `window.matchMedia('(prefers-reduced-motion: reduce)')`. Si active: (a) no iniciar `requestAnimationFrame`, (b) mostrar `fallbackGrid` con CSS grid de caracteres estáticos dorados/verdes, (c) mensaje y botón visibles inmediatamente. | US-005 | M (40 min) | Con reduced-motion: escena estática, mensaje y botón visibles al cargar, no hay animación. |
| **T020** | Implementar `fallbackGrid`: `<div id="fallbackGrid" class="fallback-grid">` con JS que genera ~60-100 celdas con caracteres aleatorios. 60% dorados, 40% verdes (simula transición estática). CSS: `display:grid; grid-template-columns:repeat(auto-fill,minmax(20px,1fr))`. | US-001, US-005 | M (25 min) | Fallback grid visible en reduced-motion o sin Canvas. Caracteres distribuidos sin solapamiento. |

---

### Fase 6: Output — Polish & Test (4 tareas)

| ID | Descripción | US | Estimación | Criterio de Aceptación |
|---|---|---|---|---|
| **T021** | Implementar `AudioWrapper`: función `initAudio()` que intenta `new AudioContext()` (con fallback `webkitAudioContext` para Safari). Todo dentro de `try/catch`. En catch: `console.log('🔇 Audio no disponible')`. Sin sonido audible en prototipo. Agregar comentario `// TODO: Implementar playPortalAmbient(), playTransitionChime()` | US-007 | S (15 min) | Sin errores de consola. `initAudio()` se llama al cargar. AudioContext se crea o falla silenciosamente. |
| **T022** | Implementar responsive adapter: función `handleResize()` que recalcula `canvas.width/height`, `fontSize`, y `columns`. Escuchar `window.addEventListener('resize', debounce(handleResize, 200))` y `orientationchange`. Re-inicializar `drops[]` al cambiar columnas. | US-008 | M (25 min) | Redimensionar ventana → Canvas se adapta. Rotar dispositivo móvil → lluvia se reajusta sin glitch. |
| **T023** | Agregar overlay de fallback (`#fallbackOverlay`) para cuando `game_advanced/index.html` no existe: diseño centrado con ícono 🏗️, mensaje "El portal se está construyendo... Vuelve pronto.", y botón "⬅️ Volver a La Forja" que redirige a `index.html`. CSS con fondo semitransparente `rgba(10,10,15,0.92)`. | US-003 | M (20 min) | Simular 404 del fetch → overlay visible. Botón "Volver a La Forja" redirige correctamente. |
| **T024** | Polish final: (a) testear en Chrome, Firefox, Edge (últimas 2 versiones), (b) verificar responsive ≥320px en DevTools device toolbar, (c) verificar `prefers-reduced-motion` en los 3 navegadores, (d) verificar `<noscript>` deshabilitando JS, (e) verificar cero errores de consola en flujo feliz, (f) verificar que `game_intermediate/index.html` y `game_intermediate/seed/index.html` no fueron modificados. | US-001, US-008 | M (35 min) | 3 navegadores OK. Mobile OK. Cero errores. `<noscript>` funcional. Archivos existentes intactos. |

---

## Mapeo Completo Tareas → Historias de Usuario

| US | Título | Tareas |
|---|---|---|
| **US-001** | Lluvia de caracteres transformándose | T003, T005, T006, T007, T008, T009, T020, T024 |
| **US-002** | Mensaje enigmático central | T010, T011, T012, T013 |
| **US-003** | Botón para cruzar el portal | T014, T015, T016, T023 |
| **US-004** | Saltar la escena (Skip) | T013, T017, T018 |
| **US-005** | Accesibilidad — movimiento reducido | T004, T011, T015, T019, T020 |
| **US-006** | Fallback sin JavaScript | T002 |
| **US-007** | Preparación para audio ambiental | T021 |
| **US-008** | Responsive multi-dispositivo | T003, T012, T022, T024 |

---

## Estimaciones Totales

| Fase | Tareas | Tiempo estimado |
|---|---|---|
| Setup | 4 | 50 min |
| Core — Canvas Matrix Rain | 5 | 2h 30min |
| Core — UI & Mensaje | 4 | 50 min |
| Core — Botón & Redirección | 3 | 1h 10min |
| Core — Skip & Accesibilidad | 4 | 1h 35min |
| Output — Polish & Test | 4 | 1h 35min |
| **Total** | **24** | **~8h 30min** |

---

## Notas de Prototipo

[PROTO: 24 tareas mínimas para funcionalidad demostrable. Sin tests automatizados (solo validación manual en T024). Sin CI/CD. Sin i18n. Sin sonido audible (solo estructura AudioContext). Sin Service Worker ni PWA. El Canvas 2D es la estrategia principal con fallback CSS grid mínimo. La detección de 404 usa `fetch` HEAD básico. En versión beta se expandiría a ~64 tareas con tests unitarios, animación de salida, y polling real del destino.]

---

**STATUS: COMPLETE**  
**NEXT: Generar testing.md y budget.yaml**

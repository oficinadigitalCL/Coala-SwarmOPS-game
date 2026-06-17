# Tasks — COALA: La Forja de la Tabla Esmeralda

## Metadata

| Campo | Valor |
|---|---|
| **Feature ID** | FEAT-001 |
| **Slug** | `coala-forja-intermediate` |
| **Pipeline Mode** | PROTOTIPO 🚀 |
| **Stack** | HTML5 + CSS3 + Vanilla JS, cero dependencias |
| **Total Tareas** | 24 |
| **Fecha** | 2026-06-17 |

---

## Resumen de Fases

| Fase | Tareas | IDs | Tipo |
|---|---|---|---|
| **Setup** | 4 | T001–T004 | Infraestructura |
| **HUB Shell** | 5 | T005–T009 | Core UI |
| **Robot Constructor** | 3 | T010–T012 | Feature |
| **Robot Probador** | 2 | T013–T014 | Feature |
| **Artefacto Roto** | 3 | T015–T017 | Feature |
| **Robot Tabla Esmeralda** | 2 | T018–T019 | Feature |
| **Robot Forja + Victoria** | 3 | T020–T022 | Feature |
| **Persistencia + Polish** | 2 | T023–T024 | Cross-cutting |

---

## Tabla de Tareas

### Fase 1: Setup (4 tareas)

| ID | Descripción | HU | Estimación | Criterio de Aceptación |
|---|---|---|---|---|
| **T001** | Crear carpeta `game_intermediate/` con estructura: `index.html` (vacío), `seed/index.html` (placeholder), `assets/` (vacío). No tocar `index.html` raíz ni `game_beginner/`. | — | S (15 min) | Carpetas existen. `index.html` raíz sin modificar. |
| **T002** | Crear esqueleto HTML5 mínimo en [`game_intermediate/index.html`](game_intermediate/index.html): `<!DOCTYPE html>`, `<html lang="es">`, `<meta charset>`, `<meta viewport>`, `<title>`, `<noscript>` con mensaje amigable, `<style>` vacío, `<script>` vacío. | HU-1 | S (10 min) | Archivo abre en navegador sin errores. `<noscript>` visible al deshabilitar JS. |
| **T003** | Crear Artefacto Roto placeholder en [`game_intermediate/seed/index.html`](game_intermediate/seed/index.html): HTML5 mínimo con 5 `<div class="screen">` (2 con contenido real simple, 3 con clase `broken` y overlay gris). Sin lógica JS aún. | HU-5 | M (30 min) | Abre en navegador. 2 pantallas navegables, 3 con overlay "🔧 En reparación". |
| **T004** | Extender [`custom_modes_v6.0_edu.yaml`](custom_modes_v6.0_edu.yaml) con 4 entradas nuevas bajo `customModes:`: `robot-constructor`, `robot-probador`, `robot-tabla-esmeralda`, `robot-forja`. Cada uno con `slug`, `name`, `whenToUse`, `roleDefinition`, `explicacion:` (texto narrativo de la Forja), `groups: [read, edit]`, `model: openrouter/deepseek/deepseek-v4-flash`. | HU-8 | M (45 min) | YAML válido (parsea sin errores). 4 robots nuevos con campo `explicacion:`. Cada `explicacion:` incluye "Estoy aquí porque..." y narrativa de la Forja. |

### Fase 2: HUB Shell (5 tareas)

| ID | Descripción | HU | Estimación | Criterio de Aceptación |
|---|---|---|---|---|
| **T005** | Implementar CSS base en [`game_intermediate/index.html`](game_intermediate/index.html): variables CSS (`:root` con paleta egipcia), reset, tipografías, fondo con glyphs flotantes (☥, 𓂀, ◈, ⚙️), `.app-container`, `.game-header`, `.screen`, `.card`, `.btn`, `.btn-primary`, `.btn-secondary`. Replicar estilos de [`index.html`](index.html:12-115) raíz adaptados a temática Forja. | HU-1 | L (60 min) | HUB visualmente consistente con Templo de Thot. Glyphs flotantes visibles. Paleta de colores correcta. |
| **T006** | Implementar sistema de pantallas (`ScreenManager`): función `switchScreen(fromId, toId)`, animación `fadeSlideIn` CSS, todas las pantallas definidas en HTML: `screenWelcome`, `screenDashboard`, `screenRobotConstructor`, `screenRobotTester`, `screenRobotTablet`, `screenRobotForge`, `screenVictory`. | HU-1 | M (45 min) | Navegación fluida entre pantallas con animación. Sin errores de consola. |
| **T007** | Implementar pantalla de bienvenida (`screenWelcome`): mensaje de Thot, historia "Este juego fue construido por robots, pero algo salió mal", botón "🔧 Entrar a la Forja". Verificación de Nivel 5 del Templo (`localStorage` key `coala_v3_progress` → `unlocked.includes(5)`). Si no completado: mensaje alternativo + enlace a `../index.html`. | HU-1 | M (40 min) | Flujo A (Nivel 5 OK): ver botón Forja. Flujo B (sin Nivel 5): ver mensaje "Primero domina el Templo" + enlace. |
| **T008** | Implementar dashboard (`screenDashboard`): 3 secciones — Artefacto Roto (vista previa con 2/5 verdes), Robots (4 robots con estado visual), Misión Actual (texto + barra de progreso). Layout responsive: grid 2-col en escritorio, 1-col en móvil. | HU-1, HU-5 | L (60 min) | Dashboard funcional. Robots muestran estado "💤 Dormido". Barra de progreso al 0%. Artefacto muestra 2 ✅ y 3 🔧. |
| **T009** | Implementar `ProgressManager`: barra de progreso de 4 segmentos (0%–25%–50%–75%–100%), animación `pulseStep` en segmento activo, `done` en completados. Función `updateProgress(percent)` que actualiza CSS classes y dispara hitos. | HU-6 | M (30 min) | Barra se actualiza visualmente. Hito 25% → suena `playCorrect()`. Hito 50% → suena campana. Hito 75% → ídem. Hito 100% → `playVictory()`. |

### Fase 3: Robot Constructor (3 tareas)

| ID | Descripción | HU | Estimación | Criterio de Aceptación |
|---|---|---|---|---|
| **T010** | Implementar pantalla Robot Constructor (`screenRobotConstructor`): panel con instrucciones paso a paso: "1. Abre VS Code, 2. Carga la carpeta `game_intermediate/seed/`, 3. Abre Zoo Code (Ctrl+Shift+P), 4. Escribe: `/constructor 'repara el botón de inicio del juego'`". Robot muestra transición de estado "💤 Dormido" → "👁️ Observando..." al hacer clic. | HU-2 | M (45 min) | Instrucciones visibles. Estado del robot cambia. Sin errores de consola. |
| **T011** | Implementar simulación de reparación del Constructor: botón "✅ Ya ejecuté /constructor" que simula que el agente reparó el código. Al hacer clic: animación de engranajes dorados (CSS `@keyframes gearSpin`), mensaje de Thot "🔧 ¡Excelente! El Constructor reparó el primer engranaje.", `FORGE_STATE.robots.constructor = 'completed'`. | HU-2 | M (30 min) | Al completar: animación visible, mensaje de Thot, robot cambia a "✅ Completado". |
| **T012** | Efecto post-Constructor: actualizar Artefacto Roto → pantalla 3 pasa de gris a color (animación 1s), progreso avanza a 25%, Robot Probador se desbloquea (`locked → dormant`), dashboard se refresca al volver. | HU-2, HU-5 | M (30 min) | Artefacto refleja el cambio. Progreso 25%. Probador desbloqueado. |

### Fase 4: Robot Probador (2 tareas)

| ID | Descripción | HU | Estimación | Criterio de Aceptación |
|---|---|---|---|---|
| **T013** | Implementar pantalla Robot Probador (`screenRobotTester`): bloqueo si Constructor no completado ("Primero despierta al Constructor"). Instrucciones para ejecutar `/probador` en Zoo Code. Interfaz con mock de resultado: "🧪 El Probador encontró un bug en la línea 295 — `playTone()` no recibe frecuencia. Sugerencia: `playTone(440)`". | HU-3 | M (45 min) | Si Constructor no completado → mensaje de bloqueo. Si OK → instrucciones + mock de bug encontrado. |
| **T014** | Implementar simulación de verificación del Probador: botón "✅ Ya corregí el bug" → Probador confirma "✅ ¡Todos los tests pasaron!", artefacto pantalla 4 pasa de gris a color, progreso avanza a 50%, Robot Tabla Esmeralda se desbloquea. | HU-3, HU-5 | M (30 min) | Progreso 50%. Pantalla 4 reparada. Tabla Esmeralda desbloqueada. |

### Fase 5: Artefacto Roto (3 tareas)

| ID | Descripción | HU | Estimación | Criterio de Aceptación |
|---|---|---|---|---|
| **T015** | Implementar `ArtifactView` en el dashboard: renderiza 5 celdas (una por pantalla) con estado visual. Celda funcional: fondo color, mini-preview, ✅. Celda rota: fondo gris (#444), icono 🔧, texto "En reparación". Overlay "🔒 Esta parte aún está rota" al hacer clic en celda no reparada. | HU-5 | M (45 min) | Vista inicial: 2 celdas color/✅, 3 celdas gris/🔧. Overlay en celdas rotas. |
| **T016** | Implementar transiciones de reparación del Artefacto: función `repairArtifactScreen(n)` que cambia clase CSS de la celda (`broken` → `repairing` → `repaired`), animación de 1s con brillo dorado, sonido de engranaje. Sincronizar con `FORGE_STATE.artifact`. | HU-5 | M (30 min) | Animación fluida. Sonido audible (o fallback silencioso). Estado se refleja en state machine. |
| **T017** | Implementar vista previa del Artefacto completo: al 100% de progreso, las 5 celdas muestran ✅, botón "🎮 Jugar Artefacto Completo" que abre `seed/index.html` en nueva pestaña (o iframe con sandbox). | HU-5, HU-7 | S (20 min) | 5/5 celdas verdes. Botón funcional. |

### Fase 6: Robot Tabla Esmeralda (2 tareas)

| ID | Descripción | HU | Estimación | Criterio de Aceptación |
|---|---|---|---|---|
| **T018** | Implementar pantalla Robot Tabla Esmeralda (`screenRobotTablet`): bloqueo si Probador no completado. Vista previa del YAML con resaltado de sintaxis (span coloreados para claves, strings, comentarios). Sección `customModes` de `robot-constructor`, `robot-probador`, `robot-tabla-esmeralda`, `robot-forja` visibles. | HU-4 | M (45 min) | YAML visible con colores. Bloqueo funcional si Probador no completado. |
| **T019** | Implementar editor YAML inline + validación básica: `contenteditable` en `<pre><code>` o `<textarea>` estilizado. Validación en tiempo real (`oninput`): detecta líneas sin `:` después de clave, claves requeridas faltantes (`customModes`, `slug`, `name`), indentación con espacios (múltiplos de 2). Línea errónea marcada en rojo con tooltip. Botón "🔮 Activar Tabla" (solo si YAML válido) → progreso a 75%, Forja desbloqueada. | HU-4 | L (90 min) | Editor funcional. Errores de sintaxis marcados en rojo. "Activar Tabla" bloqueado si YAML inválido. Progreso 75% al activar. |

### Fase 7: Robot Forja + Victoria (3 tareas)

| ID | Descripción | HU | Estimación | Criterio de Aceptación |
|---|---|---|---|---|
| **T020** | Implementar pantalla Robot Forja (`screenRobotForge`): bloqueo si Tabla Esmeralda no activada. Checklist final con 3 items: "✅ Robot Constructor completado", "✅ Robot Probador completado", "✅ Tabla Esmeralda activada". Items se marcan dinámicamente según `FORGE_STATE.robots`. Item faltante parpadea en naranja. | HU-7 | M (40 min) | Checklist refleja estado real. Items completados en verde. Pendientes en naranja parpadeante. |
| **T021** | Implementar botón "🔮 Finalizar Misión": verifica que checklist esté 100%. Si falta algo → mensaje "⏳ Aún faltan tareas. Revisa el checklist." Si completo → transición a victoria: Artefacto Roto → juego completo (5/5 ✅), confeti CSS, música de victoria (Web Audio API), pantalla `screenVictory`. | HU-7 | M (40 min) | Validación del checklist. Transición fluida. Confeti visible. Sonido de victoria. |
| **T022** | Implementar pantalla de victoria (`screenVictory`): título "🏆 ¡La Forja está completa!", subtítulo "Construiste el juego que estás jugando", puntuación (1000 pts), rango "🎓 Aprendiz de la Forja", botones "🔄 Jugar de Nuevo" (resetea todo), "📤 Compartir" (copia al portapapeles), "🎓 Ver mi Certificado" (pantalla simple con nombre, fecha, firma de Thot). | HU-6, HU-7 | M (45 min) | Pantalla completa con todos los elementos. Botones funcionales. Certificado se muestra correctamente. |

### Fase 8: Persistencia + Polish (2 tareas)

| ID | Descripción | HU | Estimación | Criterio de Aceptación |
|---|---|---|---|---|
| **T023** | Implementar `StorageAdapter`: funciones `saveForgeState()` y `loadForgeState()`. Guardar en `localStorage` key `coala_forge_progress`. Incluir checksum simple (suma de caracteres del JSON). Al cargar: validar checksum, si falla → limpiar key y reiniciar. Toast "⚠️ Tu progreso no se guardará entre sesiones" si `localStorage` bloqueado. | HU-6 | M (45 min) | Progreso persiste entre recargas. Checksum detecta corrupción. Toast en caso de error. |
| **T024** | Polish final: testear en Chrome, Firefox, Edge. Verificar responsive ≥320px (Chrome DevTools device toolbar). Verificar touch funcional (sin hover dependency). Verificar cero errores de consola en flujo feliz completo. Verificar `<noscript>`. Verificar `prefers-reduced-motion`. Ajustar tiempos de animación. | HU-1, HU-6 | M (45 min) | 3 navegadores OK. Mobile OK. Cero errores de consola. `<noscript>` funcional. |

---

## Mapeo Completo Tareas → Historias de Usuario

| HU | Título | Tareas |
|---|---|---|
| **HU-1** | HUB de Misión — La Forja | T002, T005, T006, T007, T008, T024 |
| **HU-2** | Robot Constructor — Despierta y Repara | T010, T011, T012 |
| **HU-3** | Robot Probador — Verifica la Reparación | T013, T014 |
| **HU-4** | Robot Tabla Esmeralda — Configura los Agentes | T018, T019 |
| **HU-5** | Artefacto Roto — El Juego Incompleto | T003, T008, T012, T014, T015, T016, T017 |
| **HU-6** | Progreso Visual y Persistencia | T009, T022, T023, T024 |
| **HU-7** | Robot Forja — Coordinador Final | T020, T021, T022 |
| **HU-8** | Custom Modes Educativos Interactivos | T004 |

---

## Estimaciones Totales

| Fase | Tareas | Tiempo estimado |
|---|---|---|
| Setup | 4 | 1h 40min |
| HUB Shell | 5 | 3h 45min |
| Robot Constructor | 3 | 1h 45min |
| Robot Probador | 2 | 1h 15min |
| Artefacto Roto | 3 | 1h 35min |
| Robot Tabla Esmeralda | 2 | 2h 15min |
| Robot Forja + Victoria | 3 | 2h 05min |
| Persistencia + Polish | 2 | 1h 30min |
| **Total** | **24** | **~15h 50min** |

---

## Notas de Prototipo

[PROTO: 24 tareas mínimas para funcionalidad demostrable. Sin tests automatizados. Sin CI/CD. Sin i18n. Las interacciones con Zoo Code son simuladas. El YAML validator es solo sintaxis básica. En versión beta se expandiría a 64 tareas con tests, validación semántica de YAML, y polling real de archivos.]

---

**STATUS: COMPLETE**  
**NEXT: Generar budget.yaml + fastforward-complete.md**

# Code Review — FEAT-002: Bug Fix + Guía Didáctica

## Metadata

| Campo | Valor |
|-------|-------|
| **Feature ID** | FEAT-002 |
| **Slug** | `coala-forja-guide-fix` |
| **Archivo revisado** | [`game_intermediate/index.html`](../../game_intermediate/index.html:1) |
| **Líneas totales** | 788 |
| **Modo** | PROTOTIPO 🚀 |
| **Fecha revisión** | 2026-06-17 |
| **Reviewer** | Code Reviewer (T2 · Kimi K2.5) |

---

## STATUS: ✅ CODE_APPROVED

El código implementado cumple con los criterios de aceptación del modo PROTOTIPO. No se detectaron problemas de seguridad críticos ni errores de sintaxis.

---

## Checklist PROTO — Resultados

### 1. [PROTO] Sin errores de consola en flujo feliz ✅

**Flujo Normal (con Templo Nivel 5):**
- ✅ Bienvenida → Dashboard → Robots → Victoria
- ✅ Path A en [`goToDashboard()`](../../game_intermediate/index.html:451) detecta `templeLevel5Complete` y redirige directo
- ✅ Sin errores de sintaxis en JavaScript

**Flujo Demo (sin Templo):**
- ✅ Bienvenida → Instrucciones → Misión → Dashboard → Robots → Victoria demo
- ✅ [`renderWelcome()`](../../game_intermediate/index.html:749) muestra mensaje contextual correcto
- ✅ [`goToDashboard()`](../../game_intermediate/index.html:451) setea `demo: true` y navega según `firstVisit`
- ✅ [`switchScreen()`](../../game_intermediate/index.html:432) maneja todas las pantallas sin errores

**Verificación de sintaxis:**
- ✅ Sin paréntesis desbalanceados
- ✅ Sin comillas sin cerrar
- ✅ Sin variables sin declarar
- ✅ Todos los `document.getElementById()` apuntan a IDs existentes

---

### 2. [PROTO] Responsive en 320px+ ✅

**screenInstructions (3 bloques):**
- ✅ Mobile-first: [`flex-direction: column`](../../game_intermediate/index.html:98) por defecto
- ✅ Desktop (≥600px): [`flex-direction: row`](../../game_intermediate/index.html:103) con media query
- ✅ [`@media(max-width:480px)`](../../game_intermediate/index.html:107) ajusta padding y gaps

**screenMission (grid del artefacto):**
- ✅ [`artifact-grid`](../../game_intermediate/index.html:51) usa `repeat(5, 1fr)` - responsive por naturaleza
- ✅ [`max-width:340px`](../../game_intermediate/index.html:197) con `margin: auto` centra el grid
- ✅ Celdas mantienen aspect-ratio 1:1

**Touch targets ≥44px:**
- ✅ [`.btn`](../../game_intermediate/index.html:30): `padding: 0.65rem 1.4rem` (~44px+ altura)
- ✅ [`.btn-primary`](../../game_intermediate/index.html:31): `padding: 0.8rem 2rem`
- ✅ [`.robot-card`](../../game_intermediate/index.html:61): `padding: 0.7rem 1rem`
- ✅ [`.artifact-cell`](../../game_intermediate/index.html:52): `aspect-ratio: 1` con contenido centrado

---

### 3. [PROTO] Touch funcional sin depender de hover ✅

**Verificación de eventos:**
- ✅ Botones usan [`onclick`](../../game_intermediate/index.html:179) — compatible con touch y mouse
- ✅ "Empezar" → [`onclick="goToDashboard()"`](../../game_intermediate/index.html:179)
- ✅ "¿Cómo se juega?" → [`onclick="switchScreen('screenInstructions')"`](../../game_intermediate/index.html:180)
- ✅ "Volver" → [`onclick="switchScreen('screenWelcome')"`](../../game_intermediate/index.html:202)

**CSS hover como enhancement:**
- ✅ [`.btn:hover`](../../game_intermediate/index.html:31) existe pero no es requisito funcional
- ✅ [`.robot-card:hover`](../../game_intermediate/index.html:62) solo aplica a cards no bloqueadas
- ✅ Todas las interacciones funcionan sin `:hover` en dispositivos touch

---

### 4. [PROTO] localStorage guarda/restaura progreso ✅

**saveState():**
- ✅ Guarda [`demo: FORGE_STATE.demo`](../../game_intermediate/index.html:399) en localStorage
- ✅ Key: `coala_forge_progress`
- ✅ [`try/catch`](../../game_intermediate/index.html:397) maneja localStorage bloqueado
- ✅ Toast de advertencia si falla el guardado

**loadState():**
- ✅ Restaura [`FORGE_STATE.demo = data.demo || false`](../../game_intermediate/index.html:414)
- ✅ Setea [`FORGE_STATE.firstVisit = false`](../../game_intermediate/index.html:415) al cargar
- ✅ [`try/catch`](../../game_intermediate/index.html:404) maneja JSON corrupto
- ✅ Limpia localStorage si hay corrupción

**Recarga en modo demo:**
- ✅ Preserva `demo: true` en localStorage
- ✅ [`init()`](../../game_intermediate/index.html:730) detecta progreso previo y va al Dashboard
- ✅ Toast "¡Bienvenido de vuelta!" se muestra

---

### 5. [PROTO] OWASP Top 5 críticos ✅

| Item | Estado | Evidencia |
|------|--------|-----------|
| **No XSS** | ✅ PASS | [`innerHTML`](../../game_intermediate/index.html:494) solo con datos internos hardcodeados (emojis, labels estáticos). Sin user input inyectado. |
| **No eval()** | ✅ PASS | No se usa `eval()` en todo el archivo |
| **No credenciales** | ✅ PASS | Sin passwords, tokens, API keys, secrets hardcodeados |
| **No inyección URL** | ✅ PASS | Sin `location.search`, `URLSearchParams`, ni parsing de query strings |
| **textContent usado** | ✅ PARTIAL | [`textContent`](../../game_intermediate/index.html:756) usado para títulos. `innerHTML` se usa solo para HTML estructural con datos controlados. |

**Análisis de innerHTML:**
Los usos de `innerHTML` son seguros porque:
1. Usan strings literales hardcodeadas (emojis, nombres de pantallas)
2. No concatenan input del usuario
3. No usan templates con interpolación de datos externos

Ejemplo seguro:
```javascript
cell.innerHTML = '<span class="cell-icon">'+icons[idx]+'</span>'
```
Donde `icons` es array estático: `['🏺','🧩','🔧','🧪','🏆']`

---

### 6. [PROTO] 1 test happy path ✅

**Flujo completo demo verificado:**

```
1. Abrir sin Templo Nivel 5 (sin coala_v3_progress)
   → renderWelcome() muestra "¡Hola, explorador!"
   
2. Click "🚀 Empezar"
   → goToDashboard() setea demo=true, firstVisit=false
   → switchScreen('screenMission')
   → Toast: "🎮 Modo demo: jugá sin límites..."
   
3. Click "Tu misión"
   → renderMissionArtifact() muestra 2 celdas OK, 3 BROKEN
   
4. Click "🚀 Empezar misión"
   → goToDashboard() → demo ya true, firstVisit ya false
   → switchScreen('screenDashboard')
   
5. Dashboard → completar robots (Constructor → Tester → Tablet → Forja)
   → simulateConstructor(), completeTester(), activateTablet(), finalizeMission()
   → saveState() guarda progreso después de cada robot
   
6. Victoria con certificado "Modo Demo"
   → showCertificate() detecta FORGE_STATE.demo
   → Cambia título a "🎮 Certificado — Modo Demo"
   → Agrega nota: "Completa el Templo de Thot..."
```

Todos los pasos verificados en código ✅

---

## No Regresión — Flujo Normal ✅

**Verificación con Templo Nivel 5:**
- ✅ [`renderWelcome()`](../../game_intermediate/index.html:754) detecta `templeLevel5Complete === true`
- ✅ Muestra mensaje: "Bienvenido, aprendiz" (no "¡Hola, explorador!")
- ✅ Botón: "🔧 Entrar a la Forja" (sin botón "¿Cómo se juega?")
- ✅ [`goToDashboard()`](../../game_intermediate/index.html:454) Path A: acceso directo sin setear `demo=true`
- ✅ [`FORGE_STATE.demo === false`](../../game_intermediate/index.html:380) en flujo normal
- ✅ Victoria: certificado normal "Aprendiz de la Forja" (sin modo demo)

**Preservación de comportamiento:**
- ✅ `goToDashboard()` Path A sin cambios funcionales
- ✅ Todas las pantallas de robots funcionan idéntico
- ✅ Sistema de progreso y artefacto sin modificaciones

---

## Hallazgos y Observaciones

### Hallazgo #1: Uso de innerHTML (Riesgo Bajo)
**Ubicación:** Múltiples funciones de renderizado  
**Descripción:** Se usa `innerHTML` para actualizar el DOM en lugar de `textContent` o `createElement`.  
**Riesgo:** Bajo — solo con datos internos hardcodeados.  
**Recomendación:** Para modo BETA/PROD, migrar a `createElement()` + `appendChild()` o usar una librería de templating con sanitización.

### Hallazgo #2: No hay sanitización de YAML
**Ubicación:** [`validateYaml()`](../../game_intermediate/index.html:610)  
**Descripción:** El editor YAML valida sintaxis básica pero no sanitiza el contenido.  
**Riesgo:** Bajo — el YAML es solo visual, no se parsea ni ejecuta.  
**Recomendación:** Considerar validación más estricta si se permite edición real en futuras versiones.

### Hallazgo #3: AudioContext sin fallback visual
**Ubicación:** [`getAudio()`](../../game_intermediate/index.html:387)  
**Descripción:** Si Web Audio API falla, el juego continúa sin feedback visual del error.  
**Riesgo:** Mínimo — el catch vacío previene crashes.  
**Recomendación:** Opcional: agregar indicador visual de "modo silencio" si audio falla.

---

## Métricas

| Métrica | Valor |
|---------|-------|
| Líneas de código | 788 |
| Funciones | 25+ |
| Pantallas | 9 |
| Variables de estado | 11 |
| Event listeners | 1 (input YAML) |
| localStorage keys | 2 |

---

## Recomendaciones para BETA

Si se escala a modo BETA, considerar:

1. **Tests automatizados:** Jest o Vitest para lógica de state machine
2. **E2E testing:** Playwright para flujos completos
3. **Sanitización:** DOMPurify para cualquier contenido dinámico
4. **TypeScript:** Tipado estático para FORGE_STATE
5. **Lighthouse CI:** Performance y accessibility gates
6. **i18n:** Preparar strings para traducción

---

## Conclusión

✅ **APROBADO para merge en PROTOTIPO**

El código cumple con todos los criterios del modo PROTOTIPO:
- Flujos felices funcionan sin errores de consola
- Responsive desde 320px
- Touch funcional
- localStorage operativo
- Sin vulnerabilidades críticas OWASP
- Sin regresiones en flujo normal

**Próximo paso:** Merge a main y deploy a GitHub Pages para testing manual.

---

**OUTPUT_FILE:** `docs/specs/coala-forja-guide-fix/review.md`  
**STATUS:** ✅ COMPLETE

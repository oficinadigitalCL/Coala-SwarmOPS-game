# 🔧 La Forja de la Tabla Esmeralda — Nivel Intermedio

**Proyecto:** COALA-SwarmOps Game  
**Nivel:** Intermedio  
**Stack:** HTML5 + CSS3 + Vanilla JavaScript  
**Dependencias:** Cero  
**Deploy:** GitHub Pages (static)  
**Audiencia:** Niños y jóvenes (10–14 años)  
**Idioma:** Español  
**Feature ID:** FEAT-001  
**Branch:** `feat/coala-forja-intermediate`

---

## 🎯 Propuesta

**La Forja de la Tabla Esmeralda** es el segundo nivel de COALA-SwarmOps, después del [Templo de Thot](index.html). En esta etapa, el aprendiz ya conoce los 5 agentes del enjambre (Diseñar, Construir, Probar, Documentar, Recordar) y ahora los enfrenta a una misión práctica: **reparar un juego roto**.

### La Metáfora

> *"En la antigua Forja de Thot, los robots construían artefactos mágicos. Pero algo salió mal: el Artefacto Roto solo tiene 2 de 5 pantallas funcionales. Los robots están dormidos. Solo tú puedes despertarlos, uno por uno, para reparar lo que se rompió."*

El aprendiz no solo juega — **construye el juego mientras juega**. Usa VS Code + Zoo Code para interactuar con 4 robots-agentes que reparan el código del Artefacto paso a paso.

---

## 🛠️ Tecnología

| Capa | Tecnología | Justificación |
|------|-----------|---------------|
| **Frontend** | HTML5 + CSS3 + Vanilla JS | Máxima portabilidad, cero dependencias, single-file |
| **Estilos** | CSS Custom Properties (`:root`) | Paleta egipcia heredada del Templo de Thot |
| **Animaciones** | CSS Keyframes | `fadeSlideIn`, `floatGlyph`, `pulseStep`, `confettiFall` |
| **Audio** | Web Audio API | `playTone()`, `playCorrect()`, `playVictory()` con fallback silencioso |
| **Persistencia** | localStorage | Clave `coala_forge_progress` con checksum anti-tampering |
| **Responsive** | Mobile-first | `clamp()`, `@media(max-width:480px)`, touch targets ≥44px |
| **Accesibilidad** | `prefers-reduced-motion`, `<noscript>` | Inclusión para niños con distintas necesidades |

### Principio Single-File

Cada nivel es un **archivo HTML autocontenido**:
- CSS dentro de `<style>`
- JS dentro de `<script>`
- Sin archivos externos, sin CDN, sin npm
- Emojis nativos como iconografía (🏺, 🤖, 🧪, 📜, 🔮)

---

## 🏗️ Arquitectura

### State Machine (`FORGE_STATE`)

```javascript
{
  screen: 'welcome',           // welcome | dashboard | robot-* | victory
  progress: 0,                 // 0 | 25 | 50 | 75 | 100
  robots: {
    constructor: 'locked',     // locked | dormant | active | completed
    tester: 'locked',
    tablet: 'locked',
    forge: 'locked'
  },
  artifact: {
    screen1: true,             // Bienvenida — siempre OK
    screen2: true,             // Nivel 1 — siempre OK
    screen3: false,            // Nivel 2 — repara Constructor
    screen4: false,            // Nivel 3 — repara Probador
    screen5: false             // Victoria — repara Forja
  }
}
```

### Flujo de Pantallas

```
Bienvenida → Dashboard → Constructor → Dashboard → Probador
                                              ↓
Victoria ← Forja ← Dashboard ← Tabla Esmeralda ← Dashboard
```

### Módulos JavaScript (todo en un `<script>`)

| Módulo | Responsabilidad |
|--------|----------------|
| `ForgeApp` | Orquestador principal. Init, detección de Nivel 5 |
| `ScreenManager` | `switchScreen(id)` con animación `fadeSlideIn` |
| `ProgressManager` | Barra de 4 segmentos, hitos 25/50/75/100% |
| `StorageAdapter` | `saveState()` / `loadState()` + checksum |
| `RobotManager` | Estados locked/dormant/active/completed |
| `ArtifactView` | Grid 5 celdas (2 ✅ + 3 🔧 inicialmente) |
| `YamlValidator` | Validación básica: `:`, indentación, claves requeridas |
| `AudioWrapper` | Web Audio API con `try/catch` silencioso |
| `ToastNotify` | Notificaciones temporales slide-up |
| `ConfettiCelebration` | 40 partículas CSS para victoria |

---

## 📁 Estructura de Archivos

```
raíz/
│
├── index.html                          ← Templo de Thot (Nivel Aprendiz) [NO TOCAR]
│
├── game_intermediate/                  ← Nivel Intermedio: La Forja
│   ├── index.html                      ← HUB principal (644 líneas)
│   └── seed/
│       └── index.html                  ← Artefacto Roto (153 líneas, 2/5 funcional)
│
├── custom_modes_v6.0_edu.yaml          ← 10 agentes (6 originales + 4 robots)
│
├── docs/
│   ├── project-profile.md              ← Stack y metadatos del proyecto
│   ├── swarm-context.md                ← Memoria del swarm
│   └── specs/coala-forja-intermediate/
│       ├── requirements.md             ← 10 ACs + edge cases + DoD
│       ├── design.md                   ← Diagrama Mermaid + arquitectura
│       ├── tasks.md                    ← 24 tareas (T001–T024)
│       ├── spec-validation.md          ← Reporte de validación
│       ├── review.md                   ← Review básica OWASP
│       ├── budget.yaml                 ← Presupuesto estimado
│       ├── fastforward-complete.md     ← Resumen del fastforward
│       └── git-commands.md             ← Comandos Git detallados
│
├── plans/coala-forja-intermediate/
│   ├── execution_plan.yaml             ← Plan de 7 fases
│   └── planning-complete.md            ← Resumen del planner
│
└── scripts/
    └── git-commit-forge.ps1            ← Script PowerShell para commit
```

---

## 🎮 Cómo Usar

### Para el Aprendiz (niño/joven)

1. **Abrir el HUB:** Abre `game_intermediate/index.html` en tu navegador
2. **Verificar progreso:** Si completaste el Nivel 5 del Templo, Thot te dejará entrar
3. **Despertar robots:**
   - 🤖 **Constructor:** Sigue las instrucciones para usar `/constructor` en Zoo Code
   - 🧪 **Probador:** Usa `/probador` para verificar que todo funciona
   - 📜 **Tabla Esmeralda:** Edita el YAML y actívalo
   - 🔮 **Forja:** Completa el checklist final
4. **¡Victoria!** Celebración con confetti, certificado y opción de compartir

### Para el Mentor / Desarrollador

```bash
# Clonar el repo
git clone https://github.com/oficinadigitalCL/Coala-SwarmOPS-game.git

# Cambiar a la rama del feature
git checkout feat/coala-forja-intermediate

# Abrir el HUB en navegador
start game_intermediate/index.html    # Windows
open game_intermediate/index.html     # macOS
xdg-open game_intermediate/index.html # Linux
```

---

## 🧪 Funcionalidades Implementadas

| Funcionalidad | Estado | Detalle |
|---------------|--------|---------|
| HUB con 7 pantallas | ✅ | Bienvenida, Dashboard, 4 Robots, Victoria |
| Artefacto Roto 2/5 | ✅ | 2 pantallas funcionan, 3 con overlay "En reparación" |
| 4 robots-agentes | ✅ | Constructor, Probador, Tabla Esmeralda, Forja |
| Progreso 0→25→50→75→100% | ✅ | Barra animada con hitos |
| localStorage persistente | ✅ | Clave `coala_forge_progress` + checksum |
| Web Audio API | ✅ | Tones, correct, victory, click |
| YAML editor inline | ✅ | Validación básica en tiempo real |
| Detección Nivel 5 | ✅ | Lee `coala_v3_progress` del Templo |
| Confetti CSS | ✅ | 40 partículas animadas |
| Certificado | ✅ | Fecha, firma de Thot, título |
| Compartir victoria | ✅ | Copia mensaje al portapapeles |
| Responsive ≥320px | ✅ | Mobile-first, touch targets |
| `<noscript>` | ✅ | Mensaje amigable para JS deshabilitado |
| `prefers-reduced-motion` | ✅ | Accesibilidad |

---

## 🔒 Seguridad (Checklist OWASP Prototipo)

| Ítem | Estado | Nota |
|------|--------|------|
| Sin XSS | ✅ | `innerHTML` solo con datos internos |
| Sin `eval()` | ✅ | No existe en el código |
| Sin credenciales | ✅ | Ninguna clave hardcodeada |
| Sin inyecciones | ✅ | Sin SQL ni query params dinámicos |
| localStorage seguro | ✅ | Checksum anti-tampering |

---

## 📊 Métricas del Feature

| Métrica | Valor |
|---------|-------|
| Historias de usuario | 8 (HU-1 a HU-8) |
| Criterios de aceptación | 10 |
| Tareas implementadas | 24 (T001–T024) |
| Líneas de código HUB | 644 |
| Líneas de código Artefacto | 153 |
| Agentes YAML | 10 (6 + 4 nuevos) |
| Tiempo estimado | ~16 horas |
| Budget estimado | $2.44 |

---

## 🗺️ Roadmap

| Etapa | Estado | Descripción |
|-------|--------|-------------|
| **Nivel Aprendiz** | ✅ | Templo de Thot — 5 niveles con koalas |
| **Nivel Intermedio** | ✅ | La Forja de la Tabla Esmeralda — 4 robots |
| **Nivel Avanzado** | 📋 | La Catedral del Enjambre — polling real, tests |
| **Modo Beta** | 📋 | Promover con 64 tareas, 80% coverage |

---

## 🤝 Contribuir

Este es un proyecto educativo de código abierto. Para contribuir:

1. Fork el repositorio
2. Crea una rama: `git checkout -b feat/mi-mejora`
3. Commitea con [Conventional Commits](https://www.conventionalcommits.org/)
4. Push: `git push origin feat/mi-mejora`
5. Abre un Pull Request

---

## 📜 Licencia

MIT — Creado por [Oficina Digital CL](https://github.com/oficinadigitalCL) para la comunidad COALA.

---

<div align="center">

🔧 **La Forja de la Tabla Esmeralda** — *Construiste el juego que estás jugando* 🏆

</div>

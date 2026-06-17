# Idea Brief — Forja Intermedia: Bug Fix + Guía Didáctica

**Slug:** `coala-forja-guide-fix`
**Fecha:** 2026-06-17
**Modo:** PROTOTIPO 🚀
**Stack:** HTML5 + CSS3 + Vanilla JavaScript (single-file, cero dependencias)

---

## Resumen

Mejora de la primera parte de [`game_intermediate/index.html`](../../game_intermediate/index.html:1) que resuelve el bloqueo al inicio y agrega pantallas de guía didáctica para niños.

---

## Problemas Detectados

### 🐛 Bug: Juego pegado al inicio
- [`goToDashboard()`](../../game_intermediate/index.html:380) verifica `FORGE_STATE.templeLevel5Complete` que depende de `localStorage['coala_v3_progress']`
- Si el niño NO viene del Templo Nivel 5 → mensaje toast y botón bloqueado
- No hay camino alternativo para entrar sin el progreso previo

### 📖 Falta guía didáctica
- La pantalla de bienvenida actual solo tiene 2 frases y un botón
- No explica CÓMO se juega (VS Code + Zoo Code)
- No tiene imágenes/íconos para que un niño de 10-14 años entienda solo
- No menciona la posibilidad de jugar desde tablet/celular

---

## Qué se va a construir (Parte 1 de 3)

### 1. Arreglo del flujo de entrada
- Detectar si existe progreso del Templo Nivel 5
- Si SÍ → acceso normal a la Forja
- Si NO → mostrar modo "demo/guiado" con tutorial completo
- El juego debe ser jugable sin depender del Templo

### 2. Pantalla de Instrucciones (1-2 pantallas)
- **Pantalla 1:** "¿Cómo se juega?" — íconos grandes explicando:
  - 🖥️ VS Code en tu PC
  - 🤖 Zoo Code con los robots
  - 📱 También podés ver el juego en tu tablet/celular
- **Pantalla 2:** "Tu misión" — explicación simple de:
  - Los robots están dormidos, tenés que despertarlos
  - Cada robot te enseña algo nuevo
  - Completá las 5 pantallas del Artefacto

### 3. Mejora de bienvenida
- Animaciones más llamativas para niños
- Botón claro de "Empezar" / "Ver instrucciones"
- Tone amigable y energético

---

## Stack y Restricciones

- Single-file HTML autocontenido (modificar `game_intermediate/index.html`)
- CSS custom properties (paleta egipcia-dorado-noche heredada)
- Vanilla JavaScript, sin frameworks
- Mobile-first responsive
- Compatible con el state machine + localStorage existente
- Cero dependencias externas

---

## Próximas Partes (fuera del alcance actual)

- **Parte 2:** Escena "Matrix" entre nivel intermedio y avanzado
- **Parte 3:** Soporte mobile dedicado (PWA, jugar desde celular)

---

## Pipeline

```
[PIPELINE: prototype]
[TIPO: educational-game-enhancement]
[AUDIENCIA: ninos-10-14]
[STACK_SUGERIDO: html-vanilla-static]
[REFERENCIA: matrix-raining-code-effect]
```

---


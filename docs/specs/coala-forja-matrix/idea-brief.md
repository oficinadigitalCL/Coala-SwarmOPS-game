# Idea Brief — El Portal del Código

**Slug:** `coala-forja-matrix`
**Fecha:** 2026-06-17
**Modo:** PROTOTIPO 🚀
**Stack:** HTML5 + CSS3 + Vanilla JavaScript (single-file, cero dependencias)
**Audiencia:** Niños y jóvenes 10-14 años
**Idioma:** Español
**Tema visual:** Egipcio-dorado-noche → transición a verde Matrix
**Referencia:** `matrix-raining-code-effect`
**Archivo output:** `game_intermediate/matrix.html`

---

## Resumen

Escena cinemática de transición entre La Forja (nivel intermedio) y el nivel Avanzado: **El Portal del Código**. Pantalla independiente con efecto de lluvia de caracteres estilo Matrix que transforma jeroglíficos dorados en código verde neón.

---

## 🎬 Descripción Visual

Al terminar La Forja (reparar el Artefacto Roto), el niño entra a una pantalla cinemática de transición.

- **Fondo:** negro profundo (noche egipcia, `#0a0a0f`)
- **Lluvia de caracteres:** empiezan cayendo en **dorado** (`#d4a843`, jeroglíficos digitales) y de a poco se transforman en **verde neón** (`#00ff41`) — la magia antigua volviéndose código real
- **Mensaje central:** "El código verdadero te espera..." con glow enigmático
- **Botón:** "Cruzar el portal →" aparece a los ~3 segundos
- **Duración total:** ~8-10 segundos (se puede acortar con el botón)
- **Al cruzar:** redirige a `game_advanced/index.html` (nivel Avanzado)

## 🔮 Sensación

**MISTERIO.** Algo grande está por revelarse. Tono enigmático, música tensa pero emocionante. El aprendiz está por descubrir que la magia antigua y el código son lo mismo.

## 🎨 Paleta de Colores

| Elemento | Color | Variable |
|---|---|---|
| Fondo | `#0a0a0f` | `--night` |
| Caracteres iniciales | `#d4a843` | `--gold` |
| Caracteres finales | `#00ff41` | Matrix green |
| Brillo mensaje | `#d4a843` glow | `--gold-glow` |

Transición gradual dorado → verde durante la animación.

## 📁 Estructura

- Archivo independiente: `game_intermediate/matrix.html`
- Single-file HTML autocontenido (`<style>` + `<script>` inline)
- Sin dependencias externas
- Redirige a `game_advanced/index.html` al finalizar

## 🔗 Conexión Narrativa

- Continúa desde La Forja (el niño ya reparó el Artefacto Roto)
- Thot no aparece físicamente, pero su presencia se siente en el mensaje
- La Tabla Esmeralda se "digitaliza" — los jeroglíficos se vuelven código
- Puente temático: mundo antiguo → mundo del código real

---

## Pipeline

```
[PIPELINE: prototype]
[TIPO: escena-transicion-cinematica]
[AUDIENCIA: ninos-10-14]
[REFERENCIA: matrix-raining-code-effect]
[STACK_SUGERIDO: html-vanilla-static]
```

---

**STATUS: IDEA_CLARIFIED ✓**

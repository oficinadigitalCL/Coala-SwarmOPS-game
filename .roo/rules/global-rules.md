# GLOBAL RULES — SWARM v7.2
# Aplicables a TODOS los modos del swarm

---

## 1. ECONOMÍA DE TOKENS

- Siempre intentar T0.5 (DS Flash) primero
- Escalar a T1 solo si T0.5 falla 3 veces
- Escalar a T2 solo si T1 falla 2 veces
- T3 (Kimi K2.6) solo para orquestación y planificación
- Nunca usar T3 para tareas que T0.5 puede resolver

---

## 2. NO ROMPER LO QUE FUNCIONA

- Todos los modos existentes de v7.1 se mantienen
- Los nuevos modos son ADICIONALES, no reemplazos
- Si un modo funciona bien, no modificar su comportamiento core
- Los cambios deben ser backward-compatible

---

## 3. MEMORIA SEMÁNTICA DINÁMICA (SM)

- NUNCA hardcodear stack, dominio, o especialistas
- SIEMPRE leer desde `docs/project-profile.md`
- SIEMPRE leer `docs/swarm-context.md` al inicio
- SIEMPRE leer `docs/swarm-context.md → cognitive_memory` si existe
- SIEMPRE leer `docs/checkpoints/checkpoint-index.md` al inicio

---

## 4. FLUJO CONTINUO

- Cada agente termina con pregunta de continuación:
  `[SI / NO / CORREGIR]`
- Nunca dejar al usuario sin saber qué sigue
- Siempre indicar el próximo paso sugerido
- Siempre mostrar costo acumulado hasta ahora

---

## 5. IDEA CLARIFIER ES PARA HUMANOS

- Lenguaje simple, sin jerga técnica
- Opciones visuales/concretas
- Nunca asumir conocimiento técnico del usuario
- Siempre validar con el usuario antes de avanzar
- Precargar preferencias desde cognitive_memory

---

## 6. GITNEXUS ES OPCIONAL

- Si GitNexus MCP no está disponible → degradar graceful
- nexus-impact-analyzer → flash-code-scout
- nexus-predictive → flash-deep-thinker + análisis manual
- Nunca bloquear pipeline por falta de GitNexus
- Siempre documentar cuando se usa fallback

---

## 7. HERMES ES OPCIONAL

- Si Hermes ACP no está disponible → usar especialistas T1
- Nunca delegar a hermes si SM.hermes_avail == false
- Si hermes falla → reintentar 1 vez, luego escalar
- Siempre crear checkpoint antes de delegar a hermes

---

## 8. COGNITIVE MEMORY ES PRIVADA

- Solo usa datos del proyecto actual
- Nunca envía datos a servicios externos
- Se guarda localmente en `docs/swarm-context.md`
- El usuario puede borrarla con `/reset_cognitive_memory`
- Nunca hardcodea preferencias — siempre detecta dinámicamente

---

## 9. CONTINUIDAD DE SESIÓN

- Siempre verificar checkpoints al inicio
- Si hay sesión pausada → preguntar si continuar
- Nunca perder estado de decisión entre sesiones
- Checkpoints automáticos en cada gate
- Archivar checkpoints de features completadas

---

## 10. MODO BETA ES PRE-RELEASE

- Beta no reemplaza production
- Es un paso intermedio validado
- Permite promoción a production con `/upgrade_beta`
- Costo intermedio: ~$5-8
- Calidad real pero sin overhead completo

---

## 11. DEGRADACIÓN GRACEFUL

- Si cualquier herramienta/servicio falla → no bloquear
- Siempre tener fallback definido
- Documentar cuando se usa fallback
- Notificar al usuario de la degradación
- Registrar en EM para futuras decisiones

---

## 12. SEGURIDAD ANTES DE VELOCIDAD

- Nunca saltarse security-auditor en beta/production
- Nunca saltarse dependency-guardian en beta/production
- En prototype: mínimo 5 items críticos de OWASP
- Nunca hardcodear credenciales
- Siempre validar comandos destructivos con usuario

---

## 13. OUTPUT CONTRACT

- Cada worker debe crear output_file antes de terminar
- Si output_file no existe → worker no terminó → no avanzar
- Output debe ser en formato markdown
- Output debe incluir STATUS (COMPLETE/PARTIAL/FAILED)
- Output debe ser compatible con evidence-checker

---

## 14. CONVENTIONAL COMMITS

- Todos los commits siguen formato Conventional Commits
- feat: nueva feature
- fix: corrección de bug
- docs: documentación
- refactor: refactorización
- test: tests
- chore: mantenimiento

---

## 15. IDIOMA

- Interfaz con usuario: Español (preferencia detectada)
- Documentación técnica: Inglés (estándar)
- Código: Inglés (estándar)
- Comentarios en código: Español si el equipo prefiere

---

## 16. NO BORRAR SIN PREGUNTAR (REGLA DE ORO)

- ⛔ **NUNCA ejecutar `rm`, `rmdir`, `del`, `Remove-Item` ni comandos destructivos sin confirmación explícita del usuario.**
- ⛔ **NUNCA borrar carpetas o archivos del proyecto sin preguntar.**
- ✅ Para mover archivos, usar `copy`/`xcopy` primero, verificar, y luego pedir permiso para borrar originales.
- ✅ Para limpieza, siempre preguntar: "¿Puedo eliminar estas carpetas vacías/obsoletas?"
- ✅ Si el usuario dice "ordena" o "reorganiza", el default es COPIAR/DUPLICAR, nunca borrar los originales.
- 📂 Las carpetas `mejora_kimi26/`, `hermes_study/`, `docs/`, `scripts/`, `plans/` y similares son **historial del laboratorio** y no deben destruirse.
- 🗑️ Si se requiere borrar, debe ser el último paso y solo tras confirmación visual del usuario.
- 🔄 Todo borrado debe ser reversible (mover a una papelera `_archived/` en vez de `rmdir /S /Q`).

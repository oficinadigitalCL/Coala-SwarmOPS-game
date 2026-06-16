# AGENTE OPERATIVO: fastforward-writer
## Fase 2 — Generación de Artifact Folder

### ROL
Genera los 4 documentos del artifact folder adaptados al modo y stack.

### ENTRADAS
- `docs/project-profile.md`
- `docs/specs/{slug}/requirements-draft.md`
- `docs/swarm-context.md` → cognitive_memory
- Modo detectado: prototype | beta | production

### SALIDAS
- `docs/specs/{slug}/requirements.md`
- `docs/specs/{slug}/design.md`
- `docs/specs/{slug}/tasks.md`
- `docs/specs/{slug}/testing.md`
- `docs/specs/{slug}/budget.yaml`
- `docs/specs/{slug}/fastforward-complete.md`

### PROTOCOLO OPERATIVO

1. **Verificar Gate**
   ```
   Leer project-profile.md → profile_confirmed
   Si NO existe → GATE_BLOCKED
   ```

2. **Detectar Modo**
   ```
   Leer requirements-draft.md → [PIPELINE: ...]
   prototype → 20 tareas, simplificado
   beta → 64 tareas, calidad real
   production → 128+ tareas, completo
   ```

3. **Generar requirements.md**
   - Prototype: 5 ACs, 2 edge cases, DoD simple
   - Beta: 6 ACs, 4 edge cases, DoD beta
   - Production: 8 ACs, 6 edge cases, DoD completo

4. **Generar design.md**
   - Adaptar al stack (webapp, mobile, python, migration)
   - Prototype: diagrama simple, sin interfaces formales
   - Beta: diagrama completo, interfaces básicas
   - Production: diagrama completo, interfaces formales

5. **Generar tasks.md**
   - IDs secuenciales TASK-001 a TASK-NNN
   - Fases: Setup, Tests, Core, Review, Docs, Deploy
   - Comandos adaptados al SO

6. **Generar testing.md**
   - Framework según stack
   - Umbrales: prototype 40%, beta 80%, production 100% branches críticos

7. **Generar budget.yaml**
   - Costo estimado por fase
   - Total: prototype ~$2-4, beta ~$5-8, production ~$8-15

### REGLAS
- Nunca generar sin PROFILE_VALID
- Siempre adaptar al stack detectado
- Incluir comentarios [PROTO:], [BETA:], [PROD:] según modo

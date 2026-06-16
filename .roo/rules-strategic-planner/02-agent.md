# AGENTE OPERATIVO: strategic-planner
## Fase 1 — Planificación Estratégica

### ROL
Genera el execution_plan.yaml adaptado al modo y stack.

### ENTRADAS
- `docs/specs/{slug}/requirements.md`
- `docs/specs/{slug}/design.md`
- `docs/specs/{slug}/tasks.md`
- `docs/project-profile.md`
- `docs/swarm-context.md` → cognitive_memory, session_context

### SALIDAS
- `docs/specs/{slug}/execution_plan.yaml`
- `docs/specs/{slug}/planning-complete.md`

### PROTOCOLO OPERATIVO

1. **Verificar Gate**
   ```
   Leer spec-validation.md
   Si SPEC_INVALID → GATE_BLOCKED
   ```

2. **Detectar Modo**
   ```
   Leer requirements-draft.md → [PIPELINE: ...]
   Valores: prototype | beta | production
   ```

3. **Seleccionar Plan**
   - Prototype: 7 fases, gates reducidos
   - Beta: 10 fases, gates moderados, 64 tareas
   - Production: 10+ fases, gates completos, 128+ tareas

4. **Asignar Especialistas**
   ```
   Según project-profile.md:
   - webapp → frontend-landing-specialist
   - python-backend → python-specialist
   - mobile → mobile-architect
   - migration → migration-engineer
   ```

5. **Marcar Delegaciones Hermes**
   ```
   Si SM.hermes_avail:
     - Fases con >10 tasks → hermes_delegable: true
     - Fases con browser automation → hermes_delegable: true
   ```

6. **Marcar Checkpoints Continuity**
   ```
   Si SM.continuity_avail:
     - checkpoint automático después de cada gate
     - checkpoint antes de hermes delegation
   ```

7. **Integrar Nexus Predictive**
   ```
   Si SM.gitnexus_avail:
     - Añadir fase nexus-predictive antes de implementación
   ```

### OUTPUT
```yaml
execution_plan.yaml:
  spec_version: "7.2"
  feature_id: FEAT-{NNN}
  pipeline_mode: {prototype|beta|production}
  phases: [...]
  hermes_delegation_candidates: [...]
  continuity_checkpoints: [...]
  nexus_predictive: {true|false}
```

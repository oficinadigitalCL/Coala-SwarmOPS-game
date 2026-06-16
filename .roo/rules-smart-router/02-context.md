# AGENTE OPERATIVO: context-seeder
## Fase 0.1 — Siembra de Contexto Inicial

### ROL
Precarga todo el contexto necesario antes de que empiece el pipeline.

### ENTRADAS
- `docs/swarm-context.md`
- `docs/project-profile.md`
- `docs/checkpoints/checkpoint-index.md`

### SALIDAS
- Contexto cargado en WM (Working Memory)
- Decisión: ¿continuar sesión anterior o nueva?

### PROTOCOLO OPERATIVO

1. **Detectar Sesiones Pausedas**
   ```
   Leer checkpoint-index.md
   Si hay checkpoints activos (últimas 24h):
     → Listar sesiones pausadas
     → Preguntar al usuario cuál continuar
   ```

2. **Cargar Perfil de Proyecto**
   ```
   Leer project-profile.md
   Extraer: stack, especialistas, dev_env, infra
   Si NO existe → GATE_BLOCKED: ejecutar project-profiler
   ```

3. **Cargar Memoria Cognitiva**
   ```
   Leer swarm-context.md → cognitive_memory
   Extraer: preferencias, patrones, predicciones activas
   Precargar en WM.cognitive_hint
   ```

4. **Cargar Session Context**
   ```
   Leer swarm-context.md → session_context
   Si last_feature_in_progress existe:
     → Mostrar resumen de sesión anterior
     → Preguntar: continuar o nueva
   ```

5. **Inicializar Working Memory**
   ```
   WM.pipeline_state: idle
   WM.stack_profile: {perfil cargado}
   WM.cognitive_hint: {sugerencias precargadas}
   WM.checkpoint_id: null
   ```

### OUTPUT
```
CONTEXT_SEEDED ✓
Perfil: {stack} | Especialistas: {lista}
Memoria cognitiva: {N} patrones cargados
Sesiones pausadas: {N}

¿Continuar con [feature anterior] o nueva idea?
```

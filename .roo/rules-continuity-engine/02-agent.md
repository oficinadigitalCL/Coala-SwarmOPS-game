# AGENTE OPERATIVO: continuity-checkpoint
## Fase Transversal — Gestión de Checkpoints

### ROL
Crea, lista, restaura y archiva checkpoints de sesión.

### ENTRADAS
- Estado actual del pipeline
- `docs/checkpoints/checkpoint-index.md`

### SALIDAS
- `docs/checkpoints/CP-{NNNN}.yaml`
- `docs/checkpoints/checkpoint-index.md` actualizado

### PROTOCOLO OPERATIVO

1. **Crear Checkpoint Automático**
   ```
   Cuándo:
   - Cada gate superado
   - Cada 30 minutos de actividad
   - Antes de delegar a hermes
   - Antes de comandos destructivos
   
   Contenido:
   - checkpoint_id
   - timestamp
   - feature, fase, worker
   - wm_snapshot
   - em_snapshot
   - archivos_abiertos
   - pending_decisions
   - costo_acumulado
   ```

2. **Crear Checkpoint Manual**
   ```
   Comando: /checkpoint "{nota}"
   Incluye nota del usuario en el checkpoint
   ```

3. **Listar Checkpoints**
   ```
   Comando: /checkpoint_list
   Muestra:
   | ID | Feature | Fase | Worker | Estado | Fecha |
   ```

4. **Restaurar Checkpoint**
   ```
   Comando: /resume {checkpoint_id}
   1. Leer CP-{NNNN}.yaml
   2. Restaurar WM y EM
   3. Reabrir archivos
   4. Mostrar pending_decisions
   5. Preguntar: "¿Continuamos? [SI / NO]"
   ```

5. **Archivar Checkpoints**
   ```
   Automático: >7 días o feature completada
   Manual: /checkpoint_archive {id}
   ```

6. **Limpieza**
   ```
   Máximo 10 checkpoints activos
   Excedidos → archivar el más antiguo
   ```

### REGLAS
- Nunca guardar código en checkpoints (solo estado)
- Nunca guardar credenciales
- Checkpoints son locales al proyecto
- Máximo 1 checkpoint por minuto

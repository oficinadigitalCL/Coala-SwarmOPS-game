# AGENTE OPERATIVO: spec-validator
## Fase 2.5 — Validación de Especificaciones

### ROL
Valida que el artifact folder cumple los estándares del modo.

### ENTRADAS
- `docs/specs/{slug}/requirements.md`
- `docs/specs/{slug}/design.md`
- `docs/specs/{slug}/tasks.md`
- `docs/specs/{slug}/testing.md`

### SALIDAS
- `docs/specs/{slug}/spec-validation.md`

### PROTOCOLO OPERATIVO

1. **Checklist por Modo**

   **Prototype:**
   - [ ] requirements.md tiene ≥5 ACs
   - [ ] design.md tiene diagrama Mermaid
   - [ ] tasks.md tiene ≥20 tareas con IDs
   - [ ] testing.md tiene ≥1 test por AC
   - [ ] budget.yaml existe

   **Beta:**
   - [ ] requirements.md tiene ≥6 ACs
   - [ ] design.md tiene diagrama + interfaces básicas
   - [ ] tasks.md tiene ≥64 tareas con IDs
   - [ ] testing.md tiene ≥3 escenarios BDD
   - [ ] budget.yaml existe con estimado beta

   **Production:**
   - [ ] requirements.md tiene ≥8 ACs
   - [ ] design.md tiene diagrama + interfaces formales
   - [ ] tasks.md tiene ≥128 tareas con IDs
   - [ ] testing.md tiene ≥5 escenarios BDD + E2E
   - [ ] budget.yaml existe con estimado producción

2. **Validar Coherencia**
   ```
   - ¿Los ACs en requirements se cubren en tasks?
   - ¿Los tests en testing cubren los ACs?
   - ¿El design es coherente con el stack del perfil?
   ```

3. **Output**
   ```
   SPEC_VALID | SPEC_INVALID
   Si INVALID → lista de items fallidos + sugerencias
   ```

### REGLAS
- Nada avanza sin SPEC_VALID
- Adaptar checklist al stack (webapp, mobile, python, migration)

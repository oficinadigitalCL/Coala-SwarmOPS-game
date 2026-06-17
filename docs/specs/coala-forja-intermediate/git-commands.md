# Git Commands — Fase 1 + 5

**Fecha:** 2026-06-17  
**Worker:** senior (T1 · DS Pro)  
**Feature:** coala-forja-intermediate

---

## Comandos a ejecutar

```bash
# 1. Verificar si ya hay repo Git
git status

# Si NO hay repo:
git init
git add .
git commit -m "chore: initial commit"

# 2. Crear rama feature
git checkout -b feat/coala-forja-intermediate

# 3. Stage de archivos nuevos
git add game_intermediate/
git add docs/specs/coala-forja-intermediate/
git add custom_modes_v6.0_edu.yaml

# 4. Commit con Conventional Commits
git commit -m "feat(forge): nivel intermedio La Forja de la Tabla Esmeralda

- HUB interactivo single-file con 7 pantallas
- 4 robots-agentes: Constructor, Probador, Tabla Esmeralda, Forja
- Artefacto Roto (2/5 pantallas funcionales iniciales)
- State machine JS vanilla + localStorage con checksum
- Web Audio API con fallback silencioso
- YAML editor inline con validación básica
- Responsive mobile-first (≥320px), zero dependencies
- Confetti CSS, certificado, compartir victoria"

# 5. Push (si hay remote configurado)
git push -u origin feat/coala-forja-intermediate
```

---

## Archivos incluidos en el commit

| Archivo | Descripción |
|---------|-------------|
| `game_intermediate/index.html` | HUB principal — La Forja |
| `game_intermediate/seed/index.html` | Artefacto Roto (2/5 funcional) |
| `custom_modes_v6.0_edu.yaml` | 4 robots nuevos con explicaciones |
| `docs/specs/coala-forja-intermediate/*.md` | Requirements, design, tasks, validation, review |
| `docs/specs/coala-forja-intermediate/*.yaml` | Budget |
| `plans/coala-forja-intermediate/*.yaml` | Execution plan |
| `plans/coala-forja-intermediate/*.md` | Planning complete |

---

**STATUS: PENDING_MANUAL_EXECUTION**

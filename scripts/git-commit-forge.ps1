# Script PowerShell — Commit Fase Intermedia "La Forja"
# Ejecutar desde la raíz del repo: .\scripts\git-commit-forge.ps1

$ErrorActionPreference = "Stop"

Write-Host "═══════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  Git Commit — La Forja de la Tabla Esmeralda" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════" -ForegroundColor Cyan

# 1. Verificar estado
Write-Host "`n[1/5] Verificando estado del repo..." -ForegroundColor Yellow
$branch = git branch --show-current
Write-Host "Rama actual: $branch" -ForegroundColor Green

# 2. Crear rama feature
$featureBranch = "feat/coala-forja-intermediate"
Write-Host "`n[2/5] Creando rama: $featureBranch..." -ForegroundColor Yellow
$existing = git branch --list $featureBranch
if ($existing) {
    Write-Host "La rama ya existe. Cambiando a ella..." -ForegroundColor Magenta
    git checkout $featureBranch
} else {
    git checkout -b $featureBranch
}

# 3. Stage archivos
Write-Host "`n[3/5] Agregando archivos al stage..." -ForegroundColor Yellow
git add game_intermediate/
git add docs/specs/coala-forja-intermediate/
git add docs/swarm-context.md
git add plans/coala-forja-intermediate/
git add custom_modes_v6.0_edu.yaml
git add scripts/git-commit-forge.ps1

# Verificar qué se va a commitear
Write-Host "`nArchivos en stage:" -ForegroundColor Cyan
git diff --cached --stat

# 4. Commit
Write-Host "`n[4/5] Creando commit..." -ForegroundColor Yellow
$commitMsg = @"
feat(forge): nivel intermedio La Forja de la Tabla Esmeralda

- HUB interactivo single-file con 7 pantallas (644 líneas)
- 4 robots-agentes: Constructor, Probador, Tabla Esmeralda, Forja
- Artefacto Roto (2/5 pantallas funcionales iniciales)
- State machine JS vanilla + localStorage con checksum
- Web Audio API con fallback silencioso
- YAML editor inline con validación básica
- Responsive mobile-first (≥320px), zero dependencies
- Confetti CSS, certificado, compartir victoria

Closes: FEAT-001
"@

git commit -m $commitMsg

# 5. Push
Write-Host "`n[5/5] Push a origin..." -ForegroundColor Yellow
$remote = git remote
if ($remote) {
    git push -u origin $featureBranch
    Write-Host "`n✅ Commit y push completados exitosamente!" -ForegroundColor Green
    Write-Host "Rama: $featureBranch" -ForegroundColor Green
    Write-Host "URL: https://github.com/oficinadigitalCL/Coala-SwarmOPS-game/tree/$featureBranch" -ForegroundColor Green
} else {
    Write-Host "`n⚠️ No hay remote configurado." -ForegroundColor Red
    Write-Host "Agrega el remote con:" -ForegroundColor Yellow
    Write-Host "  git remote add origin https://github.com/oficinadigitalCL/Coala-SwarmOPS-game.git" -ForegroundColor White
}

Write-Host "`n═══════════════════════════════════════════" -ForegroundColor Cyan

# 🚀 Deploy del Juego en GitHub Pages

Guía paso a paso para publicar COALA-SwarmOps Game en GitHub Pages.

---

## Paso 1: Crear el repositorio en GitHub

1. Ve a **[github.com/new](https://github.com/new)**
2. **Nombre:** `Coala-SwarmOPS-game`
3. **Descripción:** `Juego interactivo para aprender COALA-SwarmOps — Temática Thot + Koalas`
4. **Visibilidad:** Público (requerido para GitHub Pages gratis)
5. **NO marcar** "Add a README file" (ya tenemos uno)
6. **NO marcar** ".gitignore" (ya tenemos uno)
7. Click **"Create repository"**

## Paso 2: Subir el código

Desde esta carpeta, ejecuta:

```bash
git init
git add .
git commit -m "feat: initial commit — COALA-SwarmOps Game v1.0"
git branch -M main
git remote add origin https://github.com/oficinadigitalcl/Coala-SwarmOPS-game.git
git push -u origin main
```

## Paso 3: Activar GitHub Pages

1. Ve a tu repo en GitHub → **Settings** → **Pages**
2. **Source:** "Deploy from a branch"
3. **Branch:** `main` → `/(root)` → **Save**
4. Espera **1-2 minutos** mientras se despliega
5. Tu juego estará en: **[https://oficinadigitalcl.github.io/Coala-SwarmOPS-game](https://oficinadigitalcl.github.io/Coala-SwarmOPS-game)**

## Paso 4: Verificar

Abre la URL en:
- ✅ Tu computador (Chrome, Firefox, Edge)
- ✅ Tu celular (iOS Safari, Android Chrome)
- ✅ Tu tablet

El juego debe verse y funcionar correctamente en todos los dispositivos.

---

## 🔄 Actualizar el juego

Cada vez que hagas cambios:

```bash
git add .
git commit -m "feat: descripción del cambio"
git push
```

GitHub Pages se redespliega automáticamente en 1-2 minutos.

---

## 🌐 Dominio personalizado (opcional)

Si quieres usar un dominio propio como `juego.coala-swarmops.cl`:

1. Ve a **Settings → Pages → Custom domain**
2. Ingresa tu dominio y guarda
3. En tu proveedor DNS, agrega un registro `CNAME`:
   - **Nombre:** `juego`
   - **Valor:** `oficinadigitalcl.github.io`
4. Marca **"Enforce HTTPS"**

---

## ❓ Problemas comunes

| Problema | Solución |
|----------|----------|
| **404 al abrir la URL** | Espera 2 min más. GitHub Pages tarda en propagar. |
| **CSS no carga** | Verifica que `index.html` esté en la raíz del repo, no en una subcarpeta. |
| **No se ve en mobile** | Asegúrate de no tener el repo en modo privado (GitHub Pages requiere repo público en plan gratis). |
| **Cambios no se reflejan** | Haz `git push` y espera 2 min. Revisa la pestaña **Actions** del repo para ver el estado del deploy. |

---

<p align="center">
  🐨🏛️ ¡Buena suerte, Arquitecto de Enjambres!
</p>

# Historias de Usuario — COALA: La Forja de la Tabla Esmeralda

## Metadata

| Campo | Valor |
|---|---|
| **Slug** | `coala-forja-intermediate` |
| **Modo** | PROTOTIPO 🚀 |
| **Stack** | HTML/CSS/JS vanilla, cero dependencias |
| **Fecha** | 2026-06-17 |
| **Pipeline** | FASE 0 → us-enricher |

---

## Glosario

| Término | Significado |
|---|---|
| **Tabla Esmeralda** | Archivo `custom_modes_v6.0_edu.yaml` que define agentes/robots |
| **Artefacto Roto** | Juego incompleto (`seed/index.html`) que el niño repara |
| **Forja** | VS Code + Zoo Code, el taller donde los robots trabajan |
| **Robot** | Evolución de los koalas — agentes especializados del swarm |
| **HUB** | Interfaz web (`game_intermediate/index.html`) que guía la misión |

---

## HU-1: HUB de Misión — La Forja

> **Como** aprendiz que completó el Templo de Thot,  
> **quiero** abrir el HUB de la Forja en mi navegador,  
> **para que** vea el Artefacto Roto y entienda qué debo reparar.

### Criterios de Aceptación (EARS)

| ID | Criterio EARS |
|---|---|
| AC1-1 | **WHEN** el aprendiz abre `game_intermediate/index.html` **THEN** el HUB carga en <3 segundos sin errores de consola. |
| AC1-2 | **WHEN** el aprendiz ve la pantalla de bienvenida **THEN** Thot explica la historia: "Este juego fue construido por robots, pero algo salió mal". |
| AC1-3 | **WHEN** el aprendiz hace clic en "Entrar a la Forja" **THEN** se muestra el dashboard con: estado del Artefacto Roto, robots disponibles, progreso de la misión. |
| AC1-4 | **WHEN** el aprendiz revisa el Artefacto Roto **THEN** ve visualmente qué partes están rotas (faltan funciones, colores grises, botones sin efecto). |
| AC1-5 | **GIVEN** que el aprendiz no ha completado VS Code instalado del Nivel 5 **WHEN** intenta entrar a la Forja **THEN** Thot muestra un mensaje amigable: "Primero completa el Nivel 5 del Templo, joven aprendiz". |

### Edge Cases

| ID | Escenario | Comportamiento esperado |
|---|---|---|
| EC1-1 | Navegador sin JavaScript | Mostrar `<noscript>` con mensaje: "La Forja necesita JavaScript para funcionar. Pídele ayuda a un adulto." |
| EC1-2 | Pantalla muy pequeña (<320px) | Layout se adapta, texto legible mínimo 14px, no se cortan botones. |
| EC1-3 | localStorage bloqueado | El HUB funciona igual pero sin persistir progreso entre sesiones. Mostrar toast sutil. |
| EC1-4 | Conexión lenta / archivo grande | Mostrar spinner con mensaje "Thot está invocando la Forja..." hasta que cargue. |

### BDD Scenarios

```gherkin
Feature: HUB de la Forja

  Scenario: Primer ingreso al HUB
    Given el aprendiz abre game_intermediate/index.html
    When la página carga completamente
    Then Thot aparece con mensaje de bienvenida
    And se muestra el botón "🔧 Entrar a la Forja"
    And se escucha sonido de ambiente (mecanismos suaves)

  Scenario: Acceso al dashboard de la Forja
    Given el aprendiz está en la pantalla de bienvenida
    When hace clic en "Entrar a la Forja"
    Then el HUB muestra el dashboard con 3 secciones:
      | Sección | Contenido |
      | Artefacto Roto | Vista previa del juego roto (gris, sin funciones) |
      | Robots Disponibles | 4 robots con estado "dormido" |
      | Misión Actual | "Misión 1: Despierta al Robot Constructor" |
    And se actualiza la barra de progreso al 0%

  Scenario: Aprendiz sin Nivel 5 completado
    Given el aprendiz nunca completó el Nivel 5 del Templo
    When abre el HUB por primera vez
    Then Thot muestra mensaje: "🌳 Primero debes dominar el Templo de Thot"
    And aparece enlace al index.html original
    And el botón de la Forja está deshabilitado visualmente
```

---

## HU-2: Robot Constructor — Despierta y Repara

> **Como** aprendiz en la Forja,  
> **quiero** activar al Robot Constructor usando su Tabla Esmeralda,  
> **para que** arregle las primeras partes rotas del Artefacto Roto.

### Criterios de Aceptación (EARS)

| ID | Criterio EARS |
|---|---|
| AC2-1 | **WHEN** el aprendiz hace clic en el Robot Constructor **THEN** el HUB muestra instrucciones paso a paso para abrir VS Code y usar Zoo Code. |
| AC2-2 | **GIVEN** que el Robot Constructor está activado **WHEN** el aprendiz ejecuta `/constructor` en Zoo Code **THEN** el agente lee el Artefacto Roto y propone código para arreglar la primera función rota. |
| AC2-3 | **WHEN** el aprendiz aplica el código sugerido por el Constructor **THEN** el HUB detecta el cambio (mediante polling o manual refresh) y muestra la parte reparada con animación de brillo dorado. |
| AC2-4 | **WHEN** el aprendiz completa la Misión 1 del Constructor **THEN** la barra de progreso avanza al 25% y se desbloquea el Robot Probador. |
| AC2-5 | **GIVEN** que el aprendiz escribe código incorrecto manualmente **WHEN** guarda el archivo **THEN** el HUB muestra mensaje de Thot: "El constructor detectó un error. ¿Quieres que lo arregle?" |

### Edge Cases

| ID | Escenario | Comportamiento esperado |
|---|---|---|
| EC2-1 | Aprendiz borra el archivo seed/index.html | HUB muestra "⚠️ El Artefacto desapareció. Descarga la semilla de nuevo" con botón de descarga. |
| EC2-2 | Aprendiz modifica código pero no guarda | HUB no detecta cambios, Thot dice: "Guarda el archivo con Ctrl+S para que la Forja lo sienta". |
| EC2-3 | Código generado por el agente tiene error de sintaxis | El HUB muestra el error en consola del navegador amigable: "🔧 El engranaje 3 no encaja. Revisa la línea 42." |
| EC2-4 | Aprendiz cierra VS Code accidentalmente | El HUB guarda el estado de la misión. Al volver, Thot dice: "Bienvenido de vuelta. Continuamos donde quedaste." |

### BDD Scenarios

```gherkin
Feature: Robot Constructor

  Scenario: Activar al Robot Constructor
    Given el aprendiz está en el dashboard de la Forja
    And el Robot Constructor muestra estado "💤 Dormido"
    When el aprendiz hace clic en el Robot Constructor
    Then el HUB muestra panel con instrucciones:
      """
      1. Abre VS Code
      2. Carga la carpeta game_intermediate/seed/
      3. Abre Zoo Code (Ctrl+Shift+P → Zoo Code)
      4. Escribe: /constructor "repara el botón de inicio del juego"
      """
    And el robot cambia a estado "👁️ Observando..."

  Scenario: El Constructor arregla el código
    Given el aprendiz ejecutó /constructor en Zoo Code
    And el agente generó código para arreglar la función startGame()
    When el aprendiz guarda el archivo seed/index.html
    And refresca el HUB (F5)
    Then el HUB detecta el cambio
    And la sección "Artefacto Roto" muestra el botón de inicio ahora funcional
    And aparece animación de engranajes dorados girando
    And Thot dice: "🔧 ¡Excelente! El Constructor reparó el primer engranaje."

  Scenario: Código incorrecto del aprendiz
    Given el aprendiz editó seed/index.html manualmente
    And escribió "funtion startGame()" (typo en "function")
    When guarda el archivo
    And refresca el HUB
    Then el HUB muestra mensaje de error amigable:
      "⚠️ Hay un error de escritura en el código. 
       Pista: 'funtion' debería ser 'function'. 
       ¿Quieres que el Constructor lo arregle?"
```

---

## HU-3: Robot Probador — Verifica la Reparación

> **Como** aprendiz en la Forja,  
> **quiero** activar al Robot Probador después del Constructor,  
> **para que** verifique que el código reparado funciona correctamente antes de seguir.

### Criterios de Aceptación (EARS)

| AC3-1 | **WHEN** el Robot Constructor completa su misión **THEN** el Robot Probador se desbloquea en el dashboard con animación de despertar. |
| AC3-2 | **WHEN** el aprendiz hace clic en el Robot Probador **THEN** el HUB muestra instrucciones para ejecutar `/probador` en Zoo Code. |
| AC3-3 | **GIVEN** que el Probador verifica el código **WHEN** encuentra un error **THEN** muestra mensaje en el HUB: "🧪 El Probador encontró un bug en la línea X" con sugerencia de arreglo. |
| AC3-4 | **WHEN** el Probador confirma que todo funciona **THEN** el HUB muestra check verde, avanza progreso al 50%, y desbloquea el Robot Tabla Esmeralda. |
| AC3-5 | **GIVEN** que el Probador aprueba **WHEN** el aprendiz abre el Artefacto Roto **THEN** las funciones reparadas responden correctamente (botones clickeables, animaciones fluidas). |

### Edge Cases

| EC3-1 | Probador detecta error en código que "parece" funcionar | Thot explica: "A veces el código se ve bien pero tiene errores escondidos. El Probador los encuentra." |
| EC3-2 | Aprendiz intenta usar Probador antes que Constructor | HUB bloquea con mensaje: "Primero despierta al Constructor. Necesitamos algo que probar." |
| EC3-3 | Test pasa pero el juego se ve mal visualmente | HUB muestra advertencia: "🧪 El código funciona, pero el diseño necesita atención. ¿Llamamos al Constructor otra vez?" |

### BDD Scenarios

```gherkin
Feature: Robot Probador

  Scenario: Desbloqueo del Probador
    Given el Constructor completó Misión 1
    When el dashboard se actualiza
    Then el Robot Probador cambia de "🔒 Bloqueado" a "💤 Dormido"
    And Thot dice: "🧪 Ahora que el Constructor trabajó, necesitamos verificar su trabajo."

  Scenario: El Probador encuentra un bug
    Given el aprendiz ejecutó /probador en Zoo Code
    And el agente revisó seed/index.html
    When encuentra que la función playClick() no reproduce sonido
    Then el HUB muestra:
      | Campo | Valor |
      | Estado | 🧪 Bug encontrado |
      | Línea | 295 |
      | Problema | playTone() no recibe frecuencia |
      | Sugerencia | Agregar parámetro: playTone(440) |

  Scenario: El Probador aprueba todo
    Given el Probador revisó todo el código reparado
    When no encuentra errores
    Then el HUB muestra: "✅ ¡Todos los tests pasaron!"
    And la barra de progreso avanza al 50%
    And se desbloquea el Robot Tabla Esmeralda con animación
```

---

## HU-4: Robot Tabla Esmeralda — Configura los Agentes

> **Como** aprendiz en la Forja,  
> **quiero** modificar la Tabla Esmeralda (custom_modes.yaml),  
> **para que** los robots tengan las instrucciones correctas para terminar el juego.

### Criterios de Aceptación (EARS)

| AC4-1 | **WHEN** el Robot Tabla Esmeralda se desbloquea **THEN** el HUB muestra vista previa del YAML actual con resaltado de sintaxis. |
| AC4-2 | **WHEN** el aprendiz hace clic en "Editar Tabla" **THEN** el HUB abre editor inline con validación YAML en tiempo real (básica: indentación, claves requeridas). |
| AC4-3 | **GIVEN** que el aprendiz modifica el YAML **WHEN** hay error de sintaxis **THEN** el HUB marca la línea en rojo con mensaje: "⚠️ La Tabla tiene un error de escritura". |
| AC4-4 | **WHEN** el YAML es válido **THEN** el HUB muestra botón "🔮 Activar Tabla" que simula cargar la configuración en los robots. |
| AC4-5 | **WHEN** la Tabla se activa correctamente **THEN** el progreso avanza al 75% y se desbloquea el Robot Forja (coordinador final). |

### Edge Cases

| EC4-1 | Aprendiz borra todo el contenido del YAML | HUB muestra: "⚠️ La Tabla está en blanco. ¿Restaurar la versión original?" con botón de undo. |
| EC4-2 | Aprendiz agrega clave inválida (ej: `modelo` en vez de `model`) | Validador muestra: "🔍 'modelo' no es una clave conocida. ¿Quisiste decir 'model'?" |
| EC4-3 | YAML válido pero con valores peligrosos (ej: model que no existe) | HUB advierte: "⚠️ Este modelo no está en la lista permitida. Los robots podrían no despertar." |
| EC4-4 | Aprendiz copia y pega YAML de internet | HUB valida estructura mínima: `customModes`, `slug`, `name`, `roleDefinition`. Si falta, rechaza. |

### BDD Scenarios

```gherkin
Feature: Robot Tabla Esmeralda

  Scenario: Ver la Tabla Esmeralda
    Given el Probador completó su misión
    When el aprendiz hace clic en "📜 Ver Tabla Esmeralda"
    Then el HUB muestra el YAML con resaltado:
      ```yaml
      customModes:
        - slug: robot-constructor
          name: "🤖 Robot Constructor"
          roleDefinition: "Arreglas código HTML/CSS/JS para niños"
          groups:
            - read
            - edit
      ```
    And las claves obligatorias están marcadas con ⭐

  Scenario: Editar la Tabla con error
    Given el aprendiz está editando el YAML
    When escribe:
      ```yaml
      customModes:
        - slug robot-constructor
      ```
    Then el validador marca la línea 2 en rojo
    And muestra: "⚠️ Falta ':' después de 'slug'. La Tabla no se puede leer así."

  Scenario: Activar Tabla correctamente
    Given el YAML editado es válido
    When el aprendiz hace clic en "🔮 Activar Tabla"
    Then los robots en el dashboard brillan con luz verde
    And Thot dice: "🟢 ¡La Tabla Esmeralda está activa! Los robots saben qué hacer."
    And el progreso avanza al 75%
```

---

## HU-5: Artefacto Roto — El Juego Incompleto

> **Como** aprendiz en la Forja,  
> **quiero** ver visualmente cómo el Artefacto Roto se va reparando paso a paso,  
> **para que** entienda el impacto de cada misión que completo.

### Criterios de Aceptación (EARS)

| AC5-1 | **WHEN** el aprendiz entra al HUB por primera vez **THEN** el Artefacto Roto muestra solo 2 de 5 pantallas funcionales, el resto en gris con mensaje "🔧 En reparación". |
| AC5-2 | **WHEN** el Constructor completa Misión 1 **THEN** la pantalla 3 del Artefacto pasa de gris a color con animación de transición (1 segundo). |
| AC5-3 | **WHEN** el Probador aprueba **THEN** las pantallas reparadas muestran check verde permanente. |
| AC5-4 | **WHEN** la Tabla Esmeralda se activa **THEN** el Artefacto muestra todas las pantallas funcionales pero con placeholder "🤖 Robot trabajando..." en las no terminadas. |
| AC5-5 | **WHEN** todas las misiones se completan **THEN** el Artefacto Roto se transforma en juego completo, jugable, con celebración de confeti CSS. |

### Edge Cases

| EC5-1 | Aprendiz intenta jugar pantalla no reparada | HUB muestra overlay: "🔒 Esta parte aún está rota. Completa la misión actual para desbloquearla." |
| EC5-2 | Pantalla reparada pero con bug visual residual | HUB detecta inconsistencia y marca como "⚠️ Necesita retoque" en vez de check verde. |
| EC5-3 | Artefacto se abre en móvil | Layout responsive, touch funcional, sin hover dependency. |

### BDD Scenarios

```gherkin
Feature: Artefacto Roto

  Scenario: Estado inicial del Artefacto
    Given el aprendiz abre el HUB por primera vez
    When ve la sección "Artefacto Roto"
    Then ve miniatura del juego con:
      | Pantalla | Estado |
      | Bienvenida | ✅ Funciona (color) |
      | Nivel 1 | ✅ Funciona (color) |
      | Nivel 2 | 🔧 En reparación (gris) |
      | Nivel 3 | 🔧 En reparación (gris) |
      | Victoria | 🔧 En reparación (gris) |

  Scenario: Reparación visual progresiva
    Given el Constructor completó Misión 1
    When el aprendiz mira el Artefacto Roto
    Then la Pantalla Nivel 2 cambia de gris a color
    And aparece animación de engranajes durante 1 segundo
    And Thot dice: "🔧 ¡Otra pieza encaja! El Artefacto cobra vida."

  Scenario: Artefacto completamente reparado
    Given todas las misiones están completas
    When el aprendiz abre el Artefacto Roto
    Then todas las pantallas muestran ✅
    And el juego es completamente jugable
    And aparece celebración de confeti CSS
    And Thot dice: "🏆 ¡El Artefacto está completo! Tú lo construiste."
```

---

## HU-6: Progreso Visual y Persistencia

> **Como** aprendiz en la Forja,  
> **quiero** ver mi progreso en una barra visual y que se guarde entre sesiones,  
> **para que** no pierda lo avanzado si cierro el navegador.

### Criterios de Aceptación (EARS)

| AC6-1 | **WHEN** el aprendiz completa cualquier misión **THEN** la barra de progreso se actualiza inmediatamente con animación suave. |
| AC6-2 | **GIVEN** que el aprendiz cierra el navegador **WHEN** vuelve a abrir el HUB **THEN** el progreso se restaura desde localStorage. |
| AC6-3 | **WHEN** el aprendiz alcanza 25%, 50%, 75% o 100% **THEN** el HUB reproduce sonido distintivo y Thot entrega un "sabio consejo" relacionado. |
| AC6-4 | **GIVEN** que localStorage está lleno o bloqueado **WHEN** el aprendiz completa una misión **THEN** el progreso funciona en la sesión actual y se muestra mensaje: "⚠️ Tu progreso no se guardará entre sesiones." |
| AC6-5 | **WHEN** el aprendiz completa el 100% **THEN** aparece botón "🎓 Certificado de Aprendiz de la Forja" (pantalla simple con nombre y fecha). |

### Edge Cases

| EC6-1 | localStorage corrupto (JSON inválido) | HUB limpia la clave, reinicia progreso a 0, muestra mensaje: "Thot olvidó tu progreso. ¿Empezamos de nuevo?" |
| EC6-2 | Aprendiz juega en 2 navegadores distintos | Cada navegador tiene su propio progreso. No hay sync (prototipo). |
| EC6-3 | Aprendiz intenta "hackear" el progreso editando localStorage | HUB valida checksum simple; si falla, reinicia a 0. |

### BDD Scenarios

```gherkin
Feature: Progreso Visual y Persistencia

  Scenario: Progreso se guarda automáticamente
    Given el aprendiz completó Misión 1 (25%)
    When cierra el navegador
    And vuelve a abrir game_intermediate/index.html
    Then la barra de progreso muestra 25%
    And el Robot Constructor muestra estado "✅ Completado"
    And Thot dice: "¡Bienvenido de vuelta! Continuamos donde quedaste."

  Scenario: Hitos de progreso con recompensas
    Given el aprendiz alcanza el 50%
    When la barra llega a la mitad
    Then suena campana de logro
    And Thot entrega sabio consejo:
      "📜 'El que no prueba, no aprende.' — Thot el Sabio"
    And se desbloquea insignia "🧪 Aprendiz del Probador"

  Scenario: Certificado al 100%
    Given el aprendiz completó todas las misiones
    When el progreso llega al 100%
    Then aparece botón "🎓 Ver mi Certificado"
    When hace clic
    Then ve pantalla con:
      | Campo | Valor |
      | Título | Certificado de Aprendiz de la Forja |
      | Fecha | 2026-06-17 |
      | Proyecto | COALA-SwarmOps — Nivel Intermedio |
      | Firma | Thot, Dios de la Sabiduría Digital |
```

---

## HU-7: Robot Forja — Coordinador Final

> **Como** aprendiz en la Forja,  
> **quiero** que el Robot Forja coordine la misión final,  
> **para que** sepa exactamente qué hacer para terminar el juego completamente.

### Criterios de Aceptación (EARS)

| AC7-1 | **WHEN** el Robot Forja se desbloquea (75%) **THEN** el HUB muestra su panel con resumen de todo lo hecho y lo que falta. |
| AC7-2 | **WHEN** el aprendiz hace clic en el Robot Forja **THEN** muestra checklist final: "✅ Constructor, ✅ Probador, ✅ Tabla Esmeralda, ⬜ Últimos toques". |
| AC7-3 | **GIVEN** que todos los items del checklist están ✅ **WHEN** el aprendiz hace clic en "🔮 Finalizar Misión" **THEN** el Artefacto Roto se transforma en juego completo. |
| AC7-4 | **WHEN** la misión finaliza **THEN** el HUB muestra pantalla de victoria con: puntuación, tiempo transcurrido, consejo final de Thot. |
| AC7-5 | **WHEN** la pantalla de victoria aparece **THEN** hay botón "🔄 Jugar de Nuevo" (reinicia todo) y "📤 Compartir" (copia mensaje al portapapeles). |

### Edge Cases

| EC7-1 | Aprendiz intenta finalizar con checklist incompleto | Robot Forja muestra: "⏳ Aún faltan tareas. Revisa el checklist antes de terminar." |
| EC7-2 | Aprendiz hace clic "Finalizar" varias veces | Solo la primera vez tiene efecto. Las demás son ignoradas silenciosamente. |

### BDD Scenarios

```gherkin
Feature: Robot Forja — Coordinador Final

  Scenario: Desbloqueo del Robot Forja
    Given la Tabla Esmeralda está activada (75%)
    When el dashboard se actualiza
    Then el Robot Forja aparece con estado "👁️ Te observa..."
    And Thot dice: "🎯 El Forjador está listo. Es hora de terminar lo que empezamos."

  Scenario: Checklist final incompleto
    Given el aprendiz hace clic en "🔮 Finalizar Misión"
    And faltó activar un robot
    Then el Robot Forja muestra: "⏳ Aún falta: Activar Robot Probador"
    And el item faltante parpadea en naranja

  Scenario: Misión completada con éxito
    Given todos los items del checklist están ✅
    When el aprendiz hace clic en "🔮 Finalizar Misión"
    Then el Artefacto Roto se transforma en juego completo
    And suena música de victoria (Web Audio API)
    And aparece pantalla:
      | Campo | Valor |
      | Título | 🏆 ¡La Forja está completa! |
      | Subtítulo | Construiste el juego que estás jugando |
      | Puntuación | 1000 pts |
      | Rango | 🎓 Aprendiz de la Forja |
    And hay botones: "🔄 Jugar de Nuevo", "📤 Compartir"
```

---

## HU-8: Custom Modes Educativos Interactivos (Tabla Esmeralda v7.0)

> **Como** aprendiz que ya sabe usar agentes,  
> **quiero** que la Tabla Esmeralda del nivel intermedio sea interactiva y me explique por qué está ahí cada cosa,  
> **para que** entienda no solo CÓMO usar los robots, sino POR QUÉ existen y QUÉ poder tienen.

### Criterios de Aceptación (EARS)

| AC8-1 | **WHEN** el aprendiz abre `custom_modes_v6.0_edu.yaml` en VS Code **THEN** cada robot tiene sección `explicacion:` que dice: "Estoy aquí porque..." con contexto de la historia de la Forja. |
| AC8-2 | **WHEN** el aprendiz ejecuta cualquier comando de robot **THEN** la respuesta del agente incluye al menos una frase que conecta con la metáfora ("🔧 El Constructor ha activado sus engranajes..."). |
| AC8-3 | **GIVEN** que el aprendiz pregunta "¿por qué?" a cualquier robot **WHEN** escribe la pregunta en el prompt **THEN** el agente responde explicando el propósito pedagógico, no solo la acción técnica. |
| AC8-4 | **WHEN** el aprendiz completa una misión con un robot **THEN** ese robot actualiza su `explicacion:` para reflejar lo aprendido (ej: "Ya reparamos juntos el botón de inicio. Ahora sabes que..."). |
| AC8-5 | **WHEN** el aprendiz lee el YAML completo **THEN** hay un comentario de Thot al inicio que explica: "Esta Tabla Esmeralda es VIVA. Cada robot no solo hace cosas, sino que te enseña POR QUÉ las hace." |

### Edge Cases

| EC8-1 | Aprendiz elimina la sección `explicacion:` del YAML | El robot sigue funcionando técnicamente pero el HUB muestra advertencia: "⚠️ Este robot perdió su voz. ¿Restaurar explicaciones?" |
| EC8-2 | Aprendiz escribe pregunta en idioma no soportado | Robot responde en español con: "🤖 Entiendo que preguntas 'por qué'. Te explico en español..." |
| EC8-3 | YAML con explicaciones muy largas | HUB trunca visualmente a 200 caracteres con "..." y botón "Leer más". |

### BDD Scenarios

```gherkin
Feature: Tabla Esmeralda Interactiva

  Scenario: Robot explica su propósito
    Given el aprendiz abre custom_modes_v6.0_edu.yaml
    When lee la sección del Robot Constructor
    Then ve:
      ```yaml
      - slug: robot-constructor
        name: "🤖 Robot Constructor"
        explicacion: |
          🔧 Estoy aquí porque en la Forja de Thot, cada pieza
          rota necesita un artesano. Yo soy ese artesano.
          
          Cuando me llamas con /constructor, no solo arreglo código.
          Te enseño POR QUÉ se rompió y CÓMO evitarlo la próxima vez.
          
          Mi poder: transformar lo roto en funcional,
          paso a paso, como un relojero que arma engranajes.
      ```

  Scenario: Robot responde con contexto de la Forja
    Given el aprendiz escribe en Zoo Code:
      /constructor "por qué debo arreglar esto yo y no tú solo?"
    When el Robot Constructor responde
    Then dice algo como:
      """
      🤖 ¡Gran pregunta! En la Forja de Thot, los robots trabajamos
      EN EQUIPO contigo. No solo te damos el pescado, te enseñamos
      a pescar.
      
      Si yo arreglara todo solo, aprenderías a depender de mí.
      Pero si lo hacemos juntos, aprendes a pensar como un
      Arquitecto Digital. Ese es el verdadero poder de la Tabla Esmeralda.
      """

  Scenario: Explicación evoluciona con la misión
    Given el aprendiz completó Misión 1 con el Constructor
    When reabre custom_modes_v6.0_edu.yaml
    Then la explicación del Constructor ahora dice:
      ```yaml
      explicacion: |
        🔧 ¡Ya trabajamos juntos! Reparamos el botón de inicio del Artefacto.
        
        LO QUE APRENDISTE:
        - Cada función en JavaScript necesita un nombre claro
        - Un botón sin onclick es como una puerta sin picaporte
        - Guardar (Ctrl+S) es como encender el motor antes de arrancar
        
        PRÓXIMA MISIÓN: El Probador verificará que nuestro trabajo
        no se rompa cuando alguien más lo use.
      ```
```

---

## Definition of Done (DoD) General — Prototipo 🚀

| # | Criterio |
|---|---|
| 1 | Todas las historias de usuario tienen ACs verificables y pasan manualmente |
| 2 | El HUB funciona en Chrome, Firefox, Edge y Safari (últimas 2 versiones) |
| 3 | El HUB funciona en móvil (touch) sin depender de hover |
| 4 | Cero errores en consola del navegador en flujo feliz |
| 5 | Los archivos semilla (`seed/`) se pueden abrir directamente en VS Code sin configuración adicional |
| 6 | `custom_modes_v6.0_edu.yaml` incluye los 4 robots nuevos con explicaciones interactivas |
| 7 | localStorage guarda/restaura progreso correctamente |
| 8 | `<noscript>` presente para navegadores sin JS |
| 9 | Tiempo de carga del HUB <3 segundos en conexión estándar |
| 10 | Todo el contenido está en español, lenguaje apropiado para 10-14 años |
| 11 | No se modifica `index.html` raíz ni archivos del nivel Aprendiz |
| 12 | Todo nuevo contenido vive en `game_intermediate/` |

---

## Anti-Duplicado Check ✅

| Feature solicitada | ¿Existe en nivel Aprendiz? | ¿Es duplicado? |
|---|---|---|
| HUB interactivo con progreso | Sí (index.html tiene pantallas) | ❌ NO — es evolución, no duplicado |
| Robots-agentes con roles | Sí (koalas) | ❌ NO — evolución de koalas a robots |
| Custom modes YAML | Sí (v6.0) | ❌ NO — v7.0 con nuevos robots + explicaciones |
| Cuarta pared (construir el juego) | ❌ No existe | ❌ NO — feature nueva |
| Juego roto + misión de reparar | ❌ No existe | ❌ NO — feature nueva |
| Tabla Esmeralda como metáfora YAML | ❌ No existe (era Pergamino) | ❌ NO — evolución conceptual |
| Coordenada Forja (VS Code + Zoo Code) | Parcial (Nivel 5 instala) | ❌ NO — integración real con agentes |

**Veredicto: Ninguna historia es duplicada. Todas son evoluciones legítimas del nivel Aprendiz o features completamente nuevas.**

---

STATUS: COMPLETE
NEXT: /plan {slug} → strategic-planner genera execution_plan.yaml

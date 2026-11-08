
---

## 1. `AnioBisiesto.psc`

**Qué hace:** pide un año y dice si es bisiesto.

**Regla implementada:**

```
bisiesto = (anio MOD 400 = 0) O (anio MOD 4 = 0 Y anio MOD 100 <> 0)
```

### Tabla de verdad

| `anio MOD 400 = 0` | `anio MOD 4 = 0` | `anio MOD 100 <> 0` | Resultado | Ejemplo |
|:--:|:--:|:--:|---|---|
| V | V | F | **Es bisiesto** | 2000, 1600 |
| F | V | V | **Es bisiesto** | 2024, 2028 |
| F | V | F | **No es bisiesto** | 1900, 2100 |
| F | F | V | **No es bisiesto** | 2023, 2025 |
| F | F | F | — imposible (si no es múltiplo de 4, tampoco lo es de 100) | — |
| V | F | — | — imposible (múltiplo de 400 implica múltiplo de 4) | — |

> Nota: si `anio MOD 400 = 0` el algoritmo ya responde y **no evalúa** la segunda condición (queda en el `SiNo` anidado solo cuando no es múltiplo de 400).

### Casos de borde

| Entrada | Salida esperada | Por qué importa |
|---:|---|---|
| 4 | bisiesto | Primer múltiplo de 4 "normal" |
| 100 | no bisiesto | Múltiplo de 100 pero no de 400 |
| 400 | bisiesto | Múltiplo de 400 |
| 1900 | no bisiesto | Siglo no divisible por 400 |
| 2000 | bisiesto | Siglo divisible por 400 |
| 2023 | no bisiesto | Año común |
| 2024 | bisiesto | Año bisiesto reciente |
| 2100 | no bisiesto | Próximo siglo no bisiesto |
| 0 | bisiesto (`0 MOD 400 = 0`) | El año 0 no existe en el calendario gregoriano, pero el algoritmo lo acepta |
| -4 / -100 / -400 | bisiesto / no bisiesto / bisiesto | El algoritmo no valida años negativos; las reglas funcionan igual con MOD |
| 1 | no bisiesto | Valor mínimo "real" |
| 3.5 o texto (`abc`) | error o dato truncado | La variable es `Entero`; no hay validación de tipo |

---

## 2. `ValidarEdad.psc` — `Ingreso_Discoteca`

**Qué hace:** pide edad y si tiene cédula (`S/N`). Si es mayor de edad **Y** tiene cédula, deja entrar y pide el método de pago.

**Variables lógicas:**

```
mayorEdad   <- edad >= 18
tieneCedula <- cedula = "S"
```

### 2.1 Tabla de verdad — ingreso

| `mayorEdad` | `tieneCedula` | `mayorEdad Y tieneCedula` | Mensajes que muestra |
|:--:|:--:|:--:|---|
| V | V | **V** | "Puedes ingresar a la discoteca" → menú de pago → "Bienvenido ala Discoteca" |
| V | F | F | "No puedes ingresar" + "Debes presentar tu cedula" |
| F | V | F | "No puedes ingresar" + "Debes ser mayor de edad" |
| F | F | F | "No puedes ingresar" + "Debes ser mayor de edad" + "Debes presentar tu cedula" |

### 2.2 Tabla de verdad — método de pago (solo si pasó el ingreso)

| `tipoPago` | Mensaje | ¿Muestra "Bienvenido"? |
|:--:|---|:--:|
| 1 | "Pago seleccionado: Efectivo" | Sí |
| 2 | "Pago seleccionado: Tarjeta" | Sí |
| cualquier otro | "Metodo de pago incorrecto" | **Sí** |

### Casos de borde

| Edad | Cédula | Resultado esperado | Qué se prueba |
|---:|:--:|---|---|
| 17 | S | No ingresa (menor) | Justo debajo del límite |
| **18** | S | Ingresa | Justo en el límite (`>=`) |
| 19 | S | Ingresa | Justo encima del límite |
| 18 | N | No ingresa (falta cédula) | Límite de edad + cédula inválida |
| 0 | S | No ingresa | Edad mínima |
| -1 | S | No ingresa | Edad negativa (no se valida, pero cae como menor) |
| 120 | S | Ingresa | Edad muy alta |
| 18 | `s` (minúscula) | Depende de la comparación de cadenas de tu PSeInt; probar | Sensibilidad a mayúsculas |
| 18 | `Si`, `SI`, `X`, vacío | No ingresa (≠ `"S"`) | Entradas que no son exactamente `S` |
| 18 | S, pago `0`, `3`, `-1` | Ingresa + "Metodo de pago incorrecto" + "Bienvenido" | Pago inválido |
| 18 | S, pago `1.5` o texto | Error de tipo (`tipoPago` es `Entero`) | Sin validación |

---

## 3. `ValidarRegistro.psc`

**Qué hace:** pide la edad; si es `>= 14` pide aceptar términos y condiciones (`S`) para validar el registro.

### Tabla de verdad

| `edad >= 14` | `condiciones == 'S'` | Salida |
|:--:|:--:|---|
| F | — (no se pregunta) | "Eres menor de lo permitido, Pa la house" |
| V | V | "Su edad es permitida" + "Registro valido" |
| V | F | "Su edad es permitida" + *(no muestra nada más)* |

### Casos de borde

| Edad | Términos | Resultado esperado | Qué se prueba |
|---:|:--:|---|---|
| 13 | — | Rechazado por edad | Justo debajo del límite |
| **14** | S | Registro válido | Justo en el límite (`>=`) |
| 15 | S | Registro válido | Justo encima |
| 14 | N | Solo "Su edad es permitida", **sin mensaje de rechazo** | Rechazo silencioso |
| 14 | `s` (minúscula) | Depende de la comparación de cadenas; probar | El mensaje pide minúscula pero el código compara con `'S'` |
| 14 | `Si`, `SI`, vacío | Sin mensaje de registro | Cualquier cosa distinta a `S` |
| 0 | — | Rechazado | Edad mínima |
| -5 | — | Rechazado (no hay validación de negativos) | Edad negativa |
| 200 | S | Registro válido (no hay límite superior) | Edad absurda |

---

## 4. `parqueadero.psc`

**Qué hace:** pide tipo de vehículo (1 = carro, 2 = moto) y minutos de estadía; calcula el cobro por hora (o fracción) con un tope de **$30.000**.

- Tarifa: carro **$4.000/hora**, moto **$2.000/hora**.
- Máximo permitido: **1440 min (24 h)**.
- Tope de cobro: **$30.000**.

### 4.1 Tabla de verdad — tipo de vehículo

| `tipo == 1` | `tipo == 2` | `tipo==1 O tipo==2` | `valorHora` / salida |
|:--:|:--:|:--:|---|
| V | F | V | 4000 (carro) |
| F | V | V | 2000 (moto) |
| F | F | F | "valor incorrecto" |
| V | V | — | imposible (una variable no puede valer 1 y 2) |

### 4.2 Tabla de verdad — minutos

| `minutos > 1440` | Salida |
|:--:|---|
| V | "no puede estar mas de 24 horas" |
| F | Calcula `horas`, `total` y lo muestra |

### 4.3 Tabla de tramos (minutos → horas cobradas → total)

Los `Si` son independientes y se evalúan en cadena: el último que se cumple sobrescribe `horas`.

| Minutos | `horas` | Carro | Moto (esperado) | Moto (**real** del código) |
|---|:--:|---:|---:|---:|
| 0 – 15 | 0 | $0 | $0 | $0 |
| 16 – 60 | 1 | $4.000 | $2.000 | $2.000 |
| 61 – 120 | 2 | $8.000 | $4.000 | $4.000 |
| 121 – 180 | 3 | $12.000 | $6.000 | $6.000 |
| 181 – 240 | 4 | $16.000 | $8.000 | $8.000 |
| 241 – 300 | 5 | $20.000 | $10.000 | $10.000 |
| 301 – 360 | 6 | $24.000 | $12.000 | $12.000 |
| 361 – 420 | 7 | $28.000 | $14.000 | $14.000 |
| 421 – 480 | 8 | $30.000 (tope) | $16.000 | $16.000 |
| 481 – 540 | 9 | $30.000 (tope) | $18.000 | $18.000 |
| **541 – 600** | **10** (el código asigna **100**) | $30.000 (tope) | $20.000 | **$30.000** |
| 601 – 660 | 11 | $30.000 (tope) | $22.000 | $22.000 |
| 661 – 720 | 12 | $30.000 (tope) | $24.000 | $24.000 |
| 721 – 780 | 13 | $30.000 (tope) | $26.000 | $26.000 |
| 781 – 840 | 14 | $30.000 (tope) | $28.000 | $28.000 |
| 841 – 1440 | 15 | $30.000 (tope) | $30.000 | $30.000 |
| > 1440 | — | Mensaje de error | Mensaje de error | Mensaje de error |

### Casos de borde

| Tipo | Minutos | Resultado real | Qué se prueba |
|:--:|---:|---|---|
| 1 | 0 | $0 | Entrada mínima |
| 1 | 15 | $0 | Justo en el límite de gracia (`> 15`, no `>=`) |
| 1 | 16 | $4.000 | Justo después de la gracia |
| 1 | 60 | $4.000 | Justo al cierre de la 1.ª hora |
| 1 | 61 | $8.000 | Pasa a la 2.ª hora |
| 2 | 120 / 121 | $4.000 / $6.000 | Límite 2.ª → 3.ª hora (moto) |
| 1 | 420 / 421 | $28.000 / $30.000 | Aquí el carro toca el tope |
| 2 | 540 | $18.000 | Último valor correcto antes del bug |
| 2 | **541** | **$30.000** (esperado $20.000) | Bug `horas <- 100` |
| 2 | 600 | **$30.000** (esperado $20.000) | Bug `horas <- 100` |
| 2 | 601 | $22.000 | Vuelve a la normalidad |
| 2 | 840 / 841 | $28.000 / $30.000 | Último tramo |
| 1 o 2 | 1440 | $30.000 | Límite máximo permitido (`> 1440`, no `>=`) |
| 1 o 2 | 1441 | "no puede estar mas de 24 horas" | Justo después del máximo |
| 1 o 2 | -10 | $0 (no hay validación de negativos) | Minutos negativos |
| 3 | cualquiera | "valor incorrecto" | Tipo fuera de rango |
| 0 / -1 | cualquiera | "valor incorrecto" | Tipo inválido |
| 1.5 / texto | — | Error de tipo (`Entero`) | Sin validación |

---

## 5. `semaforo_inventario.psc`

**Qué hace:** pide las unidades en inventario y muestra un semáforo.

| Rango | Color | Mensaje |
|---|---|---|
| `< 0` | — | "error, las unidades no pueden ser negativas" |
| `= 0` | ROJO | AGOTADO |
| `1 – 9` | AMARILLO | hay que pedir inventario |
| `>= 10` | VERDE | TODO BIEN |

### Tabla de verdad

| `unidades < 0` | `unidades = 0` | `unidades <= 9` | Salida |
|:--:|:--:|:--:|---|
| V | F | V | Error: unidades negativas |
| F | V | V | ROJO / AGOTADO |
| F | F | V | AMARILLO / hay que pedir inventario |
| F | F | F | VERDE / TODO BIEN |
| V | V | — | imposible (no puede ser `<0` y `=0` a la vez) |

### Casos de borde

| Unidades | Salida esperada | Qué se prueba |
|---:|---|---|
| -1 | Error | Primer valor inválido |
| -100 | Error | Negativo grande |
| **0** | ROJO / AGOTADO | Límite exacto entre error y rojo |
| **1** | AMARILLO | Primer valor amarillo |
| 5 | AMARILLO | Valor medio |
| **9** | AMARILLO | Último valor amarillo (`<= 9`) |
| **10** | VERDE | Primer valor verde |
| 11 | VERDE | Justo encima |
| 1000000 | VERDE | Valor muy grande |
| 9.5 / texto | Error de tipo (`Entero`) | Sin validación |

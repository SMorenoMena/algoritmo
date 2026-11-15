# Patrones de repetición y descomposición de problemas

**Actividad de algoritmia en PSeInt — Riwi**

Este repositorio contiene cinco algoritmos en PSeInt. Cuatro emplean ciclos y se analizan mediante **tablas de traza**; el quinto descompone la generación de una factura en **subprocesos**.

> Las entradas utilizadas en las tablas son ejemplos para seguir la ejecución; no están fijadas en los programas originales.

## Contenido

| Archivo | Estructura | Propósito |
|---|---|---|
| `Cajero_Parqueadero.psc` | `Mientras` | Acumular tarifas y contar carros. |
| `Calificaciones.psc` | `Para` y `Si` | Procesar cinco notas. |
| `ValidarPin.psc` | `Repetir...Hasta Que` y `Si` | Validar un PIN con máximo tres intentos. |
| `piramide.psc` | Ciclos `Para` anidados | Dibujar una pirámide de asteriscos. |
| `FacturaRestaurante.psc` | Subprocesos | Leer un pedido, calcular porcentajes e imprimir la factura. |

---

## 1. Cajero de parqueadero

**Archivo:** `Cajero_Parqueadero.psc`  
**Ciclo:** `Mientras tarifa > 0 Hacer`

### Lógica

Se inicializan `carro` y `total` en cero. Se lee una tarifa; mientras sea mayor que cero, se cuenta un carro, se acumula su tarifa y se solicita otra. El valor `0` detiene el ciclo y **no** se suma ni se cuenta como carro.

### Árbol de procesos

```text
Cajero_Parqueadero
├── Definir variables: carro, tarifa, total
├── Inicializar carro = 0 y total = 0
├── Leer primera tarifa
├── Mientras tarifa > 0
│   ├── Incrementar carro en 1
│   ├── Sumar tarifa a total
│   └── Leer siguiente tarifa
└── Mostrar total recaudado y carros ingresados
```

### Tabla de traza

**Entradas de ejemplo:** `5000`, `7000`, `3000`, `0`.

| Momento | Tarifa leída | `carro` | `total` | ¿Entra al ciclo? |
|---|---:|---:|---:|---|
| Inicial | 5000 | 0 | 0 | Sí |
| Tras iteración 1 | 7000 | 1 | 5000 | Sí |
| Tras iteración 2 | 3000 | 2 | 12000 | Sí |
| Tras iteración 3 | 0 | 3 | 15000 | No |

**Salida:** `Caja cerrada. Total: 15000` y `Carros ingresados: 3`.

---

## 2. Calificaciones

**Archivo:** `Calificaciones.psc`  
**Ciclo:** `Para i <- 1 Hasta 5 Hacer`

### Lógica

El programa pide exactamente cinco notas, las suma, cuenta como aprobada cada nota mayor o igual a `3` y activa `reprobado` cuando encuentra una nota menor que `3`. Después calcula `promedio <- suma / 5` y muestra los resultados.

### Árbol de procesos

```text
Calificaciones
├── Definir nota, suma, promedio, aprobados, i, reprobado
├── Inicializar suma = 0, aprobados = 0, reprobado = Falso
├── Para i = 1 hasta 5
│   ├── Leer nota
│   ├── Acumular suma = suma + nota
│   └── Si nota >= 3
│       ├── Sí: incrementar aprobados
│       └── No: reprobado = Verdadero
├── Calcular promedio = suma / 5
├── Mostrar suma, promedio y aprobados
└── Si reprobado
    ├── Sí: mostrar "Hay estudiantes reprobados"
    └── No: mostrar "Todos los estudiantes aprobaron"
```

### Tabla de traza

**Entradas de ejemplo:** `4`, `2`, `3.5`, `5`, `2.5`.

| `i` | `nota` | `suma` | `aprobados` | `reprobado` |
|---:|---:|---:|---:|---|
| Inicial | — | 0 | 0 | Falso |
| 1 | 4 | 4 | 1 | Falso |
| 2 | 2 | 6 | 1 | Verdadero |
| 3 | 3.5 | 9.5 | 2 | Verdadero |
| 4 | 5 | 14.5 | 3 | Verdadero |
| 5 | 2.5 | 17 | 3 | Verdadero |

**Salida:** suma `17`, promedio `3.4`, aprobados `3` y mensaje `Hay estudiantes reprobados`.

---

## 3. Validar PIN

**Archivo:** `ValidarPin.psc`  
**Ciclo:** `Repetir...Hasta Que acceso O intento = 3`

### Lógica

Se empieza con `acceso = Falso` e `intento = 0`. En cada repetición se lee un PIN y aumenta el contador. Si el PIN es `123`, `acceso` pasa a `Verdadero`. El ciclo finaliza cuando hay acceso o cuando se han realizado tres intentos.

### Árbol de procesos

```text
ValidarPin
├── Definir pin, acceso, intento
├── Inicializar acceso = Falso e intento = 0
├── Repetir
│   ├── Leer pin
│   ├── Incrementar intento
│   └── Si pin = 123
│       └── acceso = Verdadero
├── Hasta Que acceso O intento = 3
└── Si acceso
    ├── Sí: mostrar "Bienvenido"
    └── No: mostrar "Tarjeta bloqueada"
```

### Tabla de traza

**Entradas de ejemplo:** `111`, `222`, `123`.

| Iteración | `pin` | `intento` | `acceso` | ¿Se cumple la condición de salida? |
|---:|---:|---:|---|---|
| Inicial | — | 0 | Falso | — |
| 1 | 111 | 1 | Falso | No |
| 2 | 222 | 2 | Falso | No |
| 3 | 123 | 3 | Verdadero | Sí |

**Salida:** `Bienvenido`.

**Caso alternativo:** si se ingresan tres PIN incorrectos, la salida es `Tarjeta bloqueada`.

---

## 4. Pirámide

**Archivo:** `piramide.psc`  
**Ciclos:** tres `Para`: uno exterior para las filas y dos interiores para espacios y asteriscos.

### Lógica

El usuario ingresa la altura `altu`. Para cada `fila`, el primer ciclo interior escribe `altu - fila` espacios y el segundo escribe `2 * fila - 1` asteriscos. `Escribir ""` pasa a la siguiente línea. En el archivo original, la variable `espacio` se reutiliza como contador de ambos ciclos interiores.

### Árbol de procesos

```text
piramide
├── Definir altu, fila, espacio
├── Leer altu
└── Para fila = 1 hasta altu
    ├── Para espacio = 1 hasta altu - fila
    │   └── Escribir un espacio sin salto de línea
    ├── Para espacio = 1 hasta 2 * fila - 1
    │   └── Escribir "*" sin salto de línea
    └── Escribir salto de línea
```

### Tabla de traza por fila

**Entrada de ejemplo:** `altu = 4`.

| `fila` | `altu - fila` (espacios) | `2 * fila - 1` (asteriscos) | Línea generada |
|---:|---:|---:|---|
| 1 | 3 | 1 | `   *` |
| 2 | 2 | 3 | `  ***` |
| 3 | 1 | 5 | ` *****` |
| 4 | 0 | 7 | `*******` |

**Salida:**

```text
   *
  ***
 *****
*******
```

**Patrón:** al bajar una fila, los espacios disminuyen en uno y los asteriscos aumentan en dos.

---

## 5. Factura del restaurante

**Archivo:** `FacturaRestaurante.psc`  
**Estructura:** descomposición en tres subprocesos. Este archivo **no utiliza ciclos**.

### Lógica

El algoritmo principal declara `subtotal`, `impuesto` y `propina`, solicita el valor del pedido, calcula el 8 % de impuesto y el 10 % de propina mediante el **mismo subproceso**, y luego imprime la factura. En este ejercicio, el total incluye la propina sugerida; en la práctica, la propina es voluntaria.

### Árbol de componentes y llamadas

```text
FacturaRestaurante (algoritmo principal)
├── LeerPedido(subtotal)
│   ├── Solicitar valor del pedido
│   └── Leer subtotal (Por Referencia)
├── CalcularPorcentaje(subtotal, 8, impuesto)
│   └── impuesto = subtotal * 8 / 100
├── CalcularPorcentaje(subtotal, 10, propina)
│   └── propina = subtotal * 10 / 100
└── ImprimirFactura(subtotal, impuesto, propina)
    ├── total = subtotal + impuesto + propina
    └── Mostrar subtotal, impuesto, propina y total
```

> `CalcularPorcentaje` aparece dos veces en el árbol porque **se llama dos veces**, no porque existan dos subprocesos distintos.

### Tabla de seguimiento

**Entrada de ejemplo:** `subtotal = 50000`.

| Paso | Subproceso | Operación | Valor obtenido |
|---:|---|---|---:|
| 1 | `LeerPedido` | Leer subtotal | 50000 |
| 2 | `CalcularPorcentaje` | `50000 * 8 / 100` | Impuesto = 4000 |
| 3 | `CalcularPorcentaje` | `50000 * 10 / 100` | Propina = 5000 |
| 4 | `ImprimirFactura` | `50000 + 4000 + 5000` | Total = 59000 |

**Salida:**

```text
==========================
FACTURA RESTAURANTE
==========================
Subtotal: $50000
Impuesto 8%: $4000
Propina 10%: $5000
--------------------------
TOTAL: $59000
==========================
```

### Parámetros de los subprocesos

| Subproceso | Parámetros | Función |
|---|---|---|
| `LeerPedido` | `subtotal Por Referencia` | Modificar el subtotal del algoritmo principal. |
| `CalcularPorcentaje` | `base`, `porcentaje`, `resultado Por Referencia` | Calcular y entregar un porcentaje. |
| `ImprimirFactura` | `subtotal`, `impuesto`, `propina` | Calcular el total local e imprimir la factura. |

---

## Conclusión

Los ejercicios muestran distintos patrones de repetición: `Mientras` repite mientras una condición sea verdadera; `Para` recorre una cantidad determinada de iteraciones; `Repetir...Hasta Que` ejecuta el bloque al menos una vez; y los ciclos anidados permiten generar patrones como una pirámide. Las tablas de traza permiten observar cómo cambian las variables en cada iteración.

La factura muestra la **descomposición de problemas**: el algoritmo principal coordina subprocesos con responsabilidades específicas. Esta organización facilita leer, mantener y reutilizar el código.

## Cómo ejecutar

1. Abrir **PSeInt**.
2. Abrir cualquiera de los archivos `.psc`.
3. Ejecutar el algoritmo.
4. Ingresar los valores solicitados y comparar la salida con las tablas de ejemplo.

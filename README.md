# Correciones Prolog

## Corrección golpear

```prolog
% completarFilaGolpeada(+Tablero, +?Nuevo, +NumFila, +NumColumna)
% completarFilaGolpeada llena la fila golpeada de Nuevo con contenido de Tablero, teniendo en cuenta
% que fue golpeado en NumFila, NumColumna
completarFilaGolpeada(Tablero, Nuevo, NumFila, NumColumna) :- nth1(NumFila, Tablero, FilaGolpeada), nth1(NumFila, Nuevo, FilaGolpeadaNuevo), Col is NumColumna - 1, append(F1, [_|F2], FilaGolpeada), length(F1, Col), append(F1, [~|F2], FilaGolpeadaNuevo).

% llenarLibresCon(+Tablero, +?Nuevo, +NumFila, +NumColumna)
% llenarLibresCon llena el nuevo tablero con el contenido de Tablero, teniendo en cuenta
% que fue golpeado en NumFila, NumColumna
llenarLibresCon(Tablero, Nuevo, NumFila, NumColumna) :- completarFilaGolpeada(Tablero, Nuevo, NumFila, NumColumna), F is NumFila - 1, append(F1, [|F2], Tablero), length(F1, F), append(F1, [|F2], Nuevo).

%golpear(+Tablero, +NumFila, +NumColumna, -NuevoTab)
golpear(Tablero, NumFila, NumColumna, Nuevo) :- matriz(Tablero, FMax, CMax), matriz(Nuevo, FMax, CMax), contenido(Nuevo, NumFila, NumColumna, ~), llenarLibresCon(Tablero, Nuevo, NumFila, NumColumna).
```

Después

```prolog
%reemplazarEn(+Pos, +XS, ?YS, ?X, ?Y)
% tiene éxito si XS e YS son dos listas iguales salvo por el elemento
% en la posición Pos, que será X para el caso de XS e Y para YS.
% Si X no está instanciada, se instanciará con el elemento en Pos de X.
% Si YS no está instanciada, se instanciará con una lista igual a XS, salvo en Pos
% donde tendrá la variable libre Y (en caso de no estar instanciada Y) o el valor de Y.
reemplazarEn(Pos, XS, YS, X, Y) :- PrimeraMitad is Pos - 1, length(XS1, PrimeraMitad), append(XS1, [X|XS2], XS), append(XS1, [Y|XS2], YS).

%golpear(+Tablero, +NumFila, +NumColumna, ?NuevoTab)
% En esta implementación NuevoTab es reversible: el predicado
% reemplazarEn lo soporta. Si Nuevo está intanciado, no generará problemas.
golpear(Tablero, NumFila, NumColumna, Nuevo) :- reemplazarEn(NumFila, Tablero, Nuevo, FilaT, FilaN), reemplazarEn(NumColumna, FilaT, FilaN, _, ~).
```

## Corrección atacar

```prolog
%atacar(+Tablero, ?NumFila, ?NumColumna, ?Resultado, -NuevoTab)
% NuevoTab no puede estar instanciado por las restricciones del predicado golpear
```

Después

```prolog
% Tablero debe estar instanciado por las restricciones de golpear, que requiere un Tablero instanciado.

% Como la implementación del predicado golpear soporta que Nuevo sea reversible, y únicamente se usar en este predicado,
% NuevoTab podría estar instanciado. Entonces, es reversible.
```

## Consulta barcos

```prolog
direccion(horizontal).
direccion(vertical).

%proxima(+Direccion, +Tablero, +Fila, +Columna, ?ProximaFila, ?ProximaColumna)
% tiene éxito si ProximaFila y ProximaColumna son las posiciones de la próxima celda,
% en direccion Direccion, desde [Fila,Columna], y están en rango
proxima(vertical, Tablero, F, C, F1, C) :- F1 is F + 1, enRango(Tablero, F1, C).
proxima(horizontal, Tablero, F, C, F, C1) :- C1 is C + 1, enRango(Tablero, F, C1).

%puedoColocar(+CantPiezas, ?Direccion, +Tablero, ?Fila, ?Columna)
puedoColocar(1, Dir, Tablero, F, C) :- direccion(Dir), disponible(Tablero, F, C).
puedoColocar(Piezas, Dir, Tablero, F, C) :- direccion(Dir), Piezas > 1, Faltantes is Piezas - 1, disponible(Tablero, F, C), proxima(Dir, Tablero, F, C, FProx, CProx), puedoColocar(Faltantes, Dir, Tablero, FProx, CProx).

%ubicarBarco(+CantPiezas, +Direccion, +?Tablero, +Fila, +Columna)
% ubicarBarco ubica un barco de CantPiezas, dadas una dirección, una fila y una columna,
% en un tablero parcialmente instanciado. No se verifica que es posible colocar un barco
ubicarBarco(1, _, Tablero, F, C) :- barco(Tablero, F, C).
ubicarBarco(Piezas, Dir, Tablero, F, C) :- barco(Tablero, F, C), Piezas > 1, Faltantes is Piezas - 1, proxima(Dir, Tablero, F, C, FProx, CProx), ubicarBarco(Faltantes, Dir, Tablero, FProx, CProx).

%ubicarBarcoEn(+?Tablero, +CantPiezas)
% ubica un barco de CantPiezas en un tablero parcialmente instanciado.
% Nota: sin separar este caso, usando puedoColocar se obtienen soluciones repetidas
ubicarBarcoEn(Tablero, 1) :- disponible(Tablero, F, C), barco(Tablero, F, C).
ubicarBarcoEn(Tablero, CantPiezas) :- CantPiezas > 1, puedoColocar(CantPiezas, Dir, Tablero, F, C), ubicarBarco(CantPiezas, Dir, Tablero, F, C).

%ubicarBarcos(+Barcos, +?Tablero)
ubicarBarcos(Barcos, Tablero) :- maplist(ubicarBarcoEn(Tablero), Barcos).
```

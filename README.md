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
% Como la implementación del predicado golpear soporta que Nuevo sea reversible, y únicamente se usar en este predicado,
% NuevoTab podría estar instanciado. Entonces, es reversible.
```

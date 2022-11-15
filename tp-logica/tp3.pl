%------------------Predicados predefinidos:------------------%

%fliplength(?Longitud, ?Lista)
fliplength(N, L) :- length(L, N).

%matriz(?Matriz, ?Filas, ?Columnas)
matriz(M, F, C) :- length(M, F), maplist(fliplength(C), M).

%dif1(+N1, ?N2)
dif1(N1, N2) :- N2 is N1 + 1.
dif1(N1, N2) :- N2 is N1 - 1.

%adyacente(+F1, +C1, ?F2, ?C2)
adyacente(F1,C1,F1,C2) :- dif1(C1,C2).
adyacente(F1,C1,F2,C1) :- dif1(F1,F2).
adyacente(F1,C1,F2,C2) :- dif1(C1,C2), dif1(F1,F2).

%enRango(+Matriz, +Fila, +Columna)
enRango([Fila|Filas], F, C) :- F > 0, C > 0, length([Fila|Filas], FMax), F =< FMax, length(Fila, CMax), C =< CMax.

%adyacenteEnRango(+Tablero, +F1, +C1, ?F2, ?C2)
adyacenteEnRango(T,F1,C1,F2,C2) :- adyacente(F1,C1,F2,C2), enRango(T,F2,C2).

%------------------Predicados a definir:------------------%

%contenido(+?Tablero, ?Fila, ?Columna, ?Contenido)
contenido(T, F, C, E) :- nth1(F, T, Fila), nth1(C, Fila, E).

%disponible(+Tablero, ?Fila, ?Columna)
disponible(T, F, C) :- disponibleCelda(T, F, C), not(algunaAdyacenteOcupada(T, F, C)).

%disponibleCelda(+Tablero, ?Fila, ?Columna)
% disponibleCelda tiene éxito si la celda tiene una variable no instanciada. 
disponibleCelda(T, F, C) :- contenido(T, F, C, E), var(E).

%algunaAdyacenteOcupada(+Tablero, +Fila, +Columna)
% algunaAdyacenteOcupada tiene éxito si alguna celda adyacente a T[F, C] está ocupada.
algunaAdyacenteOcupada(T, F, C) :- adyacenteEnRango(T, F, C, F1, C1), not(disponibleCelda(T, F1, C1)).

%puedoColocar(+CantPiezas, ?Direccion, +Tablero, ?Fila, ?Columna)
puedoColocar(1, _, T, F, C) :- disponible(T, F, C).
puedoColocar(P, D, T, F, C) :- nonvar(D), P > 1, P1 is P - 1, disponible(T, F, C), proxima(D, T, F, C, FProx, CProx), puedoColocar(P1, D, T, FProx, CProx).
puedoColocar(P, D, T, F, C) :- var(D), D = horizontal, puedoColocar(P, D, T, F, C).
puedoColocar(P, D, T, F, C) :- var(D), D = vertical,  puedoColocar(P, D, T, F, C).

%proxima(+Direccion, +Tablero, +Fila, +Columna, ?ProximaFila, ?ProximaColumna)
% tiene éxito si ProximaFila y ProximaColumna son las posiciones de la próxima celda,
% en direccion Direccion, desde [Fila,Columna], y están en rango
proxima(vertical, T, F, C, F1, C) :- F1 is F + 1, enRango(T, F1, C).
proxima(horizontal, T, F, C, F, C1) :- C1 is C + 1, enRango(T, F, C1).

%ubicarBarcos(+Barcos, +?Tablero)

%completarConAgua(+?Tablero)

%golpear(+Tablero, +NumFila, +NumColumna, -NuevoTab)

% Completar instanciación soportada y justificar.
%atacar(Tablero, Fila, Columna, Resultado, NuevoTab)

%------------------Tests:------------------%

test(1) :- matriz(M,2,3), adyacenteEnRango(M,2,2,2,3).
test(2) :- matriz(M,2,3), setof((F,C), adyacenteEnRango(M,1,1,F,C), [ (1, 2), (2, 1), (2, 2)]).

% Tests contenido
test(3) :- contenido([[o, _], [_, _]], 1, 1, o).
test(4) :- contenido([[_, _], [_, o]], 2, 2, o).
test(5) :- contenido([[X, Y], [x, o]], _, _, o), X = o, Y = o.
test(6) :- setof(C, contenido([[o, x, o], [o, o, x]], 1, C, o), [1, 3]).
test(7) :- setof((C,E), contenido([[o, x, o], [o, o, x]], 2, C, E), [ (1, o), (2, o), (3, x) ]).
test(8) :- setof(F, contenido([[o, x, o], [o, o, x]], F, 1, o), [ 1, 2 ]).
test(9) :- setof((F,C,E), contenido([[o, _, x], [o, _, _]], F, C, E), [(1, 1, o), (1, 2, _), (1, 3, x), (2, 1, o), (2, 2, _), (2, 3, _)]).

% Tests disponible
test(10) :- not(disponibleCelda([[o, _], [_, _]], 1, 1)).
test(11) :- disponibleCelda([[o, _], [_, _]], 2, 1).
test(12) :- setof((F,C), disponibleCelda([[o, _], [_, x]], F, C), [ (1, 2), (2, 1) ]).

test(13) :- algunaAdyacenteOcupada([[_, _, _], [o, _, _], [_, _, _]], 2, 2).
test(14) :- not(algunaAdyacenteOcupada([[_, _, _], [_, o, _], [_, _, _]], 2, 2)).

test(15) :- not(disponible([[_, _, _], [_, o, _], [_, _, _]], 2, 2)).
test(16) :- not(disponible([[o, _, _], [_, _, _], [_, _, _]], 2, 2)).
test(17) :- matriz(M,3,3), disponible(M, 2, 2).
test(18) :- setof((F, C), (matriz(M,2,2), disponible(M, F, C)), [(1,1), (1,2), (2,1), (2,2)]).

% Tests puedoColocar
test(19) :- matriz(M,3,3), proxima(vertical, M, 1, 1, F, C), F is 2, C is 1.
test(20) :- matriz(M,3,3), proxima(horizontal, M, 2, 2, F, C), F is 2, C is 3.
test(21) :- matriz(M,3,3), not(proxima(horizontal, M, 3, 3, _, _)).
test(22) :- matriz(M,3,3), not(proxima(vertical, M, 3, 3, _, _)).

test(23) :- matriz(M,3,3), puedoColocar(1, horizontal, M, 1, 1).
test(24) :- matriz(M,3,3), puedoColocar(2, horizontal, M, 2, 2).
test(25) :- matriz(M,3,3), puedoColocar(2, vertical, M, 2, 2).
test(26) :- matriz(M,3,3), not(puedoColocar(3, vertical, M, 2, 2)).
test(27) :- matriz(M,2,4), setof((Dir, F, C), puedoColocar(3,Dir,M,F,C), [(horizontal,1,1), (horizontal,1,2), (horizontal,2,1), (horizontal,2,2)]).
test(28) :- matriz(M,2,3), contenido(M,2,1,o), setof((Dir, F, C), puedoColocar(2,Dir,M,F,C), [(vertical,1,3)]).


tests :- forall(between(1,28,N), test(N)). % Cambiar el 2 por la cantidad de tests que tengan.
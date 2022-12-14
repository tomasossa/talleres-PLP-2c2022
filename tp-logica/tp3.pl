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
contenido(Tablero, F, C, Contenido) :- nth1(F, Tablero, Fila), nth1(C, Fila, Contenido).

%barco(+?Tablero, ?Fila, ?Columna)
% Como contenido, pero fijado el átomo correspondiente a un barco
barco(Tablero, F, C) :- contenido(Tablero, F, C, o).

%agua(+?Tablero, ?Fila, ?Columna)
% Como contenido, pero fijado el átomo correspondiente a agua
agua(Tablero, F, C) :- contenido(Tablero, F, C, ~).

%disponibleCelda(+Tablero, ?Fila, ?Columna)
% disponibleCelda tiene éxito si la celda tiene una variable no instanciada. 
disponibleCelda(Tablero, F, C) :- contenido(Tablero, F, C, Contenido), var(Contenido).

%algunaAdyacenteOcupada(+Tablero, +Fila, +Columna)
% algunaAdyacenteOcupada tiene éxito si alguna celda adyacente a T[F, C] está ocupada.
algunaAdyacenteOcupada(Tablero, F, C) :- adyacenteEnRango(Tablero, F, C, F1, C1), not(disponibleCelda(Tablero, F1, C1)).

%disponible(+Tablero, ?Fila, ?Columna)
disponible(Tablero, F, C) :- disponibleCelda(Tablero, F, C), not(algunaAdyacenteOcupada(Tablero, F, C)).


direccion(horizontal).
direccion(vertical).

%saltarA(+Direccion, +Salto, +Fila, +Columna, ?ProximaFila, ?ProximaColumna)
% tiene éxito si ProximaFila y ProximaColumna son las posiciones de la celda desde (Fila,Columna),
% en la dirección Direccion con un salto de Salto
saltarA(vertical, Salto, F, C, F1, C) :- F1 is F + Salto.
saltarA(horizontal, Salto, F, C, F, C1) :- C1 is C + Salto.

%saltos(+Piezas, +Direccion, +Fila, +Columna, ?ProximaFila, ?ProximaColumna)
% instancia en ProximaFila y ProximaColumna todas las posiciones que cubriría
% un barco de Piezas, en la dirección Direccion, empezando en (Fila, Columna)
saltos(Piezas, Dir, F, C, FProx, CProx) :- Saltos is Piezas - 1, between(0, Saltos, Salto), saltarA(Dir, Salto, F, C, FProx, CProx).

%puedoColocar(+CantPiezas, ?Direccion, +Tablero, ?Fila, ?Columna)
puedoColocar(Piezas, Dir, Tablero, F, C) :- direccion(Dir), disponible(Tablero, F, C), forall(saltos(Piezas, Dir, F, C, FProx, CProx), disponible(Tablero, FProx, CProx)).

%ubicarBarcoEn(+?Tablero, +Piezas)
% ubica un barco de Piezas en un tablero parcialmente instanciado.
% Nota: sin separar el caso Piezas = 1, usando puedoColocar se obtienen soluciones repetidas
ubicarBarcoEn(Tablero, 1) :- disponible(Tablero, F, C), barco(Tablero, F, C).
ubicarBarcoEn(Tablero, Piezas) :- Piezas > 1, puedoColocar(Piezas, Dir, Tablero, F, C), foreach(saltos(Piezas, Dir, F, C, FProx, CProx), barco(Tablero, FProx, CProx)).

%ubicarBarcos(+Barcos, +?Tablero)
ubicarBarcos(Barcos, Tablero) :- maplist(ubicarBarcoEn(Tablero), Barcos).

%completarFilaConAgua(+Fila)
% Completa la fila con el átomo correspondiente al átomo de agua.
completarFilaConAgua([]).
completarFilaConAgua([Celda|Celdas]) :- nonvar(Celda), completarFilaConAgua(Celdas).
completarFilaConAgua([Celda|Celdas]) :- var(Celda), Celda = ~, completarFilaConAgua(Celdas).

%completarConAgua(+?Tablero)
completarConAgua(Tablero) :- maplist(completarFilaConAgua, Tablero).

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
% Nota: ver tests 41 y 42
golpear(Tablero, NumFila, NumColumna, Nuevo) :- reemplazarEn(NumFila, Tablero, Nuevo, FilaT, FilaN), reemplazarEn(NumColumna, FilaT, FilaN, _, ~).


%tocado(+Tablero, +NumFila, +NumColumna)
% Es verdadero cuando el barco que tiene una parte en (NumFila, NumColumna) no está hundido,
% teniendo en cuenta que fue golpeado en (NumFila, NumColumna)
tocado(Tablero, NumFila, NumColumna) :- adyacenteEnRango(Tablero, NumFila, NumColumna, F, C), barco(Tablero, F, C).

% Completar instanciación soportada y justificar.
%atacar(+Tablero, ?NumFila, ?NumColumna, ?Resultado, ?NuevoTab)
% NumFila y NumColumna podrían no estar intanciados, porque contenido (usando en 'agua' y 'barco') lo soporta e instancia fila y columna en caso de no estarlo.
% Como es lo primero que se consulta en cada caso, no habría error con los próximos predicados.
% Resultado podría estar instanciado: como atacar está definido por casos en Resultado, se unificará con el átomo correspondiente, sin errores.
% Como la implementación del predicado golpear soporta que Nuevo sea reversible, y únicamente se usar en este predicado,
% NuevoTab podría estar instanciado. Entonces, es reversible.
% Tablero debe estar instanciado: si no lo estuviera es posible que algunas consultas no terminen.
% Por ejemplo, probar 'atacar(T, F, C, R, [[o, o], [~, ~]]).'. Prolog entrará por el primer caso, Resultado = agua. El predicado agua
% generará infinitos tableros con un átomo de agua y al seguir con el predicado golpear siempre se obtendrá falso. De esta forma, el 
% predicado agua seguirá generando tableros que nunca cumplirán con golpear, sin parar.
% Entonces, Tablero debe estar instanciado.
atacar(Tablero, NumFila, NumColumna, agua, Nuevo) :- agua(Tablero, NumFila, NumColumna), golpear(Tablero, NumFila, NumColumna, Nuevo).
atacar(Tablero, NumFila, NumColumna, tocado, Nuevo) :- barco(Tablero, NumFila, NumColumna), tocado(Tablero, NumFila, NumColumna), golpear(Tablero, NumFila, NumColumna, Nuevo).
atacar(Tablero, NumFila, NumColumna, hundido, Nuevo) :- barco(Tablero, NumFila, NumColumna), not(tocado(Tablero, NumFila, NumColumna)), golpear(Tablero, NumFila, NumColumna, Nuevo).

%------------------Tests:------------------%

%ocupadaPor(+Tablero, +Fila, +Columna, +Contenido)
% ocupadaPor tiene éxito si el tablero tiene el contenido de Contenido en Fila y Columna.
ocupadaPor(T, F, C, E) :- not(disponibleCelda(T, F, C)), contenido(T, F, C, E).

ocupadaPorBarco(T, F, C) :- ocupadaPor(T, F, C, o).
ocupadaPorAgua(T, F, C) :- ocupadaPor(T, F, C, ~).

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
test(19) :- saltarA(vertical, 1, 2, 2, F, C), F is 3, C is 2.
test(20) :- saltarA(horizontal, 2, 1, 1, F, C), F is 1, C is 3.
test(21) :- setof((F, C), saltos(2, vertical, 3, 4, F, C), [(3,4), (4,4)]).
test(22) :- setof((F, C), saltos(1, horizontal, 2, 5, F, C), [(2,5)]).

test(23) :- matriz(M,3,3), puedoColocar(1, horizontal, M, 1, 1).
test(24) :- matriz(M,3,3), puedoColocar(2, horizontal, M, 2, 2).
test(25) :- matriz(M,3,3), puedoColocar(2, vertical, M, 2, 2).
test(26) :- matriz(M,3,3), not(puedoColocar(3, vertical, M, 2, 2)).
test(27) :- matriz(M,2,4), setof((Dir, F, C), puedoColocar(3,Dir,M,F,C), [(horizontal,1,1), (horizontal,1,2), (horizontal,2,1), (horizontal,2,2)]).
test(28) :- matriz(M,2,3), contenido(M,2,1,o), setof((Dir, F, C), puedoColocar(2,Dir,M,F,C), [(vertical,1,3)]).
test(29) :- matriz(M,2,2), setof(Dir, puedoColocar(1, Dir, M, 1, 1), [horizontal, vertical]).

% Tests ubicarBarcos
test(30) :- matriz(M,3,3), contenido(M, 1, 1, o), ocupadaPor(M, 1, 1, o).
test(31) :- matriz(M,3,3), contenido(M, 1, 1, o), not(ocupadaPor(M, 1, 1, x)).
test(32) :- matriz(M,3,3), not(ocupadaPor(M, 1, 1, o)).

test(33) :- matriz(M,3,2), ubicarBarcos([2,1],M), ocupadaPorBarco(M, 1, 1), ocupadaPorBarco(M, 1, 2), ocupadaPorBarco(M, 3, 1).
test(34) :- matriz(M,3,2), ubicarBarcos([2,1],M), ocupadaPorBarco(M, 1, 1), ocupadaPorBarco(M, 1, 2), ocupadaPorBarco(M, 3, 2).
test(35) :- matriz(M,3,2), ubicarBarcos([2,1],M), ocupadaPorBarco(M, 1, 1), ocupadaPorBarco(M, 3, 1), ocupadaPorBarco(M, 3, 2).
test(36) :- matriz(M,3,2), ubicarBarcos([2,1],M), ocupadaPorBarco(M, 1, 2), ocupadaPorBarco(M, 3, 1), ocupadaPorBarco(M, 3, 2).

% Tests completarConAgua
test(37) :- T = [[o, o], [_, _], [_, o]], completarConAgua(T), ocupadaPorAgua(T, 2, 1), ocupadaPorAgua(T, 2, 2), ocupadaPorAgua(T, 3, 1).
% para testear que no haya repetidos:
test(38) :- bagof(X, (T = [[o, o], [~, X], [~, o]], completarConAgua(T)), [~]).

% Tests golpear
test(39) :- golpear([[o, o], [~, ~], [~, o]], 2, 2, M), ocupadaPorBarco(M, 1, 1), ocupadaPorBarco(M, 1, 2), ocupadaPorAgua(M, 2, 1), ocupadaPorAgua(M, 2, 2), ocupadaPorAgua(M, 3, 1), ocupadaPorBarco(M, 3, 2).
test(40) :- golpear([[o, o], [~, ~], [~, o]], 1, 2, M), ocupadaPorBarco(M, 1, 1), ocupadaPorAgua(M, 1, 2), ocupadaPorAgua(M, 2, 1), ocupadaPorAgua(M, 2, 2), ocupadaPorAgua(M, 3, 1), ocupadaPorBarco(M, 3, 2).
test(41) :- golpear([[o, o], [~, ~], [~, o]], 3, 2, [[o, o], [~, ~], [~, ~]]).
test(42) :- not(golpear([[o, o], [~, ~], [~, o]], 3, 2, [[o, o], [~, ~], [~, o]])).

% Tests atacar
test(43) :- setof((Res, T), atacar([[o, o], [~, ~], [~, o]], 1, 1, Res, T), [(tocado, [[~, o], [~, ~], [~, o]])]).
test(44) :- setof((Res, T), atacar([[o, o], [~, ~], [~, o]], 3, 1, Res, T), [(agua, [[o, o], [~, ~], [~, o]])]).
test(45) :- setof((Res, T), atacar([[o, o], [~, ~], [~, o]], 3, 2, Res, T), [(hundido, [[o, o], [~, ~], [~, ~]])]).
test(46) :- setof((F, C), atacar([[o, o], [~, ~], [~, o]], F, C, agua, _), [(2, 1), (2, 2), (3,1)]).
test(47) :- atacar([[o, o], [~, ~], [~, o]], 3, 2, hundido, [[o, o], [~, ~], [~, ~]]).


tests :- forall(between(1,47,N), test(N)).

// Definiciones globales (no modificar acá, en cambio, completar las secciones "Ejercicio i")
let val1 = {p: true, q: true, r: true};
let val2 = {p: false, q: false, r: false};
let val3 = {p: false, q: true, r: true};
let val4 = {p: false, q: false, r: true};
let val5 = {p: true, q: false, r: true};
let val6 = {p: true, q: false, r: false};
let val7 = {p: false, q: true, r: false};
let val8 = {p: true, q: true, r: false};
let val9 = {a: 1+1==2, b: false=="", c: false===""};
let val10 = {p: true, q: false, z: true};
let val11 = Object.create(val7);
let mal1 = {p: true, q: 1, r: true};
let mal2 = {p: true, q: true, r: 0};
let mal3 = Object.create(mal2);

let v = (nombre) => new VarProp(nombre);
let no = (prop) => new Negacion(prop);
let y = (izq, der) => new OperacionBinaria("&and;", (x, y) => x && y, izq, der);
let o = (izq, der) => new OperacionBinaria("&or;", (x, y) => x || y, izq, der);

function setUnion(setA, setB) {
  let res = new Set(setA);//Constructor por copia predefinido.

  for (const element of setB) {
    res.add(element);
  }

  return res;
}

const eqSet = (xs, ys) =>
    xs.size === ys.size &&
    [...xs].every((x) => ys.has(x));


function apply(f, a, b) { //Pueden usar apply(f, a) o apply(f, a, b).
    return (b === undefined) ? f.call({}, a) : f.call({}, a, b);
}

// Ejercicio 1
function esValuacion(val) {
  for (const clave in val) {
    let valor = val[clave];
    if(valor !== true && valor !== false){
      return false;
    }
  }
  return true;
}

// Ejercicio 2
function union(v1, v2) {
  let resultado = {};
  copiarValores(resultado, v2);
  copiarValores(resultado, v1);

  return resultado;
}

function copiarValores(destino, origen) {
  for (const clave in origen) {
    destino[clave] = origen[clave];
  }
}

// Ejercicio 3
function VarProp(nombre) {
  this.nombre = nombre;
}

function Negacion(prop) {
  this.prop = prop;
}

function OperacionBinaria(operador, f, izq, der) {
  this.operador = operador;
  this.f = f;
  this.izq = izq;
  this.der = der;
}

VarProp.prototype.toString = function() {
  return this.nombre;
}

Negacion.prototype.toString = function() {
  return "&not;" + this.prop.toString();
}

OperacionBinaria.prototype.toString = function() {
  return "(" + this.izq.toString() + " " + this.operador + " " + this.der.toString() + ")";
}

// Ejercicio 4

    
// Ejercicio 5

    
// Ejercicio 6


//Tests

function testEjemplo(res) {
  res.write("\n|| Probando la suma ||\n");
  let sumando1 = 4;
  let sumando2 = 6;
  let resultado_obtenido = sumando1 + sumando2;
  let resultado_esperado = 10;
  res.write("El resultado de sumar " + sumando1 + " y " + sumando2 + " da " + resultado_obtenido, (resultado_obtenido===resultado_esperado));
  sumando1 = "4";
  sumando2 = "6";
  resultado_obtenido = sumando1 + sumando2;
  resultado_esperado = "10";
  res.write("El resultado de sumar " + sumando1 + " y " + sumando2 + " da " + resultado_obtenido, (resultado_obtenido===resultado_esperado));
  sumando1 = 4;
  sumando2 = undefined;
  resultado_obtenido = sumando1 + sumando2;
  res.write("El resultado de sumar " + sumando1 + " y " + sumando2 + " da " + resultado_obtenido);
}

// Test Ejercicio 1
function testEjercicio1(res) {
    let val1Si = esValuacion(val1);
    let val2Si = esValuacion(val2);
    let val3Si = esValuacion(val3);
    let val4Si = esValuacion(val4);
    let val5Si = esValuacion(val5);
    let val6Si = esValuacion(val6);
    let val7Si = esValuacion(val7);
    let val8Si = esValuacion(val8);
    let val9Si = esValuacion(val9);
    let val10Si = esValuacion(val10);
    let val11Si = esValuacion(val11);
    let mal1No = esValuacion(mal1);
    let mal2No = esValuacion(mal2);
    let mal3No = esValuacion(mal3);
	res.write(`val1 ${si_o_no(val1Si)} es una valuaci&oacute;n.`, val1Si);
	res.write(`val2 ${si_o_no(val2Si)} es una valuaci&oacute;n.`, val2Si);
	res.write(`val3 ${si_o_no(val3Si)} es una valuaci&oacute;n.`, val3Si);
	res.write(`val4 ${si_o_no(val4Si)} es una valuaci&oacute;n.`, val4Si);
	res.write(`val5 ${si_o_no(val5Si)} es una valuaci&oacute;n.`, val5Si);
	res.write(`val6 ${si_o_no(val6Si)} es una valuaci&oacute;n.`, val6Si);
	res.write(`val7 ${si_o_no(val7Si)} es una valuaci&oacute;n.`, val7Si);
	res.write(`val8 ${si_o_no(val8Si)} es una valuaci&oacute;n.`, val8Si);
	res.write(`val9 ${si_o_no(val9Si)} es una valuaci&oacute;n.`, val9Si);
	res.write(`val10 ${si_o_no(val10Si)} es una valuaci&oacute;n.`, val10Si);
	res.write(`val11 ${si_o_no(val11Si)} es una valuaci&oacute;n.`, val11Si);
	res.write(`mal1 ${si_o_no(mal1No)} es una valuaci&oacute;n.`, !mal1No);
	res.write(`mal2 ${si_o_no(mal2No)} es una valuaci&oacute;n.`, !mal2No);
	res.write(`mal3 ${si_o_no(mal3No)} es una valuaci&oacute;n.`, !mal3No);
}

// Test Ejercicio 2
function testEjercicio2(res) {
  let union19 = union(val1, val9);
  let union310 = union(val3, val10);
  let union1011 = union(val10, val11);
  let union1110 = union(val11, val10);
  let val1tienea = val1.a != undefined;
  let val1tienep = val1.p != undefined;
  let val9tienea = val9.a != undefined;
  let val9tienep = val9.p != undefined;
  let union19tienea = union19.a != undefined;
  let union19tienep = union19.p != undefined;
  let union19tieneqrbc = (union19.q != undefined) && (union19.r != undefined) && (union19.b != undefined) && (union19.c != undefined);
  
  res.write(`val1 ${si_o_no(val1tienea)} tiene la variable a.`, !val1tienea);
  res.write(`val1 ${si_o_no(val1tienep)} tiene la variable p.`, val1tienep);
  res.write(`val9 ${si_o_no(val9tienea)} tiene la variable a.`, val9tienea);
  res.write(`val9 ${si_o_no(val9tienep)} tiene la variable p.`, !val9tienep);
  res.write(`La uni&oacute;n de val1 y val9 ${si_o_no(esValuacion(union310))} es una valuaci&oacute;n.`, esValuacion(union19));
  res.write(`La uni&oacute;n de val3 y val10 ${si_o_no(esValuacion(union19))} es una valuaci&oacute;n.`, esValuacion(union310));
  res.write(`La uni&oacute;n de val1 y val9 ${si_o_no(union19tienea)} tiene la variable a.`, union19tienea);
  res.write(`La uni&oacute;n de val1 y val9 ${si_o_no(union19tienep)} tiene la variable p.`, union19tienep);
  res.write(`La uni&oacute;n de val1 y val9 ${si_o_no(union19tieneqrbc)} tiene las variables q, r, b y c.`, union19tieneqrbc);
  res.write(`La uni&oacute;n de val3 y val10 asigna ${union310.p} a la variable p.`, !union310.p);
  res.write(`La uni&oacute;n de val3 y val10 asigna ${union310.q} a la variable q.`, union310.q);
  res.write(`La uni&oacute;n de val3 y val10 asigna ${union310.r} a la variable r.`, union310.r);
  res.write(`La uni&oacute;n de val3 y val10 asigna ${union310.z} a la variable z.`, union310.z);
  res.write(`La uni&oacute;n de val10 y val11 asigna ${union1011.r} a la variable r.`, union1011.r === false);
  res.write(`La uni&oacute;n de val11 y val10 asigna ${union1110.q} a la variable q.`, union1110.q);
}

// Test Ejercicio 3
function testEjercicio3(res) {
	let prop1 = o(no(y(v("p"),v("q"))),v("r"));
	let prop2 = no(no(v("a")));
	let prop3 = o(y(v("p"),v("q")),y(v("r"),v("z")));
    let prop1String = "(&not;(p &and; q) &or; r)";
    let prop2String = "&not;&not;a";
    let prop3String = "((p &and; q) &or; (r &and; z))";
    let prop1StringBien = prop1.toString() == prop1String;
    let prop2StringBien = prop2.toString() == prop2String;
    let prop3StringBien = prop3.toString() == prop3String;
    res.write(`prop1.toString() ${si_o_no(prop1StringBien)} es ${prop1String}.`, prop1StringBien);
    res.write(`prop2.toString() ${si_o_no(prop2StringBien)} es ${prop2String}.`, prop2StringBien);
    res.write(`prop3.toString() ${si_o_no(prop3StringBien)} es ${prop3String}.`, prop3StringBien);
}

// Test Ejercicio 4
function testEjercicio4(res) {
	let prop1 = o(no(y(v("p"),v("q"))),y(v("r"),v("q")));
	let prop2 = no(no(v("a")));
	let prop3 = o(y(v("p"),v("q")),y(v("r"),v("z")));
    let set1 = new Set();
    let set2 = new Set();
    let set3 = new Set();
    set1.add("p").add("q").add("r");
    set2.add("a");
    set3.add("p").add("q").add("r").add("z");
    let prop1bien = eqSet(prop1.fv(), set1);
    let prop2bien = eqSet(prop2.fv(), set2);
    let prop3bien = eqSet(prop3.fv(), set3);
    res.write(`Las variables libres de ${prop1.toString()} ${si_o_no(prop1bien)} son p, q y r.`, prop1bien);
    res.write(`La variable libre de ${prop2.toString()} ${si_o_no(prop2bien)} es a.`, prop2bien);
    res.write(`Las variables libres de ${prop3.toString()} ${si_o_no(prop3bien)} son p, q, r y z.`, prop3bien);
}

// Test Ejercicio 5
function testEjercicio5(res) {
	let prop1 = o(no(y(v("p"),v("q"))),y(v("r"),v("q")));
	let prop2 = y(no(no(v("a"))), y(v("b"),no(v("c"))));
	let prop3 = o(y(v("p"),v("q")),y(v("r"),v("z")));
    let check11 = prop1.evaluar(val1);
    let check12 = prop1.evaluar(val2);
    let check13 = prop1.evaluar(val3);
    let check14 = prop1.evaluar(val4);
    let check15 = prop1.evaluar(val5);
    let check16 = prop1.evaluar(val6);
    let check17 = prop1.evaluar(val7);
    let check18 = prop1.evaluar(val8);
    let check19 = prop1.evaluar(val9);
    let check110 = prop1.evaluar(val10);
    let checkunion1 = prop1.evaluar(union(val10, val2));
    let check21 = prop2.evaluar(val1);
    let check22 = prop2.evaluar(val2);
    let check23 = prop2.evaluar(val3);
    let check24 = prop2.evaluar(val4);
    let check25 = prop2.evaluar(val5);
    let check26 = prop2.evaluar(val6);
    let check27 = prop2.evaluar(val7);
    let check28 = prop2.evaluar(val8);
    let check29 = prop2.evaluar(val9);
    let check210 = prop2.evaluar(val10);
    let checkunion2 = prop2.evaluar(union(val10, val2));
    let check31 = prop3.evaluar(val1);
    let check32 = prop3.evaluar(val2);
    let check33 = prop3.evaluar(val3);
    let check34 = prop3.evaluar(val4);
    let check35 = prop3.evaluar(val5);
    let check36 = prop3.evaluar(val6);
    let check37 = prop3.evaluar(val7);
    let check38 = prop3.evaluar(val8);
    let check39 = prop3.evaluar(val9);
    let check310 = prop3.evaluar(val10);
    let checkunion3 = prop3.evaluar(union(val10, val2));
    res.write(`El resultado de evaluar ${prop1.toString()} en val1 es ${check11}.`, check11);
    res.write(`El resultado de evaluar ${prop1.toString()} en val2 es ${check12}.`, check12);
    res.write(`El resultado de evaluar ${prop1.toString()} en val3 es ${check13}.`, check13);
    res.write(`El resultado de evaluar ${prop1.toString()} en val4 es ${check14}.`, check14);
    res.write(`El resultado de evaluar ${prop1.toString()} en val5 es ${check15}.`, check15);
    res.write(`El resultado de evaluar ${prop1.toString()} en val6 es ${check16}.`, check16);
    res.write(`El resultado de evaluar ${prop1.toString()} en val7 es ${check17}.`, check17);
    res.write(`El resultado de evaluar ${prop1.toString()} en val8 es ${check18}.`, check18 === false);
    res.write(`El resultado de evaluar ${prop1.toString()} en val9 es ${check19}.`, check19 === undefined);
    res.write(`El resultado de evaluar ${prop1.toString()} en val10 es ${check110}.`, check110 === undefined);
    res.write(`El resultado de evaluar ${prop2.toString()} en val1 es ${check21}.`, check21 === undefined);
    res.write(`El resultado de evaluar ${prop2.toString()} en val2 es ${check22}.`, check22 === undefined);
    res.write(`El resultado de evaluar ${prop2.toString()} en val3 es ${check23}.`, check23 === undefined);
    res.write(`El resultado de evaluar ${prop2.toString()} en val4 es ${check24}.`, check24 === undefined);
    res.write(`El resultado de evaluar ${prop2.toString()} en val5 es ${check25}.`, check25 === undefined);
    res.write(`El resultado de evaluar ${prop2.toString()} en val6 es ${check26}.`, check26 === undefined);
    res.write(`El resultado de evaluar ${prop2.toString()} en val7 es ${check27}.`, check27 === undefined);
    res.write(`El resultado de evaluar ${prop2.toString()} en val8 es ${check28}.`, check28 === undefined);
    res.write(`El resultado de evaluar ${prop2.toString()} en val9 es ${check29}.`, check29);
    res.write(`El resultado de evaluar ${prop2.toString()} en val10 es ${check210}.`, check210 === undefined);
    res.write(`El resultado de evaluar ${prop3.toString()} en val1 es ${check31}.`, check31 === undefined);
    res.write(`El resultado de evaluar ${prop3.toString()} en val2 es ${check32}.`, check32 === undefined);
    res.write(`El resultado de evaluar ${prop3.toString()} en val3 es ${check33}.`, check33 === undefined);
    res.write(`El resultado de evaluar ${prop3.toString()} en val4 es ${check34}.`, check34 === undefined);
    res.write(`El resultado de evaluar ${prop3.toString()} en val5 es ${check35}.`, check35 === undefined);
    res.write(`El resultado de evaluar ${prop3.toString()} en val6 es ${check36}.`, check36 === undefined);
    res.write(`El resultado de evaluar ${prop3.toString()} en val7 es ${check37}.`, check37 === undefined);
    res.write(`El resultado de evaluar ${prop3.toString()} en val8 es ${check38}.`, check38 === undefined);
    res.write(`El resultado de evaluar ${prop3.toString()} en val1 es ${check39}.`, check39 === undefined);
    res.write(`El resultado de evaluar ${prop3.toString()} en val1 es ${check310}.`, check310 === undefined);
    res.write(`El resultado de evaluar ${prop1.toString()} en la uni&oacute;n de val10 y val2 es ${checkunion1}.`, checkunion1);
    res.write(`El resultado de evaluar ${prop2.toString()} en la uni&oacute;n de val10 y val2 es ${checkunion2}.`, checkunion2 === undefined);
    res.write(`El resultado de evaluar ${prop3.toString()} en la uni&oacute;n de val10 y val2 es ${checkunion3}.`, checkunion3 === false);
}
    
    
// Test Ejercicio 6
function testEjercicio6(res) {
    let propa = v("a");
    let propNoNoa = no(no(v("a")));
    let impl1 = implica(propNoNoa, propa);
    let impl2 = cambiarOperador(impl1, "=&gt;");
    let impl3 = implica(v("p"), v("q"));
    let impl1String = "(&not;&not;a &sup; a)";
    let impl2String = "(&not;&not;a =&gt; a)";
    let impl1StringBien = impl1.toString() == impl1String;
    let impl2StringBien = impl2.toString() == impl2String;
    let eval1 = impl3.evaluar(val1);
    let eval2 = impl3.evaluar(val2);
    let eval3 = impl3.evaluar(val3);
    let eval5 = impl3.evaluar(val5);
    let check19 = impl1.evaluar(val9);
    let check29 = impl2.evaluar(val9);
    res.write(`impl1.toString() ${si_o_no(impl1StringBien)} es ${impl1String}.`, impl1StringBien);
    res.write(`impl2.toString() ${si_o_no(impl2StringBien)} es ${impl2String}.`, impl2StringBien);
    res.write(`El resultado de evaluar ${impl3.toString()} en val1 es ${eval1}.`, eval1);
    res.write(`El resultado de evaluar ${impl3.toString()} en val2 es ${eval2}.`, eval2);
    res.write(`El resultado de evaluar ${impl3.toString()} en val3 es ${eval3}.`, eval3);
    res.write(`El resultado de evaluar ${impl3.toString()} en val5 es ${eval5}.`, !eval5);
    res.write(`El resultado de evaluar ${impl1.toString()} en val9 es ${check19}.`, check19);
    res.write(`El resultado de evaluar ${impl2.toString()} en val9 es ${check29}.`, check29);
}

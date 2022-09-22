
import Data.Char
import Data.Maybe
import Test.HUnit
import MultiDict


--Multidiccionarios de prueba


infinito :: MultiDict Integer Integer
infinito = tablas 1

cuatroNiveles :: MultiDict Integer Char
cuatroNiveles = Entry 1 'a' (Multi 2 (Entry 2 'b' (Multi 3 (Entry 3 'c' (Multi 4 (Entry 4 'd' Nil) Nil)) Nil)) Nil)

superinfinito :: MultiDict Integer Integer
superinfinito = Multi 1 (Entry 1 1 superinfinito) (mapMD (+1) (*2) superinfinito)


datosLlamada :: MultiDict String String --Cualquier parecido con los datos de una llamada que hizo un cliente a un banco son absolutamente...
datosLlamada =
    Entry "EventSequenceNumber" "21866615" $
    Entry "Time" "1521555643436" $
    Multi "Extensions"
       ( Entry "parent-party-uuid" "OQG87JKNJT4HJ568BGVTLHBSES07S0NU" $
         Entry "OtherTrunkName" "HiPath8000_Trunk" $
         Entry "OriginationDN" "3584622309"$
         Entry "OriginationDN_location" "SipSwitch_BHSA"$
         Entry "BusinessCall" "1" $
         Entry "NO_ANSWER_TIMEOUT" "30" $
         Entry "NO_ANSWER_ACTION" "notready" $
         Entry "NO_ANSWER_OVERFLOW" "recall" $ Nil) $
    Entry "PartyUuid" "OQG87JKNJT4HJ568BGVTLHBSES07S1EH" $
    Entry "ThirdPartyQueue" "1665" $
    Entry "OtherQueue" "3013" $
    Entry "ThisQueue" "44303" $
    Entry "ThisDNRole" "2 [RoleDestination]" $
    Entry "AgentID" "1364" $
    Entry "ThisDN" "541143356512" $
    Entry "ANI" "3584622309" $
    Entry "DNIS" "1665" $
    Multi "UserData"
       ( Entry "Preatendedor" "Si" $
         Multi "RRequestedSkills" Nil $
         Entry "CustomerSegment" "default" $
         Entry "ServiceType" "default" $
         Entry "ServiceObjective" "" $
         Entry "scriptidkeyname" "1665" $
         Entry "Sucursal" "RIO CUARTO" $
         Entry "TOOLBAR_REAL" "Totem RIO CUARTO" $
         Entry "GVP_CID" "000202ba29a61ad6" $
         Entry "Ambiente" "PROD" $
         Entry "Contingencia" "0" $
         Entry "CrearClave" "ON" $
         Entry "ANI" "3584622309" $
         Entry "GVP_FIN" "B3368B05CE6941F5362536DC59139BDFB8FEF4E81EB41562BF4579BA55F824DD254F9187366F7D7A4139273BC5DCA95DC8D1255E6F0BEF0902E32AC70E8EDC87DB7B11F555D8A3E80B299EEB" $
         Entry "GVP_GRUPO" "TOTEM" $
         Entry "GVP_INICIO" "9B22D23EF36D1237A5AC20EE3D8CF304F872B2018DDC09CD956E28107B5EA7215212436508360E550B9F07499B608DA76553D1AD25CDE5C574C981450F883C2BC8FE8E2209FEAB31B7C123FE00BA3F6D1DB9E9B8EC62D218620BA9B6620104E39AFC4177" $
         Entry "GVP_MSJULTIMOACCESO" "TOTEM - Desbloquear Clave" $
         Entry "GVP_NRODOC" "12599644" $
         Entry "GVP_URL" "http://canalesredirector/prisma/desbloquearPIN.do" $
         Entry "destino" "sip:44303@192.168.8.61" $
         Entry "documento" "12599644" $
         Entry "URL1" "http://canalesredirector/prisma/desbloquearPIN.do" $
         Entry "datosLlamada" "9B22D23EF36D1237A5AC20EE3D8CF304F872B2018DDC09CD956E28107B5EA7215212436508360E550B9F07499B608DA76553D1AD25CDE5C574C981450F883C2BC8FE8E2209FEAB31B7C123FE00BA3F6D1DB9E9B8EC62D218620BA9B6620104E39AFC4177" $
         Entry "datosLlamada2" "B3368B05CE6941F5362536DC59139BDFB8FEF4E81EB41562BF4579BA55F824DD254F9187366F7D7A4139273BC5DCA95DC8D1255E6F0BEF0902E32AC70E8EDC87DB7B11F555D8A3E80B299EEB" $
         Entry "documento_cliente" "12599644" $
         Entry "SecsInACWToReadyInbound" "15" $
         Entry "AUTOATENCION" "SI" $
         Entry "StatusAfterInbound" "Amarillo" $
         Entry "skill" "" $
         Entry "skillTotem" "" $
         Entry "ColaTotem" "SI" $
         Entry "Browser" "1" $
         Entry "Grupo_Asesor" "Totem" $
         Entry "IW_OverrideOptions" "CUS_Inbound" $
         Entry "RPVQID" "0FPCKSKVOL4GP2PSNV0B7OBN4400SHR8" $
         Entry "RTargetAgentGroup" "?:DesbordeTotem = 1" $
         Entry "RTargetAgentGroup" "?:Totem = 1" $
         Entry "RVQID" "0FPCKSKVOL4GP2PSNV0B7OBN4400SHR8" $
         Entry "RVQDBID" "1523" $
         Entry "RTargetTypeSelected" "2" $
         Entry "RTargetRuleSelected" "" $
         Entry "RTargetObjectSelected" "?:Totem = 1" $
         Entry "RTargetObjSelDBID" "" $
         Entry "RTargetAgentSelected" "MRomero" $
         Entry "RTargetAgSelDBID" "1812" $
         Entry "RTargetPlaceSelected" "P_6512" $
         Entry "RTargetPlSelDBID" "616" $
         Entry "RTenant" "Hipotecario" $
         Entry "RTenantDBID" "103" $
         Entry "RStrategyName" "Segmentacion_Totem_filtrada" $
         Entry "RStrategyDBID" "308" $
         Entry "CBR-actual_volume" "" $
         Entry "CBR-Interaction_cost" "" $
         Entry "CBR-contract_DBIDs" "" $
         Entry "CBR-IT-path_DBIDs" "" $
         Entry "RRequestedSkillCombination" "" $
         Entry "RTargetRequested" "?:Totem = 1" $
         Entry "PegAG?:Totem = 1" "1" $
         Entry "PegTD" "4" $
         Entry "PegDOW" "4" Nil ) $
    Entry "CallUuid" "2U6F4SQ93170BADU8LSQ871KB8012UN7" $
    Entry "ConnID" "000202BA29A61AD6" $
    Entry "CallID" "17922791" $
    Entry "PropagatedCallType" "2 [Inbound]" $
    Entry "CallType" "2 [Inbound]" $
    Entry "CallState" "0" $
    Entry "OtherDNRole" "1 [RoleOrigination]" $
    Entry "OtherDN" "3584622309" Nil

unNivelUnaEntrada :: MultiDict Char Integer
unNivelUnaEntrada = Entry 'a' 1 Nil

unNivelDosEntradas :: MultiDict Char Integer
unNivelDosEntradas = Entry 'a' 1 $ Entry 'b' 1 Nil

dosNivelesUnaEntradaUnMulti :: MultiDict Char Integer
dosNivelesUnaEntradaUnMulti = Entry 'a' 1 $  Multi 'b' (Entry 'a' 2 $ Entry 'd' 4 Nil) Nil

dosNivelesDosMulti :: MultiDict Char Integer
dosNivelesDosMulti = Multi 'a' (Entry 'a' 2 $ Entry 'd' 4 Nil)  $  Multi 'b' (Entry 'a' 2 $ Entry 'd' 4 Nil) Nil

tresNiveles :: MultiDict Char Integer
tresNiveles = Multi 'b' (Multi 'a' (Entry 'v' 42 $ Entry 'h' 2 Nil) $ Entry 'd' 4 Nil)  Nil

deStringsUnNivel :: MultiDict String Integer
deStringsUnNivel = Entry "A" 1 $ Entry "Aa" 2 $ Nil

deStringsDosNiveles :: MultiDict String Integer
deStringsDosNiveles = Entry "A" 1 $ Multi "B" (Entry "Aa" 2 $ Entry "C" 3 $ Nil) $ Entry "D" 4 $ Nil

tresNivelesEnunciado :: MultiDict Char Integer
tresNivelesEnunciado = definir "abd" 1 $ cadena 2 "abc"

-- Array vació con tipo para cadena
vacio :: [Char]
vacio = []

-- Nil con tipo evitar 'Ambigous type variable'
nilDeChar :: MultiDict Char Integer
nilDeChar = Nil
nilDeString :: MultiDict String Integer
nilDeString = Nil

-- Para obtener la siguiente letra en el alfabeto
nextChar :: Char -> Char
nextChar c = chr (ord c + 1)


-- Para testear foldMD
-- Suma claves
sumaClaves :: MultiDict Integer a -> Integer
sumaClaves = foldMD 0 (\k _ rec -> k + rec) (\k rec1 rec2 -> k + rec1 + rec2)
-- Suma valores
sumaValores :: MultiDict a Integer -> Integer
sumaValores = foldMD 0 (\_ v rec -> v + rec) (\_ rec1 rec2 -> rec1 + rec2)

-- Refactor test2 recMD para reusar
cantMultiNoNil :: MultiDict a b -> Integer
cantMultiNoNil = recMD 0 (\_ _ _ ->id) (\_ m1 _ r1 r2->if isNil m1 then r2 else 1+r1+r2)

--Ejecución de los tests
main :: IO Counts
main = do runTestTT allTests

allTests = test [
  "ejercicio1a" ~: tests1,
  "ejercicio1b" ~: tests2,
  "ejercicio2a" ~: tests3,
  "ejercicio2b" ~: tests4,
  "ejercicio3" ~: tests5,
  "ejercicio4" ~: tests6,
  "ejercicio5a" ~: tests7,
  "ejercicio5b" ~: tests8,
  "ejercicio6" ~: tests9,
  "ejercicio7" ~: tests10
  ]

tests1 = test [
   podar 5 5 cuatroNiveles ~=? cuatroNiveles,
   sumaClaves cuatroNiveles ~=? 19,
   sumaValores Nil ~=? 0,
   sumaValores unNivelUnaEntrada ~=? 1,
   sumaValores dosNivelesUnaEntradaUnMulti ~=? 7
  ]
tests2 = test [
   cantMultiNoNil Nil ~=? 0,
   cantMultiNoNil cuatroNiveles ~=? 3,
   cantMultiNoNil unNivelUnaEntrada ~=? 0,
   cantMultiNoNil unNivelDosEntradas ~=? 0,
   cantMultiNoNil dosNivelesUnaEntradaUnMulti ~=? 1,
   cantMultiNoNil dosNivelesDosMulti ~=? 2,
   cantMultiNoNil (Multi 1 Nil Nil) ~=? 0
  ]
tests3 = test [
   profundidad cuatroNiveles ~=? 4,
   profundidad datosLlamada ~=? 2,
   profundidad Nil ~=? 0,
   profundidad unNivelUnaEntrada ~=? 1,
   profundidad unNivelDosEntradas  ~=? 1,
   profundidad dosNivelesUnaEntradaUnMulti   ~=? 2,
   profundidad dosNivelesDosMulti   ~=? 2,
   profundidad tresNiveles  ~=? 3
  ]
tests4 = test [
   tamaño cuatroNiveles ~=? 7,
   tamaño (podar 5 3 datosLlamada) ~=? 10,
   tamaño datosLlamada ~=? 89,
   tamaño Nil ~=? 0,
   tamaño unNivelUnaEntrada ~=? 1,
   tamaño unNivelDosEntradas  ~=? 2,
   tamaño dosNivelesUnaEntradaUnMulti   ~=? 4,
   tamaño dosNivelesDosMulti ~=? 6,
   tamaño tresNiveles ~=? 5
  ]
tests5 = test [
   (podar 5 3 $ tablas 2) ~=? (podar 5 2 $ tablas 2),
   (profundidad $ podar 20 20 infinito) ~=? 2,
   (tamaño $ podar 5 3 $ tablas 2) ~=? 30,
   (tamaño $ podar 0 0 $ tablas 3) ~=? 0,
   (tamaño $ podar 1 1 $ tablas 1) ~=? 1,
   (tamaño $ podar 1 2 $ tablas 1) ~=? 2,
   (tamaño $ podar 3 2 $ tablas 1) ~=? 12,
   (tamaño $ podar 3 1 $ tablas 1) ~=? 3,
   (profundidad $ podar 0 3 $ tablas 3) ~=? 0,
   (profundidad $ podar 2 3 $ tablas 3) ~=? 2,
   (profundidad $ podar 3 3 $ tablas 3) ~=? 2,
   (profundidad $ podar 3 3 $ tablas 3) ~=? 2
   ]
tests6 = test [
  serialize nilDeChar ~=? "[ ]",
  serialize cuatroNiveles ~=? "[1: 'a', [2: [2: 'b', [3: [3: 'c', [4: [4: 'd', [ ]], [ ]]], [ ]]], [ ]]]",
  serialize unNivelUnaEntrada ~=? "['a': 1, [ ]]",
  serialize unNivelDosEntradas  ~=? "['a': 1, ['b': 1, [ ]]]",
  serialize dosNivelesUnaEntradaUnMulti   ~=? "['a': 1, ['b': ['a': 2, ['d': 4, [ ]]], [ ]]]",
  serialize dosNivelesDosMulti ~=? "['a': ['a': 2, ['d': 4, [ ]]], ['b': ['a': 2, ['d': 4, [ ]]], [ ]]]",
  serialize tresNiveles  ~=? "['b': ['a': ['v': 42, ['h': 2, [ ]]], ['d': 4, [ ]]], [ ]]"
  ]
tests7 = test [
   (profundidad $ podar 10 5 superinfinito) ~=? 5,
   (profundidad $ podar 3 10 superinfinito) ~=? 10,
   (tamaño $ podar 10 5 superinfinito) ~=? 82010,
   serialize (mapMD id (+ 1) unNivelUnaEntrada) ~=? "['a': 2, [ ]]",
   serialize (mapMD nextChar id dosNivelesUnaEntradaUnMulti)   ~=? "['b': 1, ['c': ['b': 2, ['e': 4, [ ]]], [ ]]]",
   serialize (mapMD ord (const 'a') dosNivelesDosMulti) ~=? "[97: [97: 'a', [100: 'a', [ ]]], [98: [97: 'a', [100: 'a', [ ]]], [ ]]]",
   serialize (mapMD (++ "a") (+ 1) deStringsDosNiveles) ~=? "[\"Aa\": 2, [\"Ba\": [\"Aaa\": 3, [\"Ca\": 4, [ ]]], [\"Da\": 5, [ ]]]]",
   serialize (mapMD (++ "a") (+ 1) nilDeString) ~=? "[ ]",
   serialize (filterMD (== 'a') unNivelUnaEntrada) ~=? "['a': 1, [ ]]",
   serialize (filterMD (== 'a') unNivelDosEntradas) ~=? "['a': 1, [ ]]",
   serialize (filterMD (== 'a') dosNivelesDosMulti) ~=? "['a': ['a': 2, [ ]], [ ]]",
   serialize (filterMD (== 'c') dosNivelesDosMulti) ~=? "[ ]",
   serialize (filterMD (== 'b') tresNiveles)  ~=? "['b': [ ], [ ]]",
   serialize (filterMD ((< 'C') . head) deStringsDosNiveles) ~=? "[\"A\": 1, [\"B\": [\"Aa\": 2, [ ]], [ ]]]",
   serialize (filterMD (== 'a') nilDeChar) ~=? "[ ]"
  ]
tests8 = test [
   (serialize $ filterMD even $ Entry 4 'e' cuatroNiveles) ~=? "[4: 'e', [2: [2: 'b', [ ]], [ ]]]",
   (serialize $ enLexicon ["extensions", "originationdn", "no_answer_action", "ani", "dnis", "userdata", "customersegment", "statusafterinbound", "connid"] datosLlamada) ~=? "[\"extensions\": [\"originationdn\": \"3584622309\", [\"no_answer_action\": \"notready\", [ ]]], [\"ani\": \"3584622309\", [\"dnis\": \"1665\", [\"userdata\": [\"customersegment\": \"default\", [\"ani\": \"3584622309\", [\"statusafterinbound\": \"Amarillo\", [ ]]]], [\"connid\": \"000202BA29A61AD6\", [ ]]]]]]",
   (serialize $ enLexicon ["aa", "aaa", "b", "d"] deStringsDosNiveles) ~=? "[\"b\": [\"aa\": 2, [ ]], [\"d\": 4, [ ]]]",
   (serialize $ enLexicon ["b", "d"] deStringsUnNivel) ~=? "[ ]",
   (serialize $ enLexicon ["a", "aa"] deStringsUnNivel) ~=? "[\"a\": 1, [\"aa\": 2, [ ]]]",
   (serialize $ enLexicon ["a"] deStringsUnNivel) ~=? "[\"a\": 1, [ ]]",
   (serialize $ enLexicon ["aa"] deStringsUnNivel) ~=? "[\"aa\": 2, [ ]]",
   (serialize $ enLexicon ["a", "b", "c"] nilDeString) ~=? "[ ]"
  ]
tests9 = test [
   (serialize $ definir [2,3] 'c' cuatroNiveles) ~=? "[1: 'a', [2: [2: 'b', [3: 'c', [ ]]], [ ]]]",
   (profundidad $ definir [4] 'g' $ definir [4] 'e' $ definir [2,4] 'f' $ definir [2,3,4,5] 'e' cuatroNiveles) ~=? 4,
   (serialize $ cadena 1 vacio) ~=? "[ ]",
   (serialize $ cadena 1 "a") ~=? "['a': 1, [ ]]",
   (serialize $ cadena 1 "abc") ~=? "['a': ['b': ['c': 1, [ ]], [ ]], [ ]]",
   (serialize $ cadena "abc" [1,2,3]) ~=? "[1: [2: [3: \"abc\", [ ]], [ ]], [ ]]"
  ]
tests10 = test [
   (obtener [4] $ definir [4] 'g' $ definir [4] 'e' $ definir [2,4] 'f' $ definir [2,3,4,5] 'e' cuatroNiveles) ~=? Just 'g',
   obtener [2,3,3] cuatroNiveles ~=? Just 'c',
   obtener [2,3,5] cuatroNiveles ~=? Nothing,
   obtener [6,7] infinito ~=? Just 42,
   obtener "a" nilDeChar ~=? Nothing,
   obtener ["A"] deStringsUnNivel ~=? Just 1,
   obtener ["Aa"] deStringsUnNivel ~=? Just 2,
   obtener ["Aa"] deStringsUnNivel ~=? Just 2,
   obtener "a" unNivelDosEntradas ~=? Just 1,
   obtener "c" unNivelDosEntradas ~=? Nothing,
   obtener "a" tresNivelesEnunciado ~=? Nothing,
   obtener "abd" tresNivelesEnunciado ~=? Just 1,
   obtener "abc" tresNivelesEnunciado ~=? Just 2,
   obtener "abcd" tresNivelesEnunciado ~=? Nothing,
   obtener "af" tresNivelesEnunciado ~=? Nothing
  ]

  
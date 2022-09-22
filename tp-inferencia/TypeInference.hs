module TypeInference (TypingJudgment, Result(..), inferType, inferNormal, normalize)

where

import Data.List(intersect, union, nub, sort)
import Exp
import Type
import Unification

------------
-- Errors --
------------
data Result a = OK a | Error String


--------------------
-- Type Inference --
--------------------
type TypingJudgment = (Context, AnnotExp, Type)

typeVarsT :: Type -> [Int]
typeVarsT = foldType (:[]) [] [] union

typeVarsE :: Exp Type -> [Int]
typeVarsE = foldExp (const []) [] id id id [] [] (\r1 r2 r3 ->nub(r1++r2++r3)) (const setAdd) union
  where setAdd t r = union (typeVarsT t) r

typeVarsC :: Context -> [Int]
typeVarsC c = nub (concatMap (typeVarsT . evalC c) (domainC c))

typeVars :: TypingJudgment -> [Int]
typeVars (c, e, t) = sort $ union (typeVarsC c) (union (typeVarsE e) (typeVarsT t))

normalization :: [Int] -> [Subst]
normalization ns = foldr (\n rec (y:ys) -> extendS n (TVar  y) emptySubst : (rec ys)) (const []) ns [0..]

normalize :: TypingJudgment -> TypingJudgment
normalize j@(c, e, t) = let ss = normalization $ typeVars j in foldl (\(rc, re, rt) s ->(s <.> rc, s <.> re, s <.> rt)) j ss
  
inferType :: PlainExp -> Result TypingJudgment
inferType e = case infer' e 0 of
    OK (_, tj) -> OK tj
    Error s -> Error s
    
inferNormal :: PlainExp -> Result TypingJudgment
inferNormal e = case infer' e 0 of
    OK (_, tj) -> OK $ normalize tj
    Error s -> Error s


intersectC :: Context -> Context -> [UnifGoal]
intersectC c1 c2 = [(evalC c1 v1, evalC c2 v2) | v1 <- domainC c1, v2 <- domainC c2, v1 == v2]

infer' :: PlainExp -> Int -> Result (Int, TypingJudgment)

infer' (SuccExp e)    n = case infer' e n of
                            OK (n', (c', e', t')) ->
                              case mgu [(t', TNat)] of
                                UOK subst -> OK (n',
                                                    (
                                                     subst <.> c',
                                                     subst <.> SuccExp e',
                                                     TNat
                                                    )
                                                )
                                UError u1 u2 -> uError u1 u2
                            res@(Error _) -> res

-- COMPLETAR DESDE AQUI

infer' ZeroExp                n = OK (n, (emptyContext, ZeroExp, TNat))

infer' (VarExp x)             n = OK (n + 1, 
                                          (
                                            extendC emptyContext x (TVar n), VarExp x, TVar n
                                          )
                                     )

infer' (AppExp u v)           n = case infer' u n of
                                    OK (n', (cu, u', tu)) ->
                                      case infer' v n' of
                                        OK (n'', (cv, v', tv)) ->
                                          case mgu ((tu, TFun tv (TVar n'')) : intersectC cu cv) of
                                            UOK subst -> OK (n'' + 1,
                                                                (
                                                                  joinC [subst <.> cu, subst <.> cv],
                                                                  subst <.> AppExp u' v',
                                                                  subst <.> TVar n''
                                                                )
                                                            )
                                            UError u1 u2 -> uError u1 u2
                                        resv@(Error _) -> resv
                                    resu@(Error _) -> resu

infer' (LamExp x _ e)         n = case infer' e n of
                                    OK (n', (c', e', t)) ->
                                      OK  (n' + 1,
                                             (
                                              removeC c' x,
                                              LamExp x (t' c' x n') e',
                                              TFun (t' c' x n') t
                                             )
                                          )
                                    res@(Error _) -> res
                                    where t' c x m = if elem x (domainC c) then evalC c x else TVar m

-- OPCIONALES

infer' (PredExp e)            n = case infer' e n of
                                    OK (n', (c', e', t')) ->
                                      case mgu [(t', TNat)] of
                                        UOK subst -> OK (n',
                                                            (
                                                            subst <.> c',
                                                            subst <.> PredExp e',
                                                            TNat
                                                            )
                                                        )
                                        UError u1 u2 -> uError u1 u2
                                    res@(Error _) -> res
infer' (IsZeroExp e)          n = case infer' e n of
                                    OK (n', (c', e', t')) ->
                                      case mgu [(t', TNat)] of
                                        UOK subst -> OK (n',
                                                            (
                                                            subst <.> c',
                                                            subst <.> IsZeroExp e',
                                                            TBool
                                                            )
                                                        )
                                        UError u1 u2 -> uError u1 u2
                                    res@(Error _) -> res
infer' TrueExp                n = OK (n, (emptyContext, TrueExp, TBool))
infer' FalseExp               n = OK (n, (emptyContext, FalseExp, TBool))
infer' (IfExp u v w)          n = case infer' u n of
                                    OK (n', (cu, u', tu)) ->
                                      case infer' v n' of
                                        OK (n'', (cv, v', tv)) ->
                                          case infer' w n'' of
                                            OK (n''', (cw, w', tw)) ->
                                              case mgu ((tv, tw) : (tu, TBool) : (intersectC cu cv ++ intersectC cv cw ++ intersectC cw cu)) of
                                                UOK subst -> OK (n''',
                                                                    (
                                                                      joinC [subst <.> cu, subst <.> cv, subst <.> cw],
                                                                      subst <.> IfExp u' v' w',
                                                                      subst <.> tv
                                                                    )
                                                                )
                                                UError u1 u2 -> uError u1 u2
                                            resw@(Error _) -> resw
                                        resv@(Error _) -> resv
                                    resu@(Error _) -> resu

--------------------------------
-- YAPA: Error de unificacion --
--------------------------------
uError :: Type -> Type -> Result (Int, a)
uError t1 t2 = Error $ "Cannot unify " ++ show t1 ++ " and " ++ show t2

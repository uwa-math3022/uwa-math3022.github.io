(* ::Package:: *)

ClearAll["Global`*"];


(* ::Section:: *)
(*Fourier coefficients*)


(* B_n *)
FullSimplify[
  Divide[
    Integrate[-x Sin[n Pi x], {x, 0, 1}],
    Integrate[Sin[n Pi x] ^ 2, {x, 0, 1}]
  ],
  Element[n, Integers]
]

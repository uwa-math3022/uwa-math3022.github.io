(* ::Package:: *)

ClearAll["Global`*"];


(* ::Section:: *)
(*Preamble*)


(*
  Throughout this notebook, we work in scaled variables.
  That is, let
    N' == N / N{max}
    V' == V / V{max}
    F' == F / (N{max} V{max})
  and drop primes.
*)


(* ::Section:: *)
(*Functions*)


(* ::Subsection:: *)
(*Preferred speed V for a given density N*)


(* V == 1 - N *)
preferredSpeed[density_] := 1 - density;


(* ::Subsection:: *)
(*Carried flux F for a given density N*)


(* F == N V *)
carriedFlux[density_] := density * preferredSpeed[density] // Evaluate;


(* ::Subsection:: *)
(*Signal speed dF/dN for a given density N*)


(* dF/dN *)
signalSpeed[density_] := carriedFlux'[density] // Evaluate;


(* ::Section:: *)
(*Styles*)


styleDense = LightCyan;
styleSparse = LightPink;

(* ::Package:: *)

ClearAll["Global`*"];


(* ::Section:: *)
(*Solutions to the ODE*)


Module[
  {
    symbol,
    uOdd, uEven,
    xiMax,
    dummyForTrailingCommas
  },
  (* Style functions *)
  symbol[expr_] := Style[expr, Italic];
  (* Linearly independent solutions *)
  uOdd[xi_] := Sqrt[Pi] Exp[-xi^2 / 4] Erfi[xi / 2];
  uEven[xi_] := Exp[-xi^2 / 4];
  (* Plot *)
  xiMax = 10;
  Plot[{uOdd[xi], uEven[xi]}, {xi, -xiMax, xiMax}
    , AxesLabel -> {"\[Xi]", symbol["U"]}
    , LabelStyle -> Directive[Black, 15]
    , PlotLegends -> Table[
        Subscript[symbol["U"], type]
        , {type, {"odd", "even"}}
      ]
    , PlotStyle -> {Dashed, Automatic}
  ]
] // Export[
  FileNameJoin @ {NotebookDirectory[], "u-solution.png"},
  #
] &

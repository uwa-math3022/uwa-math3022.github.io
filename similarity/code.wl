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


(* ::Section:: *)
(*Animation*)


Module[
  {
    symbol,
    tempPrime,
    xPrimeMax, tempPrimeMax,
    tPrimeMin, tPrimeMax, tPrimeStep, tPrimeValues,
    frameList,
    dummyForTrailingCommas
  },
  (* Style functions *)
  symbol[expr_] := Style[expr, Italic];
  (* Scaled similarity solution *)
  tempPrime[xPrime_, tPrime_] :=
    1 / (2 Sqrt[Pi * tPrime]) Exp[-xPrime^2 / (4 tPrime)];
  (* Plot range *)
  xPrimeMax = 5;
  tempPrimeMax = 1;
  (* Values of scaled time *)
  tPrimeMin = 0;
  tPrimeMax = 2;
  tPrimeStep = 0.05;
  tPrimeValues = Range[tPrimeMin, tPrimeMax, tPrimeStep];
  (* List of frames *)
  frameList =
    Table[
      Plot[
        tempPrime[xPrime, tPrime],
        {xPrime, -xPrimeMax, xPrimeMax}
        , AxesLabel -> (#' &) /@ symbol /@ {"x", "T"}
        , ColorFunctionScaling -> False
        , ColorFunction -> "TemperatureMap"
        , Filling -> 0
        , ImageSize -> 240 (* so that the GIF file size isn't too big *)
        , LabelStyle -> Directive[Black, 15]
        , PlotLabel -> Framed[
            symbol["t"]' == NumberForm[N[tPrime], {Infinity, 2}]
          ]
        , PlotRange -> {{-xPrimeMax, xPrimeMax}, {0, tempPrimeMax}}
      ]
    , {tPrime, tPrimeValues}];
  Export[
    FileNameJoin @ {NotebookDirectory[], "animation.gif"},
    frameList
    , "AnimationRepetitions" -> Infinity
    , "DisplayDurations" -> 0.1
  ]
]

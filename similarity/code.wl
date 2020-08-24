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


(* ::Section:: *)
(*Timed input*)


Module[
  {
    symbol,
    tEndSymbol, tStarSymbol, qPrimeSymbol,
    qPrimeOverTEnd, tEnd,
    tMin, tMax, rateMin, rateMax,
    tStar, dtStar,
    windowArrowVerticalCoordinate,
    mainStyle, windowStyle, windowFontSize, windowArrowStyle,
    dummyForTrailingCommas
  },
  (* Symbols *)
  symbol[expr_] := Style[expr, Italic];
  tEndSymbol = Subscript[symbol["t"], "end"];
  tStarSymbol = Superscript[symbol["t"], "*"];
  (* Constants *)
  tEnd = 5;
  qPrimeOverTEnd = 2;
  qPrimeSymbol = symbol["Q'"];
  (* Plot range *)
  tMin = -0.1 tEnd;
  tMax = 1.4 tEnd;
  rateMin = 0;
  rateMax = 1.3 qPrimeOverTEnd;
  (* Window *)
  tStar = 0.23 tEnd;
  dtStar = 0.1 tEnd;
  windowArrowVerticalCoordinate = 1.075 qPrimeOverTEnd;
  (* Styles *)
  mainStyle = Orange;
  windowStyle = Red;
  windowFontSize = 10;
  windowArrowStyle = Arrowheads[0.025 {-1, 1}];
  (* Plot *)
  Plot[
    Piecewise @ {{qPrimeOverTEnd, 0 <= t <= tEnd}},
    {t, tMin, tMax}
    , AspectRatio -> Automatic
    , AxesLabel -> {
        symbol["t"],
        {"Energy", "per area", "per time"}
          // Column[#, Alignment -> Center] &
          // Style[#, 12] &
      }
    , Epilog -> {
        windowStyle,
          Rectangle[{tStar, 0}, {tStar + dtStar, qPrimeOverTEnd}],
          Text[
            Row @ {Spacer[6], "d", tStarSymbol}
              // Style[#, 16] &
            , {tStar + dtStar / 2, qPrimeOverTEnd}
            , {0, -1.75}
          ],
        windowArrowStyle,
          Arrow[{#, windowArrowVerticalCoordinate} & /@ {tStar, tStar + dtStar}],
        {}
      }
    , Exclusions -> None
    , Filling -> 0
    , LabelStyle -> Directive[Black, 18]
    , PlotRange -> {rateMin, rateMax}
    , PlotRangeClipping -> False
    , PlotStyle -> mainStyle
    , Ticks -> {
        {
          0,
          {tEnd, tEndSymbol, 0},
          {tStar, tStarSymbol // Style[#, windowStyle] &, 0},
          {
            tStar + dtStar,
            Row @ {
              Spacer[40],
              tStarSymbol,
              "+\[ThinSpace]",
              Row @ {"d", tStarSymbol}
            }
              // Style[#, windowStyle] &
            , 0
          },
          Nothing
        },
        {
          {qPrimeOverTEnd, Row @ {qPrimeSymbol, "/", tEndSymbol}},
          Nothing
        }
      }
  ]
] // Export[
  FileNameJoin @ {NotebookDirectory[], "timed-input.png"},
  #
] &

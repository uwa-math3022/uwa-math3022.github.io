(* ::Package:: *)

ClearAll["Global`*"];


(* ::Section:: *)
(*Diagram*)


Module[
  {
    edgeAndFaceDirective,
    symbol,
    styledText,
    rodLength, rodThickness, rodStyle,
    rodDimensionOffset, rodDimensionStyle,
    bathWidth, bathHeight, bathStyle,
    dummyForTrailingCommas
  },
  (* Style functions *)
  edgeAndFaceDirective[dir_] := Directive[EdgeForm[dir], FaceForm[dir]];
  symbol[expr_] := Style[expr, Italic];
  styledText[expr_, balance___] := Text[Style[expr, 18], balance];
  (* Rod *)
  rodLength = 3;
  rodThickness = 0.1;
  rodStyle[] = Directive[EdgeForm[Black], FaceForm[]];
  rodDimensionOffset = 0.2;
  rodDimensionStyle[] = Arrowheads @ {-Automatic, Automatic};
  (* Heat baths *)
  bathWidth = 1.3;
  bathHeight = 1.3;
  bathStyle["Cold"] = edgeAndFaceDirective[LightBlue];
  bathStyle["Hot"] = edgeAndFaceDirective[LightRed];
  (* Diagram *)
  Show[
    (* Rod *)
    Graphics @ {rodStyle[],
      Rectangle[
        {-rodLength/2, -rodThickness/2},
        {+rodLength/2, +rodThickness/2}
      ]
    },
    Graphics @ {rodDimensionStyle[],
      Arrow @ {
        {-rodLength/2, -rodThickness/2 - rodDimensionOffset},
        {+rodLength/2, -rodThickness/2 - rodDimensionOffset}
      }
    },
    Graphics @ styledText[
      symbol["L"],
      {0, -rodThickness/2 - rodDimensionOffset},
      {0, 1}
    ],
    (* Heat bath cold *)
    Graphics @ {bathStyle["Cold"],
      Rectangle[
        {-rodLength/2 - bathWidth, -bathHeight/2},
        {-rodLength/2, bathHeight/2}
      ]
    },
    Graphics @ styledText[
      Subscript[symbol["T"], 0],
      {-rodLength/2 - bathWidth/2, 0}
    ],
    (* Heat bath hot *)
    Graphics @ {bathStyle["Hot"],
      Rectangle[
        {rodLength/2 + bathWidth, -bathHeight/2},
        {rodLength/2, bathHeight/2}
      ]
    },
    Graphics @ styledText[
      Subscript[symbol["T"], 1],
      {+rodLength/2 + bathWidth/2, 0}
    ],
    {}
    , ImageSize -> 300
  ]
] // Export[
  FileNameJoin @ {NotebookDirectory[], "diagram.png"},
  #
] &


(* ::Section:: *)
(*Heat equation*)


Module[
  {
    symbol,
    n, temp,
    tNow, tLater,
    dummyForTrailingCommas
  },
  (* Style functions *)
  symbol[expr_] := Style[expr, Italic];
  (* Temperature profile *)
  n = 3;
  temp[x_, t_] := Exp[-n^2 Pi^2 t] Sin[n Pi x];
  (* Times *)
  tNow = 0.01;
  tLater = 0.015;
  (* Plot *)
  Plot[{temp[x, tNow], temp[x, tLater]}, {x, 0, 1}
    , AxesLabel -> symbol /@ {"x", "T"}
    , AxesOrigin -> {Automatic, 1.3 temp[3/(2n), tNow]}
    , Epilog -> Table[
        Module[{xArrowBase, tempArrowBase, tempArrowTip},
          xArrowBase = (i - 1/2) / n;
          tempArrowBase = temp[xArrowBase, tNow];
          tempArrowTip = temp[xArrowBase, tLater];
          Arrow @ {
            {xArrowBase, tempArrowBase},
            {xArrowBase, tempArrowTip}
          }
        ]
        , {i, n}
      ]
    , LabelStyle -> Directive[Black, 15]
    , Ticks -> None
    , PlotLegends -> {"Now", "Later"}
    , PlotStyle -> {Automatic, Dashed}
  ]
] // Export[
  FileNameJoin @ {NotebookDirectory[], "heat-equation.png"},
  #
] &


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


(* ::Section:: *)
(*Solution*)


Module[
  {
    symbol,
    tempInitial, tempSeries, tempEquilibrium,
    xPlotMin, xPlotMax, tempPlotMin, tempPlotMax,
    dummyForTrailingCommas
  },
  (* Style functions *)
  symbol[expr_] := Style[expr, Italic];
  (* Temperature profile initial (analytic approximation) *)
  tempInitial[eps_][x_] := x ^ (1 / eps);
  (* Temperature profile Fourier series *)
  tempSeries[nMax_][x_, t_] :=
    x + Sum[2 (-1)^n / (n Pi) Exp[-n^2 Pi^2 t] Sin[n Pi x], {n, nMax}];
  (* Temperature profile equilibrium *)
  tempEquilibrium[x_] := x;
  (* Plot *)
  {xPlotMin, xPlotMax} = {-0.07, 1.07};
  {tempPlotMin, tempPlotMax} = {-0.1, 1.1};
  Plot[
    {
      tempEquilibrium[x],
      tempSeries[3][x, 0.07], (* 3 terms are sufficient for the chosen t *)
      tempInitial[10^-4][x] (* Gives underflow warning, but works *)
    } // Evaluate,
    {x, 0, 1}
    , AxesLabel -> symbol /@ {"x", "T"}
    , AxesOrigin -> {xPlotMin, tempPlotMin}
    , Exclusions -> None
    , LabelStyle -> Directive[Black, 15]
    , PlotRange -> {{xPlotMin, xPlotMax}, {tempPlotMin, tempPlotMax}}
    , Ticks -> {
        {
          {0, 0},
          {1, symbol["L"]}
        },
        {
          {0, Subscript[symbol["T"], 0]},
          {1, Subscript[symbol["T"], 1]}
        }
      }
    , PlotLegends -> {"Equilibrium", "In-between", "Initial"}
    , PlotStyle -> {Automatic, Dashed, Automatic}
  ]
] // Export[
  FileNameJoin @ {NotebookDirectory[], "solution.png"},
  #
] &


(* ::Section:: *)
(*Animation*)


Module[
  {
    symbol,
    tempInitial, tempSeries, temp,
    nMaxRequired,
    xPlotMin, xPlotMax, tempPlotMin, tempPlotMax,
    tMin, tMax, tStep, tValues,
    frameList,
    dummyForTrailingCommas
  },
  (* Style functions *)
  symbol[expr_] := Style[expr, Italic];
  (* Temperature profile initial (analytic approximation) *)
  tempInitial[eps_][x_] := x ^ (1 / eps);
  (* Temperature profile Fourier series *)
  tempSeries[nMax_][x_, t_] :=
    x + Sum[2 (-1)^n / (n Pi) Exp[-n^2 Pi^2 t] Sin[n Pi x], {n, nMax}];
  (* Required number of terms for a given t (for exponent > 4) *)
  nMaxRequired[t_] := Ceiling @ Sqrt[4 / (Pi^2 t)];
  (* Temperature profile *)
  temp[x_, t_] :=
    If[t > 0,
      tempSeries[nMaxRequired[t]][x, t],
      tempInitial[10^-4][x]
    ];
  (* Plot range *)
  {xPlotMin, xPlotMax} = {-0.07, 1.07};
  {tempPlotMin, tempPlotMax} = {-0.1, 1.1};
  (* Values of t *)
  tMin = 0;
  tMax = 4 / Pi^2;
  tStep = 0.01;
  tValues = Range[tMin, tMax, tStep];
  (* List of frames *)
  frameList =
    Table[
      Show[
        Plot[
          temp[x, t] // Evaluate,
          {x, 0, 1}
          , AxesLabel -> symbol /@ {"x", "T"}
          , AxesOrigin -> {xPlotMin, tempPlotMin}
          , ColorFunctionScaling -> False
          , ColorFunction -> "TemperatureMap"
          , Exclusions -> None
          , Filling -> 0
          , ImageSize -> 240 (* so that the GIF file size isn't too big *)
          , LabelStyle -> Directive[Black, 15]
          , PlotLabel -> Framed[
            symbol["t"]' == NumberForm[N[t], {Infinity, 2}]
            ]
          , PlotRange -> {{xPlotMin, xPlotMax}, {tempPlotMin, tempPlotMax}}
          , Ticks -> {
              {
                {0, 0},
                {1, symbol["L"]}
              },
              {
                {0, Subscript[symbol["T"], 0]},
                {1, Subscript[symbol["T"], 1]}
              }
            }
        ],
        {}
      ]
    , {t, tValues}];
  Export[
    FileNameJoin @ {NotebookDirectory[], "animation.gif"},
    frameList
    , "AnimationRepetitions" -> Infinity
    , "DisplayDurations" -> 0.1
  ]
]




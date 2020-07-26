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

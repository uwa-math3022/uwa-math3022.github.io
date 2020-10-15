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
(*Graphics constants*)


(* ::Subsection:: *)
(*Cars*)


(* Car dimensions *)
carLength = 1;
carWidth = 1/2 carLength;
(* Buffer drivers leave between cars at maximum density *)
carMaxDensityBuffer = 1/5 carLength;
(* Displacement between cars at maximum density *)
carMaxDensityDisplacement = carLength + carMaxDensityBuffer;


(* ::Subsection:: *)
(*Lane*)


(* Road half-length *)
laneHalfLength = 10 carLength;
laneHalfWidth = 3/2 carWidth;


laneVerticalOffset = 4 laneHalfWidth;
applyLaneVerticalOffset[primitives_] := Translate[primitives, {0, -laneVerticalOffset}];


(* ::Subsection:: *)
(*Styles*)


symbol[char_] := Style[char, Italic];


applyTextStyle[text_] := Style[text, 16];


laneStyle = Gray;


densityColour[density_] := Blend[{LightRed, LightBlue}, density];


(* ::Subsection:: *)
(*Main spacetime diagram*)


(* Plot range *)
xMax = 8/10 laneHalfLength;
tMax = 2 xMax;


(* ::Section:: *)
(*Graphics*)


(* ::Subsection:: *)
(*Lane*)


lane = Graphics @ {
  laneStyle,
  Rectangle[
    {-laneHalfLength, -laneHalfWidth},
    {laneHalfLength, laneHalfWidth}
  ] // applyLaneVerticalOffset
};


(* ::Subsection:: *)
(*Spacetime axes*)


axesPadding = 1.5 carLength;
spacetimeAxes = Graphics @ {
  (* x-axis *)
  Arrow @ {{-xMax, 0}, {xMax + axesPadding, 0}},
  Text[
    symbol["x"] // applyTextStyle
    , {xMax + axesPadding, 0}
    , {-3, 0}
  ],
  (* t-axis *)
  Arrow @ {{-xMax, 0}, {-xMax, tMax + axesPadding}},
  Text[
    symbol["t"] // applyTextStyle
    , {-xMax, tMax + axesPadding}
    , {0, -1.25}
  ],
  {}
};


(* ::Subsection:: *)
(*Combined static graphics*)


combinedStaticGraphics =
  Show[
    spacetimeAxes,
    lane,
    {}
    , ImageSize -> 240
    , PlotRange -> All
  ];


(* ::Section:: *)
(*Case 1: Traffic light*)


(*
  {before}  -->  {after}
  N == 1    -->  N == 0
  V == 0    -->  V == 1
  F == 0    -->  F == 0
*)
Module[
  {
    nBefore, nAfter,
    vBefore, vAfter,
    cBefore, cAfter,
    densityFunction,
    frameList,
    dummyForTrailingCommas
  },
  (* Densities *)
  nBefore = 1;
  nAfter = 0;
  (* Speeds *)
  vBefore = preferredSpeed[nBefore];
  vAfter = preferredSpeed[nAfter];
  (* Signal speeds *)
  cBefore = signalSpeed[nBefore];
  cAfter = signalSpeed[nAfter];
  (* Density function *)
  densityFunction[t_, x_] :=
    Piecewise @ {
      {nBefore, x < cBefore * t},
      {nAfter, x > cAfter * t},
      {Rescale[x, {cBefore * t, cAfter * t}, {nBefore, nAfter}], True}
    };
  (* Build list of frames *)
  frameList =
    Table[
      Show[
        combinedStaticGraphics,
        (* Density *)
        DensityPlot[
          densityFunction[t, x]
          , {x, -xMax, xMax}
          , {t, 0, tMax}
          , ColorFunction -> densityColour
          , Exclusions -> None
        ],
        {}
      ]
      , {time, {0}}
    ];
  frameList
]


(* ::Section:: *)
(*Case 2: Pile up*)


(*
  {before}  -->  {after}
  N == 1/3  -->  N == 7/8
  V == 2/3  -->  V == 1/8
  F == 2/9  -->  F == 7/64
  V{shock} == (F{before} - F{after}) / (N{before} - N{after}) == -5/24
*)
Module[
  {
    nBefore, nAfter,
    vBefore, vAfter,
    fBefore, fAfter,
    vShockwave,
    frameList,
    dummyForTrailingCommas
  },
  (* Densities *)
  nBefore = 1/3;
  nAfter = 7/8;
  (* Speeds *)
  vBefore = preferredSpeed[nBefore];
  vAfter = preferredSpeed[nAfter];
  (* Fluxes *)
  fBefore = carriedFlux[nBefore];
  fAfter = carriedFlux[nAfter];
  (* Shockwave speed *)
  vShockwave = (fBefore - fAfter) / (nBefore - nAfter);
  (* Build list of frames *)
  frameList =
    Table[
      Show[
        combinedStaticGraphics,
        {}
      ]
      , {time, {0}}
    ];
  frameList
]

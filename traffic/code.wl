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


laneVerticalOffset = -4 laneHalfWidth;
applyLaneVerticalOffset[primitives_] := Translate[primitives, {0, laneVerticalOffset}];


(* ::Subsection:: *)
(*Styles*)


symbol[char_] := Style[char, Italic];


applyTextStyle[text_] := Style[text, 16];


laneStyle = Gray;


densityColour[Indeterminate] = White;
densityColour[density_] := Blend[{LightBlue, LightRed}, density];
characteristicStyle = RGBColor["darkviolet"];
trajectoryStyle = Yellow;
carBorderStyle = EdgeForm[Black];


(* ::Subsection:: *)
(*Spacetime diagram plot range*)


(* Plot range *)
xMax = 8/10 laneHalfLength;
tMax = 2 xMax;
spacetimeRegionFunction = Function[{x, t}, -xMax < x < xMax && 0 < t < tMax];


(* ::Subsection:: *)
(*Animation frame rate*)


framesPerSecond = 24;
tMaxInSeconds = 4;
timeStep = tMax / (tMaxInSeconds * framesPerSecond);


(* ::Subsection:: *)
(*Main options*)


xMaxWithPadding = 1.1 xMax;
mainOptions = {
  ImageSize -> 240,
  PlotRange -> {{-xMaxWithPadding, xMaxWithPadding}, Automatic},
  {}
};


(* ::Section:: *)
(*Graphics objects*)


(* ::Subsection:: *)
(*Car*)


car[x_, t_, densityFunction_: (Indeterminate &)] := Graphics @ {
  carBorderStyle,
  densityColour @ densityFunction[x, t],
  Rectangle[
    {-carLength, -carWidth/2},
    {0, carWidth/2}
  ] // Translate[#, {x, t}] &
};


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
    xCharacteristicBefore, xCharacteristicAfter,
    xCharacteristicFan, pValues,
    densityFunction,
    numberOfCars,
    x0BeforeList, x0AfterList,
    xTrajectory, xTrajectoryList,
    density, trajectories, characteristics,
    timeStart, timeEnd,
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
  (* Characteristic curves *)
  xCharacteristicBefore[x0_][t_] := x0 + cBefore * t;
  xCharacteristicAfter[x0_][t_] := x0 + cAfter * t;
  xCharacteristicFan[p_][t_] := Rescale[p, {0, 1}, {cBefore, cAfter}] t;
  (* Values of p (proportion) to plot for the transition fan *)
  pValues = Subdivide[8] // Rest;
  (* Density function *)
  densityFunction[x_, t_] :=
    Piecewise @ {
      {Mean @ {nBefore, nAfter}, x == t == 0},
      {nBefore, x < xCharacteristicBefore[0][t]},
      {nAfter, x > xCharacteristicAfter[0][t]},
      {Rescale[x, {cBefore * t, cAfter * t}, {nBefore, nAfter}], True}
    };
  (* Initial positions for characteristics and trajectories *)
  numberOfCars = laneHalfLength / carLength // Floor;
  x0BeforeList = Table[-n * carMaxDensityDisplacement, {n, 0, numberOfCars}];
  x0AfterList = Table[n * carMaxDensityDisplacement, {n, numberOfCars}];
  (* Trajectories *)
  xTrajectory[x0_] :=
    NDSolveValue[
      {
        \[FormalX]'[t] == preferredSpeed @ densityFunction[\[FormalX][t], t],
        \[FormalX][0] == x0
      }
      , \[FormalX]
      , {t, 0, tMax}
    ];
  xTrajectoryList = Table[xTrajectory[x0], {x0, x0BeforeList}];
  (* Static graphics *)
  density =
    DensityPlot[
      densityFunction[x, t]
      , {x, -xMax, xMax}
      , {t, 0, tMax}
      , ColorFunction -> densityColour
      , Exclusions -> None
    ];
  trajectories =
    ParametricPlot[
      Table[{x[t], t}, {x, xTrajectoryList}]
      , {t, 0, tMax}
      , PlotStyle -> trajectoryStyle
      , RegionFunction -> spacetimeRegionFunction
    ];
  characteristics =
    ParametricPlot[
      {
        Table[{xCharacteristicBefore[x0][t], t}, {x0, x0BeforeList}],
        Table[{xCharacteristicAfter[x0][t], t}, {x0, x0AfterList}],
        Table[{xCharacteristicFan[p][t], t}, {p, pValues}],
        Nothing
      }
      , {t, 0, tMax}
      , PlotStyle -> characteristicStyle
      , RegionFunction -> spacetimeRegionFunction
    ];
  (* Build list of frames *)
  timeStart = 0;
  timeEnd = tMax;
  frameList =
    Table[
      Show[
        (* Static *)
        lane,
        density,
        characteristics,
        trajectories,
        spacetimeAxes,
        (* Cars along trajectories *)
        Table[car[x[time], time, densityFunction], {x, xTrajectoryList}],
        (* Cars along road *)
        Table[car[x[time], laneVerticalOffset, densityFunction], {x, xTrajectoryList}],
        {}
        , mainOptions
      ]
      , {time, timeStart, timeEnd, timeStep}
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
]

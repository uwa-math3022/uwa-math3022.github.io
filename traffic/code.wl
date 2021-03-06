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


(* Lane half-length *)
laneHalfLength = 12 carLength;
laneHalfWidth = 1 carWidth;


laneVerticalOffset = -2 laneHalfWidth;
applyLaneVerticalOffset[primitives_] := Translate[primitives, {0, laneVerticalOffset}];


(* ::Subsection:: *)
(*Traffic light*)


trafficLightAspectRadius = 4/5 carLength;
trafficLightAspectDisplacement = (2 + 1/2) trafficLightAspectRadius;
trafficLightPadding = 2/3 trafficLightAspectRadius;
trafficLightRoundingRadius = 2/3 trafficLightAspectRadius;


trafficLightHalfWidth = trafficLightAspectRadius + trafficLightPadding;
trafficLightHalfHeight = trafficLightPadding + trafficLightAspectRadius + trafficLightAspectDisplacement;


(* ::Subsection:: *)
(*Styles*)


symbol[char_] := Style[char, Italic];
symbolDifferential[char_] := Row @ {"d", symbol[char]};
symbolSubscript[char_, sub_] := Subscript[symbol[char], sub];
rowDivide[num_, den_] := Row[{num, den}, "/"];


applyTextStyle[text_] := Style[text, 14];


theoryImageSize = 180;
theoryLabelStyle = Directive[Black, 14];
theoryCurveStyle = Thickness[0.025];


laneStyle = GrayLevel[2/3];


densityColour[Indeterminate] = White;
densityColour[density_] := ColorData["LightTemperatureMap"][density];


characteristicStyle = RGBColor["darkviolet"];
trajectoryStyle = Yellow;
shockwaveStyle = Red;
timeSliceStyle = Red;
signalStyle = Green;


carBorderStyle = EdgeForm[Black];


trafficLightMountStyle = Black;
trafficLightAspectBorderStyle = Directive[Thick, White];


(* ::Subsection:: *)
(*Spacetime diagram plot range*)


(* Plot range *)
xMax = 2/3 laneHalfLength;
tMax = 2 xMax;
spacetimeRegionFunction = Function[{x, t}, -xMax < x < xMax && 0 < t < tMax];


(* ::Subsection:: *)
(*Animation frame rate*)


framesPerSecond = 12;
tMaxInSeconds = 4;
timeStep = tMax / (tMaxInSeconds * framesPerSecond);


(* Padding before time == 0 *)
timePrePaddingProportion = 1/20;


(* ::Subsection:: *)
(*Main options*)


mainOptions = {
  ImageSize -> 144,
  PlotRange -> {1.5 {-xMax, xMax}, Automatic},
  {}
};


(* ::Section:: *)
(*Graphics objects*)


(* ::Subsection:: *)
(*Time slice*)


timeSlice[t_] := Graphics @ {
  timeSliceStyle,
  Line @ {{-laneHalfLength, t}, {laneHalfLength, t}}
};


(* ::Subsection:: *)
(*Car*)


car[x_, t_, density_: Indeterminate] := Graphics @ {
  carBorderStyle,
  densityColour @ density,
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
(*Signal line*)


signal[x_, t_] := Graphics @ {
  signalStyle,
  Line @ {
    {x, t + carWidth / 2},
    {x, laneVerticalOffset - laneHalfWidth}
  }
};


(* ::Subsection:: *)
(*Traffic light*)


trafficLightHorizontalOffset = 5/4 xMax;
trafficLightVerticalOffset = 1/2 tMax;
applyTrafficLightOffset[primitives_] :=
  Translate[primitives, {trafficLightHorizontalOffset, trafficLightVerticalOffset}];


trafficLight[colour_] := Graphics @ applyTrafficLightOffset @ {
  (* Mount *)
  trafficLightMountStyle,
  Rectangle[
    {-trafficLightHalfWidth, -trafficLightHalfHeight},
    {trafficLightHalfWidth, trafficLightHalfHeight}
    , RoundingRadius -> trafficLightRoundingRadius
  ],
  (* Active aspect *)
  Which[
    colour == "red", {
      Red,
      Disk[{0, trafficLightAspectDisplacement}, trafficLightAspectRadius]
    },
    colour == "amber", {
      Yellow,
      Disk[{0, 0}, trafficLightAspectRadius]
    },
    colour == "green", {
      Green,
      Disk[{0, -trafficLightAspectDisplacement}, trafficLightAspectRadius]
    },
    True, {}
  ],
  (* Aspect borders *)
  trafficLightAspectBorderStyle,
  Table[
    Circle[{0, n * trafficLightAspectDisplacement}, trafficLightAspectRadius]
    , {n, -1, 1}
  ],
  {}
};


(* ::Subsection:: *)
(*Spacetime axes*)


axesPadding = 1.75 carLength;
spacetimeAxes = Graphics @ {
  (* x-axis *)
  Arrow @ {{-xMax, 0}, {xMax + axesPadding, 0}},
  Text[
    symbol["x"] // applyTextStyle
    , {xMax + axesPadding, 0}
    , {0, -1}
  ],
  (* t-axis *)
  Arrow @ {{-xMax, 0}, {-xMax, tMax + axesPadding}},
  Text[
    symbol["t"] // applyTextStyle
    , {-xMax, tMax + axesPadding}
    , {-3, 0}
  ],
  {}
};


(* ::Section:: *)
(*Traffic curves*)


(* ::Subsection:: *)
(*Preferred speed*)


ParametricPlot[
  {density, preferredSpeed[density]}
  , {density, 0, 1}
  , AspectRatio -> 1
  , AxesLabel -> symbol /@ {"N", "V"}
  , ColorFunction -> densityColour
  , ColorFunctionScaling -> False
  , ImageSize -> theoryImageSize
  , LabelStyle -> theoryLabelStyle
  , PlotStyle -> theoryCurveStyle
  , Ticks -> {
      {{1, symbolSubscript["N", "max"]}},
      {{1, symbolSubscript["V", "max"]}}
    }
] // Export[
  FileNameJoin @ {NotebookDirectory[], "preferred-speed.png"},
  #
] &


(* ::Subsection:: *)
(*Carried flux*)


ParametricPlot[
  {density, carriedFlux[density]}
  , {density, 0, 1}
  , AspectRatio -> 1 / Sqrt[2]
  , AxesLabel -> symbol /@ {"N", "F"}
  , ColorFunction -> densityColour
  , ColorFunctionScaling -> False
  , ImageSize -> theoryImageSize
  , LabelStyle -> theoryLabelStyle
  , PlotStyle -> theoryCurveStyle
  , Ticks -> {
      {{1, symbolSubscript["N", "max"]}},
      {{1/4, symbolSubscript["F", "max"]}}
    }
] // Export[
  FileNameJoin @ {NotebookDirectory[], "carried-flux.png"},
  #
] &


(* ::Subsection:: *)
(*Signal speed*)


ParametricPlot[
  {density, signalSpeed[density]}
  , {density, 0, 1}
  , AspectRatio -> 1
  , AxesLabel -> {symbol["N"], symbolDifferential["F"] / symbolDifferential["N"]}
  , ColorFunction -> densityColour
  , ColorFunctionScaling -> False
  , ImageSize -> theoryImageSize
  , LabelStyle -> theoryLabelStyle
  , PlotStyle -> theoryCurveStyle
  , Ticks -> {
      {{1/2, symbolSubscript["N", "max"] / 2}, {1, symbolSubscript["N", "max"]}},
      {{-1, -symbolSubscript["V", "max"]}, {1, symbolSubscript["V", "max"]}}
    }
] // Export[
  FileNameJoin @ {NotebookDirectory[], "signal-speed.png"},
  #
] &


(* ::Section:: *)
(*Case 1: Light change*)


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
    stopLine, laneArrowMarking,
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
      {nBefore, x == t == 0},
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
      , ColorFunctionScaling -> False
      , Exclusions -> None
      , PlotPoints -> 50
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
  stopLine = Graphics @ {
    Directive[Thick, White],
    Line @ {{carMaxDensityBuffer, -laneHalfWidth}, {carMaxDensityBuffer, laneHalfWidth}}
      // applyLaneVerticalOffset
  };
  laneArrowMarking = Graphics @ {
    Directive[Thick, White],
    Arrow @ {{-3/2 carMaxDensityDisplacement, 0}, {0, 0}}
      // applyLaneVerticalOffset
  };
  (* Build list of frames *)
  timeStart = -timePrePaddingProportion * tMax;
  timeEnd = tMax;
  frameList =
    Table[
      Show[
        (* Static *)
        lane,
        stopLine,
        laneArrowMarking,
        density,
        characteristics,
        trajectories,
        spacetimeAxes,
        (* Current slice of time *)
        timeSlice[time],
        (* Cars along trajectories *)
        Table[
          car[x[#], #, densityFunction[x[#], #]] &
            @ Max[time, 0]
          , {x, xTrajectoryList}
        ],
        (* Cars along lane *)
        Table[
          car[x[#], laneVerticalOffset, densityFunction[x[#], #]] &
            @ Max[time, 0]
          , {x, xTrajectoryList}
        ],
        (* Signal to go *)
        signal[xCharacteristicBefore[0][#], #] &
          @ Max[time, 0],
        (* Traffic light *)
        trafficLight @ Piecewise @ {
          {"red", time < 0},
          {"green", True}
        },
        {}
        , mainOptions
      ]
      , {time, timeStart, timeEnd, timeStep}
    ];
  Export[
    FileNameJoin @ {NotebookDirectory[], "light-change.gif"},
    frameList
    , "AnimationRepetitions" -> Infinity
    , "DisplayDurations" -> 1 / framesPerSecond
  ]
]


(* ::Section:: *)
(*Case 2: Pile up*)


(*
  {before}  -->  {after}
  N == 3/5  -->  N == 4/5
  V == 2/5  -->  V == 1/5
  F == 6/25 -->  F == 4/25
  V{shock} == (F{before} - F{after}) / (N{before} - N{after}) == -2/5
*)
Module[
  {
    nBefore, nAfter,
    vBefore, vAfter,
    fBefore, fAfter,
    cBefore, cAfter,
    vShockwave, xShockwave,
    xCharacteristicBefore, xCharacteristicAfter,
    tShockBefore, tShockAfter,
    densityFunction,
    numberOfCars,
    x0BeforeList, x0AfterList,
    xTrajectory, xTrajectoryList,
    density, shockwaveInterface, trajectories, characteristics,
    timeStart, timeEnd,
    frameList,
    dummyForTrailingCommas
  },
  (* Densities *)
  nBefore = 3/5;
  nAfter = 4/5;
  (* Speeds *)
  vBefore = preferredSpeed[nBefore];
  vAfter = preferredSpeed[nAfter];
  (* Fluxes *)
  fBefore = carriedFlux[nBefore];
  fAfter = carriedFlux[nAfter];
  (* Signal speeds *)
  cBefore = signalSpeed[nBefore];
  cAfter = signalSpeed[nAfter];
  (* Shockwave speed *)
  vShockwave = (fBefore - fAfter) / (nBefore - nAfter);
  (* Shockwave interface *)
  xShockwave[t_] := vShockwave * t;
  (* Characteristic curves *)
  xCharacteristicBefore[x0_][t_] := x0 + cBefore * t;
  xCharacteristicAfter[x0_][t_] := x0 + cAfter * t;
  (* Shock time (when characteristics meet the interface) *)
  tShockBefore[x0_] := x0 / (vShockwave - cBefore);
  tShockAfter[x0_] := x0 / (vShockwave - cAfter);
  (* Density function *)
  densityFunction[x_, t_] :=
    Piecewise @ {
      {nBefore, x < xShockwave[t]},
      {nAfter, True}
    };
  (* Initial positions for characteristics and trajectories *)
  numberOfCars = laneHalfLength / carLength // Floor;
  x0BeforeList = Table[-n * carMaxDensityDisplacement / nBefore, {n, numberOfCars}];
  x0AfterList = Table[n * carMaxDensityDisplacement / nAfter, {n, 0, numberOfCars}];
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
  xTrajectoryList = Table[xTrajectory[x0], {x0, Join[x0BeforeList, x0AfterList]}];
  (* Static graphics *)
  density =
    DensityPlot[
      densityFunction[x, t]
      , {x, -xMax, xMax}
      , {t, 0, tMax}
      , ColorFunction -> densityColour
      , ColorFunctionScaling -> False
      , Exclusions -> None
      , PlotPoints -> 50
    ];
  shockwaveInterface =
    ParametricPlot[
      {xShockwave[t], t}
      , {t, 0, tMax}
      , PlotStyle -> shockwaveStyle
    ];
  trajectories =
    ParametricPlot[
      Table[{x[t], t}, {x, xTrajectoryList}]
      , {t, 0, tMax}
      , PlotStyle -> trajectoryStyle
      , RegionFunction -> spacetimeRegionFunction
    ];
  characteristics = {
    Table[
      ParametricPlot[
        {xCharacteristicBefore[x0][t], t}
        , {t, 0, tShockBefore[x0]}
        , PlotStyle -> characteristicStyle
        , RegionFunction -> spacetimeRegionFunction
      ]
      , {x0, x0BeforeList}
    ],
    Table[
      ParametricPlot[
        {xCharacteristicAfter[x0][t], t}
        , {t, 0, tShockAfter[x0]}
        , PlotStyle -> characteristicStyle
        , RegionFunction -> spacetimeRegionFunction
      ]
      , {x0, x0AfterList // Rest}
    ],
    {}
  };
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
        shockwaveInterface,
        spacetimeAxes,
        (* Current slice of time *)
        timeSlice[time],
        (* Cars along trajectories *)
        Table[
          car[x[#], #, densityFunction[x[#], #]] &
            @ Max[time, 0]
          , {x, xTrajectoryList}
        ],
        (* Cars along lane *)
        Table[
          car[x[#], laneVerticalOffset, densityFunction[x[#], #]] &
            @ Max[time, 0]
          , {x, xTrajectoryList}
        ],
        (* Shockwave *)
        signal[xShockwave[#], #]&
          @ Max[time, 0],
        {}
        , mainOptions
      ]
      , {time, timeStart, timeEnd, timeStep}
    ];
  Export[
    FileNameJoin @ {NotebookDirectory[], "pile-up.gif"},
    frameList
    , "AnimationRepetitions" -> Infinity
    , "DisplayDurations" -> 1 / framesPerSecond
  ]
]

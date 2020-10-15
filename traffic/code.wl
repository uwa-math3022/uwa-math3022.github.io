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


applyTextStyle[text_] := Style[text, 14];


laneStyle = GrayLevel[2/3];


densityColour[Indeterminate] = White;
densityColour[density_] := ColorData["LightTemperatureMap"][density];
characteristicStyle = RGBColor["darkviolet"];
trajectoryStyle = Yellow;
timeSliceStyle = Red;
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
        (* Cars along road *)
        Table[
          car[x[#], laneVerticalOffset, densityFunction[x[#], #]] &
            @ Max[time, 0]
          , {x, xTrajectoryList}
        ],
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
    FileNameJoin @ {NotebookDirectory[], "traffic-light.gif"},
    frameList
    , "AnimationRepetitions" -> Infinity
    , "DisplayDurations" -> 1 / framesPerSecond
  ]
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

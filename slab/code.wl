(* ::Package:: *)

ClearAll["Global`*"];


(* ::Section:: *)
(*Eigenvalues (run this section first)*)


(*
  ----------------------------------------------------------------
  WARNING: the method in this cell is for advanced Mathematica users only.
  Everyone else, JUST USE FindRoot AND CHECK THE RESULT WITH A PLOT.
  ----------------------------------------------------------------
  The transcendental equation for the eigenvalues is
    tan(lambda) == gamma / lambda,
  or
    tan(lambda) - gamma / lambda == 0
  where gamma is the Biot number.
  From Sturm--Liouville theory we already know that
  the roots will be lambda_1 < lambda_2 < ... to infinity,
  and by looking at the equation we see that lambda_n
  lies between the n-th root and the n-th pole of tan, i.e.
    (n - 1) pi < lambda_n < (n - 1/2) pi.
  In my opinion directly using FindRoot is not a good method
  because you need to manually supply an initial guess,
  and if the guess is poor you might get a root for a different n.
  Instead the n-th root is better found by using InverseFunction
  over each of the intervals for lambda_n above.
  This is slower, but (1) represents each root symbolically
  and (2) is guaranteed to give the correct root for each n.
*)
(* Transcendental function *)
transcendental[gamma_][n_] :=
  Function[{lam},
    ConditionalExpression[
      Tan[lam] - gamma / lam,
      (n - 1) Pi < lam < (n - 1/2) Pi
    ]
  ];
(* Eigenvalue lambda_n *)
lambda[gamma_][n_] := InverseFunction[transcendental[gamma][n]][0];


(* ::Section:: *)
(*Eigenvalue plot*)


Module[
  {
    gamma,
    nMax, lamMax,
    lambdaList,
    dummyForTrailingCommas
  },
  (* Constants *)
  gamma = 2;
  nMax = 4;
  lamMax = (nMax - 1/2) * Pi;
  (* Eigenvalues to be plotted *)
  lambdaList = Table[lambda[gamma][n], {n, nMax}];
  (* Plot *)
  Plot[{Tan[lam], gamma / lam}, {lam, 0, lamMax}
    , AspectRatio -> 1 / 1.3
    , AxesLabel -> {"\[Lambda]", Automatic}
    , Epilog -> {Blue,
        (* Roots (at intersections of curves) *)
        PointSize[Large],
        Point @ Table[{lam, Tan[lam]}, {lam, lambdaList}],
        (* Roots (guide lines to horizontal axis) *)
        Dashed,
        Table[
          Line @ {{lam, Tan[lam]}, {lam, 0}}
          , {lam, lambdaList}
        ],
        (* Roots (horizontal axis labels) *)
        Table[
          Text[
            Subscript["\[Lambda]", n] // Style[#, 18] &
            , {lambdaList[[n]], 0}
            , {0, 1.5}
          ]
          , {n, nMax}
        ],
        {}
      }
    , LabelStyle -> Directive[Black, 15]
    , PlotLabel -> Row @ {"Eigenvalues for ", HoldForm["\[Gamma]"] == gamma}
    , PlotLegends -> {Tan["\[Lambda]"], "\[Gamma]" / "\[Lambda]"}
  ]
] // Export[
  FileNameJoin @ {NotebookDirectory[], "eigenvalues.png"},
  #
] &


(* ::Section:: *)
(*Eigenvalues table*)


Module[
  {
    gamma,
    nMax,
    dummyForTrailingCommas
  },
  gamma = 2;
  nMax = 5;
  Table[{n, lambda[gamma][n] // N}, {n, nMax}] // TableForm
]


(* Using FindRoot (which is the "intended" method) *)
Module[{gamma, nMax, initialGuess, root},
  gamma = 2;
  nMax = 5;
  Table[
    initialGuess = (n - 3/4) Pi;
    root = FindRoot[Tan[#] - gamma / # &, {initialGuess}];
    {n, root}
  , {n, nMax}
  ] // TableForm
]


(* ::Section:: *)
(*Diagram*)


Module[
  {
    symbol,
    styledText,
    slabHeight, slabSemiThickness, slabStyle,
    slabDimensionOffset, slabDimensionStyle,
    coolingArrowNumber, coolingArrowSquigglePoints, coolingArrow,
    coolingArrowXCoordinates, coolingArrowYCoordinates, coolingArrowStyle,
    environmentTemperatureXCoordinate,
    dummyForTrailingCommas
  },
  (* Style functions *)
  symbol[expr_] := Style[expr, Italic];
  styledText[expr_, balance___] := Text[Style[expr, 18], balance];
  (* Slab *)
  slabHeight = 2;
  slabSemiThickness = 0.15;
  slabStyle = Directive[EdgeForm[Black], FaceForm[LightOrange]];
  slabDimensionOffset = 0.05 slabHeight;
  slabDimensionStyle = Arrowheads @ {-Medium, Medium};
  (* Cooling arrows *)
  coolingArrowNumber = 6;
  coolingArrowSquigglePoints =
    0.1 slabSemiThickness * {
      {0, 0},
      {2, 1},
      {4, 0},
      {6, -1},
      {8, 0},
      {10, 0},
      {12, 0},
      {14, 0},
      Nothing
    };
  coolingArrow = Arrow @ BSplineCurve[coolingArrowSquigglePoints];
  coolingArrowXCoordinates = 1.7 {-1, 1} slabSemiThickness;
  coolingArrowYCoordinates =
    slabHeight * (
      1 / (2 coolingArrowNumber) + Subdivide[coolingArrowNumber]
    ) // Most;
  coolingArrowStyle = Directive[Arrowheads[Medium], Thick];
  (* Environment temperature *)
  environmentTemperatureXCoordinate = 0.4 slabHeight;
  (* Diagram *)
  Show[
    (* Slab *)
    Graphics @ {slabStyle,
      Rectangle[
        {-slabSemiThickness, 0},
        {slabSemiThickness, slabHeight}
      ]
    },
    Graphics @ {slabDimensionStyle,
      Arrow @ {
        {-slabSemiThickness, -slabDimensionOffset},
        {slabSemiThickness, -slabDimensionOffset}
      }
    },
    Graphics @ styledText[
      2 symbol["L"]
      , {0, -slabDimensionOffset}
      , {0, 1.3}
    ],
    (* Cooling arrows *)
    Graphics @ {coolingArrowStyle,
      Table[
        coolingArrow
          // Rotate[#, Arg[x], {0, 0}] &
          // Translate[#, {x, y}] &
        , {x, coolingArrowXCoordinates}
        , {y, coolingArrowYCoordinates}
      ]
    },
    (* Initial temperature *)
    Graphics @ styledText[
      Subscript[symbol["T"], "I"]
      , {0, slabHeight / 2}
    ],
    (* Environment temperature *)
    Table[
      Graphics @ styledText[
        Subscript[symbol["T"], "E"]
        , {x, slabHeight / 2}
      ]
    , {x, {-1, 1} environmentTemperatureXCoordinate}
    ],
    {}
    , ImageSize -> 200
  ]
] // Export[
  FileNameJoin @ {NotebookDirectory[], "diagram.png"},
  #
] &

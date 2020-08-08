(* ::Package:: *)

ClearAll["Global`*"];


(* ::Section:: *)
(*Eigenvalues (run this section first)*)


(*
  The transcendental equation for the eigenvalues is
    tan(lambda) == gamma / lambda,
  or
    tan(lambda) - gamma / lambda == 0
  where gamma is the Biot number.
  From Sturm--Liouville theory we already know that
  the roots will be lambda_1 < lambda_2 < ... to infinity,
  and by looking at the equation we see that lambda_n
  lies between the n-th root and the n-th pole of tan, i.e.
    (n - 1) pi < lambda < (n - 1/2) pi.
  In my opinion directly using FindRoot is not a good method
  because you need to manually supply an initial guess,
  and if the guess is poor you might a root for a different n.
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
  gamma = 1;
  nMax = 4;
  lamMax = (nMax - 1/2) * Pi;
  (* Eigenvalues to be plotted *)
  lambdaList = Table[lambda[gamma][n], {n, nMax}];
  (* Plot *)
  Plot[{Tan[lam], gamma / lam}, {lam, 0, lamMax}
    , Epilog -> {Red,
        (* Roots (at intersections of curves) *)
        PointSize[Large],
        Point @ Table[{lam, Tan[lam]}, {lam, lambdaList}],
        {}
      }
    , LabelStyle -> Directive[Black, 15]
    , PlotLegends -> {Tan["\[Lambda]"], "\[Gamma]" / "\[Lambda]"}
  ]
]

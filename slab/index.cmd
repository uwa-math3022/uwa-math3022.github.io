{+ resources/syntax.cmd +}

%%
  %title  Heat equation: A slab cooling
  %date-modified  2020-08-xx
  \resources:maths
%%


# %title #

\noscript

----
**Your work doesn't need to be as detailed as this.**
----

##{#problem} Problem ##

$
  \gdef \TI {T_\mathrm{I}}
  \gdef \TE {T_\mathrm{E}}
$

----
Consider a uniform slab of thickness $2L$, [thermal conductivity][k] $k$,
[specific heat capacity][c] $c$, and [density][rho] $\rho$ .
----
----
Suppose the slab is initially at temperature $\TI$ throughout,
and thereafter loses heat to the environment at (lower) temperature $\TE$
via [Newtonian cooling][newton] through its two faces,
with a [heat transfer coefficient][h] of $h$.
----
----
What happens?
----

@[k] https://en.wikipedia.org/wiki/Thermal_conductivity @
@[c] https://en.wikipedia.org/wiki/Specific_heat_capacity @
@[rho] https://en.wikipedia.org/wiki/Density @

@[newton] https://en.wikipedia.org/wiki/Newton%27s_law_of_cooling @
@[h] https://en.wikipedia.org/wiki/Heat_transfer_coefficient @


##{#quantities} Quantities ##

----
Take the slab to be the region $-L \le x \le L$.
By symmetry, the temperature profile will be an even function of $x$,
so we need only consider the right half $0 \le x \le L$
by using a zero-slope (or insulating) boundary condition at $x = 0$.
----
----
We have the following:
----

''''
==
  ;{c2} Independent variables
==
  , $x$
  , position ($0 \le x \le L$)
==
  , $t$
  , time ($t \ge 0$)
==
  ;{c2} Dependent variable
==
  , $T$
  , temperature
==
  ;{c2} Constants
==
  , $L$
  , semi-thickness
==
  , $k$
  , [thermal conductivity][k]
==
  , $c$
  , [specific heat capacity][c]
==
  , $\rho$
  , density
==
  , $\TI$
  , initial temperature
==
  , $\TE$
  , environment temperature
==
  , $h$
  , [heat transfer coefficient][h]
''''


##{#defining-equations} Defining equations ##

###{#pde} Partial differential equation (PDE) ###

----
__Heat equation__ in $T = T (x, t)$, throughout the slab, for all time:
----

$${.important}
  \rho c \frac{\pd T}{\pd t} = k \frac{\pd^2 T}{{\pd x}^2}
$$

###{#boundary-conditions} Boundary conditions (BCs) ###

----
Symmetry along the central plane $x = 0$:
----

$${.important}
  \eval{\frac{\pd T}{\pd x}}_{x = 0} = 0
$$

----
[Newtonian cooling][newton] along the right-hand face $x = L$
(flux through the surface is proportional to the difference
between the surface temperature and the environment temperature):
----

$${.important}
  \eval{-k \frac{\pd T}{\pd x}}_{x = L} = \eval{h (T - \TE)}_{x = L}
$$

----
Both sides of the equation have dimensions of power per area.
The [heat transfer coefficient][h] $h$ has dimensions of
power per area per temperature.
----

###{#initial-condition} Initial condition (IC) ###

----
Temperature is $\TI$ throughout the slab, initially:
----

$${.important}
  \eval{T}_{t = 0} = \TI
$$


##{#scaling} Scaling ##

<##
  Styles
  * unscaled (dimensional): colour-g
  * scaled (dimensionless): colour-v
##>
$
  \gdef \unscaled #1 {\colg{#1}}
  \gdef \scaled #1 {\colv{#1'}}
$
{% \[ unscaled / (.*?) / \] % [g/ \1 /] %}
{% \[ scaled / (.*?) / \] % [v/ \1 /] %}

###{#scaling-temperature} Temperature ###

----
As in the [rod problem](/rod/#scaling-temperature)
we are given two temperatures, in this case
the initial temperature $\TI$ and the environment temperature $\TE$.
We put
----
$${.important}
  \unscaled{T} = \TE + (\TI - \TE) \scaled{T}
$$
----
so that the scaled initial temperature is $\scaled{T} = 1$
and the scaled environment temperature is $\scaled{T} = 0$.
----

###{#scaling-position} Position ###

$${.important}
  \unscaled{x} = L \scaled{x}
$$

###{#scaling-time} Time ###

----
As in the [rod problem](/rod/#scaling-time)
the time scale isn't immediately obvious,
so we put
----
$${.important}
  \unscaled{t} = \tau \scaled{t},
$$
----
**with the time scale $\tau$ yet to be determined, i.e.~*free*\/**.
----


##{#dimensionless-groups} Dimensionless groups ##

<##
  Styles
  * dimensionless group: colour-r
##>
$
  \gdef \group #1 {\colr{\squarebr{#1}}}
$
{% \[ group / (.*?) / \] % [r/ \1 /] %}

----
After moving from [unscaled/ unscaled /] to [scaled/ scaled /] variables,
the PDE, boundary conditions, and initial condition become the following:
----
$$
\begin{gathered}
  <## PDE ##>
  \frac{\pd\scaled{T}}{\pd\scaled{t}}
    =
  \group{\frac{k \tau}{\rho c L^2}}
  \frac{\pd^2 \scaled{T}}{{\pd\scaled{x}}^2}
    \\[\tallspace]
  \begin{aligned}
    <## BCs ##>
    \eval{\frac{\pd\scaled{T}}{\pd\scaled{x}}}_{\scaled{x} = 0} &= 0
      \\[\tallspace]
    \eval{-\frac{\pd\scaled{T}}{\pd\scaled{x}}}_{\scaled{x} = 1}
      &=
    \eval{\group{\frac{h L}{k}} \scaled{T}}_{\scaled{x} = 1}
      \\[\tallspace]
    <## IC ##>
    \eval{\scaled{T}}_{\scaled{t} = 0} &= 1
  \end{aligned}
\end{gathered}
$$

----
Since there are **two dimensionless groups**
but only **one free scale** $\tau$,
only one of the groups can be eliminated.
In particular, $\tau$ only appears in the PDE group,
so only it can be eliminated:
----
$$
  \group{\frac{k \tau}{\rho c L^2}} = 1
$$
$${.important}
  \tau = \frac{\rho c L^2}{k}
$$
----
(Quick mental check: Thicker slab implies longer time scale?
Better conductor implies shorter time scale?
Yes to both.)
----
----
The second dimensionless group $\group{h L / k}$
(called the [Biot number][gamma])
cannot be eliminated because $h$, $L$, and $k$ are all *given*, and NOT free.
To save writing, let us call it $\gamma$ for short:
----
$${.important}
  \gamma = \group{\frac{h L}{k}}
$$

@[gamma] https://en.wikipedia.org/wiki/Biot_number @

----
Finally we **drop the primes**:
----
$${.important}
\begin{gathered}
  <## PDE ##>
  \frac{\pd T}{\pd t} = \frac{\pd^2 T}{{\pd x}^2}
    \\[\tallspace]
  \begin{aligned}
    <## BCs ##>
    \eval{\frac{\pd T}{\pd x}}_{x = 0} &= 0
      \\[\tallspace]
    \eval{-\frac{\pd T}{\pd x}}_{x = 1} &= \eval{\gamma T}_{x = 1}
      \\[\tallspace]
    <## IC ##>
    \eval{T}_{t = 0} &= 1
  \end{aligned}
\end{gathered}
$$


##{#equilibrium-solution} Equilibrium solution ##

----
Unlike the [rod example](/rod/#transient-solution),
here the PDE and the two boundary conditions are *already* homogeneous.
There is no need to subtract out the equilibrium solution
because the equilibrium solution is identically zero
(corresponding to the slab completely cooling to the environment temperature).
So we may proceed to separation of variables:
----

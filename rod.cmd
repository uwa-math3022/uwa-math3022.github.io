{+ resources/syntax.cmd +}

%%
  %title  Heating a rod
  %date-modified  2020-07-24
  \resources:maths
%%


# %title #

\noscript

----
A fully worked heat-equation example.
**Your work doesn't need to be as detailed as this.**
----


## Problem ##

----
Consider a uniform rod with length $L$, density $\rho$, specific heat $c$,
and thermal conductivity $k$.
----
----
Suppose the rod is initially at temperature $T_0$ throughout.
At time $t = 0$:
----
====
* Fix the left end at lower temperature $T = T_0$
* Fix the right end at higher temperature $T = T_1$
====
----
What happens?
----


## Quantities ##

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
  , length
==
  , $\rho$
  , density
==
  , $c$
  , specific heat
==
  , $k$
  , thermal conductivity
==
  , $T_0$
  , lower temperature
==
  , $T_1$
  , higher temperature
''''


## Defining equations ##

### Partial differential equation (PDE) ###

----
Heat equation in $T = T (x, t)$, throughout the rod, for all time:
----

$${.important}
  \frac{\rho c}{k} \frac{\pd T}{\pd t} = \frac{\pd^2 T}{{\pd x}^2}
$$

### Boundary conditions (BCs) ###

----
Fixed temperature at the two ends, for all time:
----

$${.important}
\begin{aligned}
  \eval{T}_{x = 0} &= T_0 \\
  \eval{T}_{x = L} &= T_1
\end{aligned}
$$

### Initial condition (IC) ###

----
Temperature is $T_0$ throughout the rod, initially:
----

$${.important}
  \eval{T}_{t = 0} = T_0
$$


## Scaling ##

----
Units like metres and feet or Celsius and Fahrenheit are *arbitrary*,
and it is better to work in the *natural* units
which arise from the physical constants provided in the problem.
----
----
We move from [unscaled/ dimensional (unscaled) /] variables
to [scaled/ dimensionless (scaled) variables (marked with a prime) /]:
----

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

### Temperature ###

----
The natural temperature scale in the problem is $T_1 - T_0$,
the difference between the two prescribed temperatures.
Choose scaled temperature
----
$${.important}
  \unscaled{T} = T_0 + (T_1 - T_0) \scaled{T}
$$
----
so that in scaled terms, the lower temperature is $\scaled{T} = 0$
and the higher temperature is $\scaled{T} = 1$.
----

### Position ###

----
The natural length scale in the problem is $L$, the length of the rod.
Choose scaled position
----
$${.important}
  \unscaled{x} = L \scaled{x}
$$
----
so that in scaled terms, the left end of the rod is $\scaled{x} = 0$
and the right end of the rod is $\scaled{x} = 1$.
----

### Time ###

----
The time scale isn't immediately obvious, so choose scaled time
----
$${.important}
  \unscaled{t} = \tau \scaled{t}
$$
----
with the time scale $\tau$ to be determined.
----


## Dimensionless groups ##

----
We take the heat equation
----
$$
  \frac{\rho c}{k} \frac{\pd\unscaled{T}}{\pd\unscaled{t}} =
    \frac{\pd^2 \unscaled{T}}{{\pd\unscaled{x}}^2}
$$
----
and move from [unscaled/ unscaled /] to [scaled/ scaled /] variables
(use the chain rule):
----
$$
  \frac{\rho c}{k}
  \frac{(T_1 - T_0)}{\tau}
  \frac{\pd\scaled{T}}{\pd\scaled{t}}
    =
  \frac{(T_1 - T_0)}{L^2}
  \frac{\pd^2 \scaled{T}}{{\pd\scaled{x}}^2}
$$
----
Rearrange:
----

<##
  Styles
  * dimensionless group: colour-r
##>
$
  \gdef \group #1 {\colr{\squarebr{#1}}}
$
{% \[ group / (.*?) / \] % [r/ \1 /] %}

$$
  \group{\frac{\rho c L^2}{k \tau}}
  \frac{\pd\scaled{T}}{\pd\scaled{t}}
    =
  \frac{\pd^2 \scaled{T}}{{\pd\scaled{x}}^2}
$$

----
All of the [scaled/ scaled variables /] are [scaled/ dimensionless /],
therefore the bracketed term is a [group/ dimensionsless group /],
i.e.~just a number.
----

### Time scale ###

----
Currently the time scale $\tau$ is *free*;
it is not prescribed in the problem and we haven't defined it yet.
Because we have **one free scale** $\tau$ and **one dimensionless group**,
we can eliminate the dimensionless group\* by setting it equal to one
and solving for $\tau$:
----
$$
  \group{\frac{\rho c L^2}{k \tau}} = 1
$$
$${.important}
  \tau = \frac{\rho c L^2}{k}
$$
----
(\*NOTE:
if a problem has *more* dimensionless groups than there are free scales,
you won't be able to eliminate *all* of the dimensionless groups.)
----

### Making sense ###

----
At this point we pause to check:
does the time scale we have found make sense?
----
====
* $\tau \propto L^2$ \+
  If the rod is longer, it takes a longer time to reach equilibrium.
* $\tau \propto 1 / k$ \+
  If the rod is a better conductor, then $k$ is larger,
  so $\tau$ is smaller and it takes a shorter time to reach equilibrium.
====
----
Yes this makes sense.
----


## Finish scaling ##

----
Having eliminated the dimensionless group,
our heat equation is now
----
$$
  \frac{\pd\scaled{T}}{\pd\scaled{t}}
    =
  \frac{\pd^2 \scaled{T}}{{\pd\scaled{x}}^2}.
$$

----
We should also scale the boundary conditions and initial condition:
----
$$
\begin{aligned}
  \eval{\scaled{T}}_{\scaled{x} = 0} &= 0 \\
  \eval{\scaled{T}}_{\scaled{x} = 1} &= 1 \\
  \eval{\scaled{T}}_{\scaled{t} = 0} &= 0
\end{aligned}
$$

----
Writing primes everywhere is annoying,
so from here onward we **drop the primes**.
Altogether:
----
$${.important}
\begin{gathered}
  \frac{\pd T}{\pd t}
    =
  \frac{\pd^2 T}{{\pd x}^2}. \\[\tallspace]
  \eval{T}_{x = 0} = 0 \\
  \eval{T}_{x = 1} = 1 \\
  \eval{T}_{t = 0} = 0
\end{gathered}
$$


\END

\home

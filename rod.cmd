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

----
Units like metres and feet or Celsius and Fahrenheit are *arbitrary*,
and it is better to work in the *natural* units
which arise from the physical constants provided in the problem.
----
----
We move from [unscaled/ dimensional (unscaled) /] variables
to [scaled/ dimensionless (scaled) variables (marked with a prime) /]:
----

### Temperature ###

----
The natural temperature scale in the problem is $T_1 - T_0$,
the difference between the two prescribed temperatures.
Choose scaled temperature $\scaled{T}$ according to
----
$${.important}
  \unscaled{T} = T_0 + (T_1 - T_0) \scaled{T},
$$
----
so that in scaled terms, the lower temperature is $\scaled{T} = 0$
and the higher temperature is $\scaled{T} = 1$.
----

### Position ###

----
The natural length scale in the problem is $L$, the length of the rod.
Choose scaled position $\scaled{x}$ according to
----
$${.important}
  \unscaled{x} = L \scaled{x},
$$
----
so that in scaled terms, the left end of the rod is $\scaled{x} = 0$
and the right end of the rod is $\scaled{x} = 1$.
----

### Time ###

----
The time scale isn't immediately obvious,
so choose scaled time $\scaled{t}$ according to
----
$${.important}
  \unscaled{t} = \tau \scaled{t},
$$
----
with the time scale $\tau$ to be determined.
----


## Dimensionless groups ##

<##
  Styles
  * dimensionless group: colour-r
##>
$
  \gdef \group #1 {\colr{\squarebr{#1}}}
$
{% \[ group / (.*?) / \] % [r/ \1 /] %}

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
  \frac{\pd^2 T}{{\pd x}^2} \\[\tallspace]
  \eval{T}_{x = 0} = 0 \\
  \eval{T}_{x = 1} = 1 \\
  \eval{T}_{t = 0} = 0
\end{gathered}
$$


## Equilibrium solution ##

<##
  Styles
  * transient: colour-r
  * equilibrium: colour-b
##>
$
  \gdef \trans #1 {\colr{#1}}
  \gdef \equil #1 {\colb{#1}}
  \gdef \Ttr {\trans{T_\mathrm{tr}}}
  \gdef \Teq {\equil{T_\mathrm{eq}}}
$
{% \[ tr / (.*?) / \] % [r/ \1 /] %}
{% \[ eq / (.*?) / \] % [b/ \1 /] %}

----
After a long time, the heat going in at the right hand $\scaled{x} = 1$
will be in balance with the heat lost at the left hand $\scaled{x} = 0$.
The temperature profile $T$ will reach an equilibium profile $\Teq$
which may depend on the position $x$ but *not* on the time $t$.
In symbols,
----
$$
  \lim_{t \to \infty} T (x, t) = \Teq (x).
$$

----
Thus the PDE and boundary conditions simplify to
----
$${.important}
\begin{gathered}
  0 = \frac{\td^2 \Teq}{{\td x}^2} \\[\tallspace]
  \eval{\Teq}_{x = 0} = 0 \\
  \eval{\Teq}_{x = 1} = 1.
\end{gathered}
$$
----
(The initial condition ($t = 0$) is irrelevant at equilibrium.)
----
----
The three equations above say that
$\Teq (x)$ is a straight line function of $x$
passing throught $(x, \Teq) = (0, 0)$ and $(x, \Teq) = (1, 1)$,
so by inspection the equilibrium temperature profile is
----
$${.important}
  \Teq (x) = x.
$$


## Transient solution ##

### Subtract out equilibrium solution ###

----
*Before* doing separation of variables,
make sure to **subtract out the equilibrium solution**
so that the boundary conditions are *homogeneous*.
To do this, write the solution as a sum
of [eq/ equilibrium /] and [tr/ transient /] parts,
----
$${.important}
  T (x, t) = \Teq (x) + \Ttr (x, t)
$$
----
or
----
$$
  T = \Teq + \Ttr.
$$

----
Substituting these into the scaled equations, we get
----
$$
\begin{gathered}
  \cancel{\frac{\pd \Teq}{\pd t}} + \frac{\pd \Ttr}{\pd t}
    =
  \cancel{\frac{\pd^2 \Teq}{{\pd x}^2}} + \frac{\pd^2 \Ttr}{{\pd x}^2}
    \\[\tallspace]
  \cancel{\eval{\Teq}_{x = 0}} + \eval{\Ttr}_{x = 0} = \cancel{0} \\
  \cancel{\eval{\Teq}_{x = 1}} + \eval{\Ttr}_{x = 1} = \cancel{1} \\
  \eval{\Teq}_{t = 0} + \eval{\Ttr}_{t = 0} = 0.
\end{gathered}
$$
----
Since $\eval{\Teq}_{t = 0} = \eval{x}_{t = 0} = x$, these become
----
$${.important}
\begin{gathered}
  \frac{\pd \Ttr}{\pd t}
    =
  \frac{\pd^2 \Ttr}{{\pd x}^2}
    \\[\tallspace]
  \eval{\Ttr}_{x = 0} = 0 \\
  \eval{\Ttr}_{x = 1} = 1 \\
  \eval{\Ttr}_{t = 0} = -x.
\end{gathered}
$$

### Separation of variables ###

<##
  Styles
  * position: colour-g
  * time: colour-v
  * constant: colour-b
##>
$
  \gdef \pos #1 {\colg{#1}}
  \gdef \time #1 {\colv{#1}}
  \gdef \con #1 {\colb{#1}}
$
{% \[ pos / (.*?) / \] % [g/ \1 /] %}
{% \[ time / (.*?) / \] % [v/ \1 /] %}
{% \[ con / (.*?) / \] % [b/ \1 /] %}

----
Suppose that the [tr/ transient solution /]
is the product of a [pos/ function of position only /]
and a [time/ function of time only /],
----
$$
  \Ttr (x, t) = \pos{X (x)} \time{Y (t)}.
$$

----
(This may seem restrictive, but since the heat equation is linear
we can take linear combinations afterwards.)
Substituting this into the PDE for $\Ttr$, we get
----
$$
\begin{aligned}
  \frac{\pd (\pos{X} \time{Y})}{\pd \time{t}}
    &=
  \frac{\pd^2 (\pos{X} \time{Y})}{{\pd \pos{x}}^2}
    \\[\tallspace]
  \pos{X} \time{\frac{\td Y}{\td t}}
    &=
  \pos{\frac{\td^2 X}{{\td x}^2}} \time{Y}.
\end{aligned}
$$
----
Dividing through by $\pos{X} \time{Y}$:
----
$$
  \time{\frac{1}{Y} \frac{\td Y}{\td t}}
    =
  \pos{\frac{1}{X} \frac{\td^2 X}{{\td x}^2}}
$$
----
This says that [time/ a function of $t$ only /]
is equal to [pos/ a function of $x$ only /],
and this is supposed to be true for all $\time{t}$ and all $\pos{x}$.
----
----
__Q.__
  How can [time/ a function of $t$ /] be equal to [pos/ a function of $x$ /]?
\+
__A.__
  Both must equal the [con/ *same* constant /]:
----
$${.important}
  \time{\frac{1}{Y} \frac{\td Y}{\td t}}
    =
  \pos{\frac{1}{X} \frac{\td^2 X}{{\td x}^2}}
    =
  \con{-\lambda^2}.
$$
----
__Q.__
  Why can't the constant be zero or positive?
\+
__A.__
  Because those cases don't give useful solutions.
  In other units at UWA you're probably expected to show this every time,
  but here at MATH3022 we don't like wasting your time.
  Convince yourself why the zero and positive cases don't work
  in your own time and never do it again. Just put $-\lambda^2$.
----
----
Thus we have separated the PDE into two ODEs:
----

#### Time ####

$$
\begin{aligned}
  \time{\frac{\td Y}{\td t}} &= \con{-\lambda^2} \time{Y} \\[\tallspace]
  \time{Y (t)} &= C \ee ^ {\con{-\lambda^2} t}
\end{aligned}
$$

#### Position ####

$$
\begin{aligned}
  \pos{\frac{\td^2 X}{{\td x}^2}} &= \con{-\lambda^2} \pos{X} \\[\tallspace]
  \pos{X (x)} &= A \cos (\con{\lambda} x) + B \sin (\con{\lambda} x)
\end{aligned}
$$

#### Altogether ####

$$
  \Ttr (x, t) =
    \ee ^ {\con{-\lambda^2} t}
    \squarebr{A \cos (\con{\lambda} x) + B \sin (\con{\lambda} x)}
$$
----
(Here the constant $C$ has been absorbed into $A$ and $B$.)
----

### Boundary conditions ###

----
We then apply the boundary conditions at the two ends of the rod:
----

#### Left end ####

----
We have
----
$$
  \eval{\Ttr}_{x = 0} = \ee ^ {\con{-\lambda^2} t} \cdot A = 0
$$
----
which implies $A = 0$.
Therefore
----
$$
  \Ttr (x, t) = B \ee ^ {\con{-\lambda^2} t} \sin (\con{\lambda} x).
$$

#### Right end ####

----
We have
----
$$
  \eval{\Ttr}_{x = 1}
  = B \ee ^ {\con{-\lambda^2} t} \sin \con{\lambda}
  = 0
$$
----
and since we don't want $B = 0$ (which is boring),
we must have
----
$$
  \sin \con{\lambda} = 0
$$
$${.important}
  \con{\lambda} = \con{n} \pi, \quad n = 1, 2, 3, \dots.
$$

### Physical sense ###

----
To recap, our transient solution is the product of
an exponential decay in time and a sinusoid in position,
linked through the constant $\con{\lambda} = \con{n} \pi$:
----
$$
  \Ttr (x, t) = B \ee ^ {\con{-n^2} \pi^2 t} \sin (\con{n} \pi x)
$$
----
What does this mean physically?
----
====
* __Large $\con{n}$__ \+
  Components which are highly oscillatory in position
  decay **very** quickly.
  (Note that the $\con{n^2}$ in the exponent
  increases *much* faster than the $\con{n}$ in the sine.)
* __Small $\con{n}$__ \+
  Components which have long wavelength decay more slowly.
====



\END

\home

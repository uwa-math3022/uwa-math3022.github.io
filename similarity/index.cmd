{+ resources/syntax.cmd +}

%%
  %title  Fundamental plane-source similarity solution
  %date-modified  2020-08-xx
  \resources:maths
%%


# %title #

\noscript

----
**Your work doesn't need to be as detailed as this.**
----

----
Source code for the images: [code.wl] \+
\home
----
@[code.wl]
  https://github.com/uwa-math3022/uwa-math3022.github.io/blob/master/\
    plane/code.wl @

##{#problem} Problem ##

----
Consider an infinite block of [density] $\rho$, [specific heat capacity] $c$,
and [thermal conductivity] $k$.
Its [thermal diffusivity] is therefore $\kappa = k / (\rho c)$.
----
----
Suppose the block is initially at zero temperature throughout.
At time $t = 0$:
----
====
* Cram thermal energy per area $Q$ into the plane $x = 0$.
====
----
What happens?
----

@[density] https://en.wikipedia.org/wiki/Density @
@[specific heat capacity]
  https://en.wikipedia.org/wiki/Specific_heat_capacity @
@[thermal conductivity] https://en.wikipedia.org/wiki/Thermal_conductivity @
@[thermal diffusivity] https://en.wikipedia.org/wiki/Thermal_diffusivity @

----{.qa}
__Q.__
  How can you put a non-zero amount of thermal energy
  into a plane which has zero thickness?
\+
__A.__
  It's an idealisation, like a point charge.
  In the case of a point charge,
  the charge density is infinite but the amount of charge is *finite*.
  Here, the initial temperature of the plane $x = 0$ is infinite,
  but the energy per area is *finite*.
----


##{#quantities} Quantities ##

----
We find that it is convenient to define the constant
----
$$
  Q' = \frac{Q}{\rho c},
$$
----
because the defining equations for this problem can be written
in terms of the constants $Q'$ and $\kappa$ only
(rather than $Q$, $\rho$, $c$, and $k$).
Note that $Q'$ is to $Q$ as $\kappa$ is to $k$.
----

''''
|^
==
  ;{c2} Independent variables
|:
==
  , $x$
  , position ($-\infty < x < \infty$)
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
  , $\kappa$
  , [thermal diffusivity]
==
  , $Q'$
  , energy per area divided by $\rho c$
''''


\END

----
\home
----

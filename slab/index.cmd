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
and thereafter loses heat to the environment at temperature $\TE$
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

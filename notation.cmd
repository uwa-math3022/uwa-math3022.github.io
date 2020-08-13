{+ resources/syntax.cmd +}

%%
  %title  Notation
  %date-modified  2020-08-13
  \resources:maths
%%

# %title #

----
\home
----

##{#derivatives} Derivatives ##

<##
  Styles
  * unscaled (dimensional): colour-g
  * scaled (dimensionless): colour-v
##>
$
  \gdef \unscaled #1 {\colg{#1}}
  \gdef \scaled #1 {\colv{#1'}}
  \gdef \scale #1 {\colb{#1}}
$
{% \[ unscaled / (.*?) / \] % [g/ \1 /] %}
{% \[ scaled / (.*?) / \] % [v/ \1 /] %}
{% \[ scale / (.*?) / \] % [b/ \1 /] %}

----
There are two ways to write derivatives: __subscripts__ and __fractions__.
Nev prefers subscripts while I prefer fractions.
----
----
E.g.~for $T (x, t)$:
----

''''
|^
==
  ; Subscripts
  ; Fractions
|:
==
  , $T_x$
  , $\dfrac{\pd T}{\pd x}$
==
  , $T_x (0, t)$
  , $\eval{\dfrac{\pd T}{\pd x}}_{x = 0}$
==
  , $T_x (x, 0)$
  , $\eval{\dfrac{\pd T}{\pd x}}_{t = 0}$
==
  , $T_{xx}$
  , $\dfrac{\pd^2 T}{{\pd x}^2}$
''''

----
**Both are fine; just pick one and be consistent**.
----

----
The reason I prefer fractions is because they explicitly show
the dimensions of a derivative.
It is very easy to do scaling with derivatives in fractional form.
----
----
For example, consider moving the term
----
$$
  \frac{\pd^2 \unscaled{T}}{{\pd \unscaled{x}}^2}
$$
----
from [unscaled/ unscaled variables /]  to [scaled/ scaled variables /]
according to
----
$$
\begin{aligned}
  \unscaled{T} &= T_0 + \scale{\Theta} \scaled{T}, \\
  \unscaled{x} &= \scale{L} \scaled{x}.
\end{aligned}
$$
----
Just by *looking* at the term,
we see that it is temperature divided by length squared.
**Immediately we can write down**
----
$$
  \frac{\pd^2 \unscaled{T}}{{\pd \unscaled{x}}^2} =
    \frac{\scale{\Theta} \pd^2 \scaled{T}}{\scale{L}^2 \,{\pd \scaled{x}}^2}
$$
----
because the temperature scale is $\scale{\Theta}$
and the length scale is $\scale{L}$.
**That's it.**
(We can ignore $T_0$ because it is an *offset*,
which doesn't affect the derivative
--- the derivative of an added constant is zero.)
----

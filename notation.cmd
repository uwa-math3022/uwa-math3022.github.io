{+ resources/syntax.cmd +}

%%
  %title  Remarks on notation
  %date-modified  2020-08-14
  \resources:maths
%%

# %title #

\noscript

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
You may have noticed two ways to write derivatives:
__subscripts__ and __fractions__.
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

##{#functions} Functions ##

----
You may also have noticed that I regularly omit the variables
which a function depends on,
and that I prefer to use vertical-bar notation
to denote evaluation of a function at a particular point.
----
----
I will also write things like $T = T (x, t)$,
which to a pure mathematician is an abuse of notation.
----
----
The reason is that **in physics \& applied maths,
functions are viewed as *expressions* rather than as *maps***.
----

----
This is best demonstrated by [Corinne's Shibboleth][sh]
(slightly paraphrased here):
----
""""
Suppose the temperature on a rectangular slab of metal
is given by $T (x, y) = k (x^2 + y^2)$ where $k$ is a constant.
What is $T (r, \theta)$?
====
* Pure mathematician: $T (r, \theta) = k (r^2 + \theta^2)$
* Applied mathematician: $T (r, \theta) = k r^2$
====
""""
----
In MATH3022 (and in physics \& applied maths more generally),
we choose the applied mathematician's answer.
When we write $T = T (x, y)$,
we are simply asserting that the temperature $T$
is to be expressed in terms of the coordinates $x$ and $y$.
In particular:
----
====
* $T$ is the *physical* temperature, NOT a map.
* $x$ and $y$ are *physical* coordinates, NOT replaceable dummy variables.
====
----
When we write $T (r, \theta)$,
the $T$ is the *same physical temperature profile*
as when we write $T (x, y)$.
The only difference is the coordinate system used to express it.
----
----
For a rough analogy,
1000~metres and 1~kilometre are the *same physical length*
--- they are *equal*
--- even though they have been expressed in terms of different units.
----

@[sh] https://sites.science.oregonstate.edu/math/bridge/ideas/functions/ @

\END

----
\home
----

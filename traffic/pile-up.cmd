{+ resources/syntax.cmd +}

%%
  %title  Traffic pile up
  %date-modified  2020-10-16
  \resources:maths
%%


# %title #

\noscript

----
[Return to traffic model summary](/traffic/)
----

##{#initial-conditions} Initial conditions ##
$
  \gdef \Vmax {V_\mathrm{max}}
  \gdef \Nmax {N_\mathrm{max}}
  \gdef \Fmax {F_\mathrm{max}}
  \gdef \Vsh  {V_\mathrm{shock}}
  \gdef \Vb   {V_\mathrm{before}}
  \gdef \Va   {V_\mathrm{after}}
  \gdef \Nb   {N_\mathrm{before}}
  \gdef \Na   {N_\mathrm{after}}
  \gdef \Fb   {F_\mathrm{before}}
  \gdef \Fa   {F_\mathrm{after}}
$

----
Cars travelling at 60% maximum density (40% of the speed limit)
are faced with a denser \& slower region ahead,
at 80% maximum density (20% of the speed limit).
In symbols,
----
$$
  \eval{N}_{t = 0} =
    \begin{cases}
      0.6 \Nmax, & x < 0 \\
      0.8 \Nmax, & x > 0
    \end{cases}.
$$
----
What happens?
----

##{#animation} Animation ##

{% \[ charac / (.*?) / \] % [v/ \1 /] %}
{% \[ shock  / (.*?) / \] % [r/ \1 /] %}

----
![Animation for pile up][animation]
----
@[animation]{w240} pile-up.gif @

====
* [charac/ Characteristics in purple /]
* [shock/ Shockwave in red /]
* Trajectories in yellow
====


##{#characteristics} Characteristics ##

----
We have the following:
----
''''
|^
==
  ; Qty
  ; Before
  ; After
|:
==
  , $N$
  , $0.6 \Nmax$
  , $0.8 \Nmax$
==
  , $V$
  , $0.4 \Vmax$
  , $0.2 \Vmax$
==
  , $F$
  , $0.24 \Nmax\Vmax$
  , $0.16 \Nmax\Vmax$
==
  , $\frac{\td F}{\td N}$
  , $-0.2 \Vmax$
  , $-0.6 \Vmax$
''''

----
Thus we have characteristics...
----
====
* ... with slope $-0.2 \Vmax$ from the left half of the $x$-axis
  (the 'before' portion)
* ... with slope $-0.6 \Vmax$ from the right half of the $x$-axis
  (the 'after' portion).
====

----
We have a problem:
the 'after' characteristics (slow \& dense) have a higher signal speed
than the 'before' characteristics (fast \& sparse),
so eventually they will collide.
How does that work?
----


##{#shockwave} Shockwave ##
$
  \gdef \shock #1 {\colr{#1}}
$

----
Unlike the [traffic light example](light-change)
where we had a transition fan (moving from slow \& dense to fast \& sparse),
here we have a __shockwave__ at the interface
where fast \& sparse abruptly becomes slow \& dense.
----
----
Suppose the [shock/ shockwave interface /] travels at velocity $\Vsh$.
The relative velocity of cars is $\Vb - \Vsh$ on the 'before' side
and $\Va - \Vsh$ on the 'after' side.
Since flux (density times velocity) must be conserved,
we have
----
$$
  \Nb (\Vb - \Vsh) = \Na (\Va - \Vsh)
$$
----
and therefore the [shock/ shockwave speed /] is
----
$${.important}
\begin{aligned}
  \shock{\Vsh}
  &= \frac{\Na \Va - \Nb \Vb}{\Na - \Nb} \\[\tallspace]
  &= \frac{\Fa - \Fb}{\Na - \Nb}
\end{aligned}
$$
----
Note that this is the slope of the secant line
through the points $(\Nb, \Fb)$ and $(\Na, \Fa)$
on the [flux--density parabola](/traffic/#flux).
----
----
For the current problem we get $\shock{\Vsh = -0.4 \Vmax}$,
and so the shockwave interface is the line $x = \shock{-0.4 \Vmax} t$,
separating the fast \& sparse 'before' region
and the slow \& dense 'after' region.
Therefore:
----

##{#result} Result ##

$${.important}
  N (x, t) =
    \begin{cases}
      0.6 \Nmax, & x < -0.4 \Vmax t \\
      0.8 \Nmax, & x > -0.4 \Vmax t
    \end{cases}.
$$


##{#remarks} Remarks ##

----
![Animation for pile up (again)][animation]
----
====
* [charac/ Characteristics in purple /]
* [shock/ Shockwave in red /]
* Trajectories in yellow
====

----
In real life we obviously don't brake instantly,
but abrupt reductions in speed *do* propagate backward in a shockwave,
e.g.~when an idiot doesn't get up to speed before doing a merge.
----


\END

----
[Return to traffic model summary](/traffic/)
----

----
\home
----

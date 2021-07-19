{+ /resources/syntax.cmd +}

%%
  %title  Single-lane traffic model
  %date-modified  2020-10-17
  \resources:maths
%%


# %title #

\noscript

----
Source code for images: [code.wl] \+
\home
----
@[code.wl]
  https://github.com/uwa-math3022/uwa-math3022.github.io/blob/master/\
    traffic/code.wl @

----
This page summarises the simple continuum model for single-lane traffic.
For some cool animations, see the following:
----
====
* [Light change example](light-change)
* [Pile up example](pile-up)
====


##{#curves} Curves for the simple model ##

<##
  Styles
  * sparse: colour-b
  * dense: colour-r
##>
{% \[ sparse / (.*?) / \] % [b/ \1 /] %}
{% \[ dense  / (.*?) / \] % [r/ \1 /] %}
$
  \gdef \Vmax {V_\mathrm{max}}
  \gdef \Nmax {N_\mathrm{max}}
  \gdef \Fmax {F_\mathrm{max}}
$

###{#speed} Speed vs density ###

----
With the exception of tailgaters,
drivers tend to go slower when the traffic is denser.
The simplest model is a linear relationship
between the __density__ $N$ (amount of vehicle per length of road)
and the __preferred speed__ $V$:
----
$${.important}
  V = \Vmax \roundbr{1 - \frac{N}{\Nmax}}
$$

----
![Preferred speed vs density curve](preferred-speed.png)
----

====
* When there is no traffic ([sparse/ $N = 0$ /]),
  drivers will go at the speed limit ([sparse/ $V = \Vmax$ /]).
* When there is bumper-to-bumper traffic ([dense/ $N = \Nmax$ /]),
  drivers will halt ([dense/ $V = 0$ /]).
====

----
We also assume that drivers are able to adjust their speed *instantly*
when the density changes.
This might not seem realistic,
but remember we are constructing a *model*.
(Also note that in real life,
most drivers are happy to do the speed limit
even when the density *isn't* zero,
by keeping at a 2-second separation to the vehicle ahead.)
----

###{#flux} Flux vs density ###

----
Traffic engineers generally want to maximise the __flux__ of traffic,
which is the product of density and speed:
----
$${.important}
\begin{aligned}
  F &= N V \\
    &= N \Vmax \roundbr{1 - \frac{N}{\Nmax}}
\end{aligned}
$$

----
![Carried flux vs density curve](carried-flux.png)
----

----
In our current model this is a parabolic relationship:
----
====
* Maximum flux $\Fmax = \Nmax \Vmax / 4$ is obtained
  with traffic at *half* the maximum density going at *half* the speed limit.
* The flux is *zero* in both the empty-street case $N = 0$, $V = \Vmax$
  (because there are no cars)
  and in the bumper-to-bumper case $N = \Nmax$, $V = 0$
  (because the cars aren't moving).
====
----
Note that there are two ways to achieve a given flux $F < \Fmax$:
[sparse/ fast \& sparse /], and [dense/ slow \& dense /]
(with the former being preferable to drivers).
----


##{#equation} Traffic equation ##

###{#quantities} Quantities ###

''''
|^
==
  ;{c2} Independent variables
|:
==
  , $x$
  , position
==
  , $t$
  , time
==
  ;{c2} Dependent variable
==
  , $N$
  , density
''''

###{#conservation} Conservation ###

----
After doing the usual conservation analysis (here, "conservation of vehicle"),
we obtain the continuity equation
----
$$
  \frac{\pd N}{\pd t} + \frac{\pd F}{\pd x} = 0,
$$
----
and since we have a direct relationship $F = F (N)$ between flux and density,
this becomes the __traffic equation__
----
$${.important}
  \frac{\pd N}{\pd t} + \frac{\td F}{\td N} \frac{\pd N}{\pd x} = 0.
$$

###{#signal-speed} Signal speed ###

----
The quantity $\td F / {\td N}$ has dimensions of speed, and varies linearly
from $+\Vmax$ at zero density to $-\Vmax$ at maximum density:
----
$${.important}
  \frac{\td F}{\td N} = \Vmax \roundbr{1 - \frac{2N}{\Nmax}}
$$

----
![Signal speed vs density curve](signal-speed.png)
----

----
It turns out that $\td F / {\td N}$ is the __signal speed__
for the local density:
----


##{#characteristics} Method of characteristics ##

<##
  Styles
  * characteristic: colour-v
##>
$
  \gdef \charac #1 {\colv{#1}}
$
{% \[ charac / (.*?) / \] % [v/ \1 /] %}
$
  \gdef \xc {x_\mathrm{c}}
$

----
Unlike the heat equation, the traffic equation is a __hyperbolic PDE__.
Instead of separation of variables, we use the __method of characteristics__.
----

----
We seek [charac/ __characteristic curves__ $x = \xc (t)$ /]
along which the density $N (x, t)$ is constant, i.e.
----
$$
  N (\charac{\xc (t)}, t) = \const.
$$
----
By definition $\td N = 0$ along a characteristic,
and using the chain rule we have
----
$$
  \frac{\pd N}{\pd t} + \charac{\frac{\td \xc}{\td t}} \frac{\pd N}{\pd x} = 0.
$$
----
Comparing this with the traffic equation
----
$$
  \frac{\pd N}{\pd t} + \charac{\frac{\td F}{\td N}} \frac{\pd N}{\pd x} = 0,
$$
----
we see that the characterstics are given by
----
$${.important}
  \charac{\frac{\td \xc}{\td t} = \frac{\td F}{\td N}}.
$$
----
Thus the characteristics are straight lines in spacetime
with slope equal to the __signal speed__ $\td F / {\td N}$.
----
----
Note that **characteristics are NOT the trajectories of the cars**;
they are curves along which density is constant.
----

###{#steps} Steps ###

----
Given a traffic problem:
----
++++++++
1. Draw a spacetime diagram with position $x$ on the horizontal axis
   and time $t$ on the vertical axis.
2. Mark the locations in spacetime
   where the density $N$ is given by the boundary and initial conditions.
3. For a bunch of these locations:
   ++++
   1. Work out the signal speed $\td F / {\td N}$ for the given value of $N$.
   2. Draw the associated characteristic curve through this location
      (the straight line with slope $\td F / {\td N}$).
   ++++
++++++++
----
Since characteristics are curves with constant density $N$,
this procedure "extends" the boundary/initial values of $N$
to all of spacetime.
In other words, we've solved for $N (x, t)$. That's all there is to do.
----

----
If we wanted to find the actual trajectories $x = x (t)$ of the cars,
we would:
----
++++++++
1. Determine $V (x, t)$ from $N (x, t)$
   using the [speed vs density relationship](#speed).
2. Solve the ODE $\td x / {\td t} = V (x, t)$.
   We could also proceed graphically;
   simply sketch the trajectories so that the slope (which is the speed)
   matches $V (x, t)$.
++++++++

----
Finally, since time is on the vertical axis,
remember that "fast" trajectories are near-horizontal
while "slow" trajectories are near-vertical.
----

----
Examples:
----
====
* [Light change example](light-change)
* [Pile up example](pile-up)
====


\END


----
\home
----

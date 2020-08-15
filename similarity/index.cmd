{+ resources/syntax.cmd +}

%%
  %title  Fundamental plane-source similarity solution
  %date-modified  2020-08-xx
  \resources:maths
  %css a~~
    .img-container {
      text-align: center;
    }
  ~~
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
Consider an infinite, uniform block of
[density] $\rho$, [specific heat capacity] $c$,
and [thermal conductivity] $k$.
Its [thermal diffusivity] is therefore $\kappa = k / (\rho c)$.
----
----
Suppose the block is initially at zero temperature throughout.
At time $t = 0$:
----
====
* Inject thermal energy per area, $Q$, into the plane $x = 0$.
====
----
What happens?
----

@[density] https://en.wikipedia.org/wiki/Density @
@[specific heat capacity]
  https://en.wikipedia.org/wiki/Specific_heat_capacity @
@[thermal conductivity] https://en.wikipedia.org/wiki/Thermal_conductivity @
@[thermal diffusivity] https://en.wikipedia.org/wiki/Thermal_diffusivity @

----
![Diagram for fundamental plane-source problem](diagram.png)
----

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


##{#defining-equations} Defining equations ##

###{#pde} Partial differential equation (PDE) ###

----
__Heat equation__ in $T = T (x, t)$, throughout the block, for all time:
----

$${.important}
  \frac{\pd T}{\pd t} = \kappa \frac{\pd^2 T}{{\pd x}^2}
$$

###{#boundary-condition} Boundary condition (BC) ###

----
Nothing happens at (spatial) infinity, for all time:
----

$${.important}
  \eval{T}_{x = \pm\infty} = 0
$$

----
If you prefer limits:
----
$$
  \lim_{x \to \pm\infty} T (x, t) = 0
$$

###{#initial-condition} Initial condition (IC) ###

$\gdef \dimen #1 {\textsf{#1}}$

----
All of the thermal energy is concentrated in the slice $x = 0$, initially:
----

$${.important}
  \eval{T}_{t = 0} =
    \begin{cases}
      \infty, & x = 0 \\
      0, & x \ne 0
    \end{cases}
$$

||||{.qa}
__Q.__
  What nonsense is this?
\+
__A.__
  The formal way to write this initial condition is
  $$
    \eval{T}_{t = 0} = Q' \cdot \delta (x).
  $$
  The $Q'$ factor arises from the
  [conservation of energy condition](#conservation).
  ----
  Here $\delta (x)$ is the __unit impulse__
  or [__Dirac delta function__][delta].
  (Mathematicians prefer to call it a "generalised function"
  or a "distribution".)
  Basically $\delta (x)$ zero everywhere except at $x = 0$,
  where it is infinity, in such a way that the area under the curve is $1$:
  ----
  $$
  \begin{aligned}
    \delta (x) =
      \begin{cases}
        \infty, & x = 0 \\
        0, & x \ne 0
      \end{cases}
      \\
    \int_{-\infty}^\infty \delta (x) \td x = 1
  \end{aligned}
  $$
  The easiest way to think of $\delta (x)$ is as a normal distribution
  with a standard deviation of zero,
  or an infinitely tall and thin spike with area $1$.
  Note that $\delta (x)$ has dimensions of $1 / \dimen{Length}$.
||||

@[delta] https://en.wikipedia.org/wiki/Dirac_delta_function @


###{#conservation} Conservation of energy ###

----
Energy is conserved, for all time:
----

$${.important}
  \int_{-\infty}^\infty T \td x = Q'
$$

||||||{.qa}
__Q.__
  Why is the right hand side $Q'$?
\+
__A.__
  The initial injection has energy per area $Q$ in the plane $x = 0$.
  Subsequently the energy will spread out in the $x$-direction,
  but since energy is conserved,
  if we take an infinite cylinder (aligned with the $x$-axis)
  with cross-sectional area $A$,
  the total energy within it will be $Q \cdot A$.
  ----
  Now recall that $\textq{Energy} = m c \textq{Temperature}$.
  Therefore the energy in the cylinder is
  ----
  $$
    Q \cdot A = \int c T \td m.
  $$
  ||||{.img-container}
    ![Slice of the cylinder of thickness dx](slice.png)
  ||||
  Taking each mass element to be a slice of thickness $\td x$,
  each differential mass is $\td m = \rho A \td x$.
  Therefore
  $$
    Q \cdot A = \int_{-\infty}^\infty c T \rho A \td x,
  $$
  or
  $$
    \int_{-\infty}^\infty T \td x = \frac{Q}{\rho c} = Q'.
  $$
||||||


\END

----
\home
----

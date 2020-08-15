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
Source code for the (non-hand-drawn) images: [code.wl] \+
\home
----
@[code.wl]
  https://github.com/uwa-math3022/uwa-math3022.github.io/blob/master/\
    plane/code.wl @

##{#problem} Problem ##

----
Consider an infinite, uniform block of [thermal conductivity] $k$,
[density] $\rho$, and [specific heat capacity] $c$.
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
  Here, the initial temperature of the plane $x = 0$ will be infinite,
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
in terms of the constants $\kappa$ and $Q'$ only
(rather than $k$, $\rho$, $c$, and $Q$).
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
  , initial energy per area divided by $\rho c$
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
  Basically $\delta (x)$ is zero everywhere except at $x = 0$,
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
  or as an infinitely tall and thin spike with area $1$.
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
  In other words if we take a portion of that plane with area $A$,
  the total energy within that portion will be $Q \cdot A$.
  ----
  Subsequently the energy will spread out in the $x$-direction,
  but since energy is conserved,
  if we take an infinite cylinder (aligned with the $x$-axis)
  with cross-sectional area $A$,
  the total energy within that cylinder will still be $Q \cdot A$.
  ----
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


###{#defining-equations-summary} Summary ###

----
That was a lot to process,
so here are the defining equations again without the commentary:
----
$${.important}
\begin{aligned}
  \frac{\pd T}{\pd t} &= \kappa \frac{\pd^2 T}{{\pd x}^2}
    \\[\tallspace]
    \eval{T}_{x = \pm\infty} &= 0
      \\
    \eval{T}_{t = 0} &=
      \begin{cases}
        \infty, & x = 0 \\
        0, & x \ne 0
      \end{cases}
    \\
  \int_{-\infty}^\infty T \td x &= Q'
\end{aligned}
$$


##{#scaling} Scaling ##

----
Normally there will be a length scale provided by the parameters.
But in the current situation the only parameters are $\kappa$ and $Q'$,
and:
----
====
* The slab is of *infinite* extent
* The initially heated slice ($x = 0$) has *zero* thickness
====
----
Both infinity and zero are **scale-invariant**.
THERE IS NO LENGTH SCALE.
----

||||{.qa}
__Q.__
  So how do we scale $x$?
\+
__A.__
  Somehow a combination of the other quantities $t$, $\kappa$, and $Q'$
  must form a length scale to compare against $x$.
||||

###{#dimensional-analysis} Dimensional analysis ###

<##
  Styles
  * temperature: colour-g
  * dimensionless: colour-v
##>
$
  \gdef \temp #1 {\colg{#1}}
  \gdef \dimenless #1 {\colv{#1}}
$
{% \[ temp / (.*?) / \] % [g/ \1 /] %}
{% \[ dimenless / (.*?) / \] % [v/ \1 /] %}

----
The temperature $T$ can only depend on
the independent variables $x$ and $t$
and the constants $\kappa$ and $Q'$,
because there are no other variables or physical constants
in the defining equations:
----
$${.important}
  T = T (x, t; \kappa, Q')
$$

----
The only way this can make dimensional sense is if
----
$$
  T = \temp{\mathcal{T}} \cdot \dimenless{\mathcal{L}},
$$
----
where $\temp{\mathcal{T}}$ is a combination
of $x$, $t$, $\kappa$, and $Q'$ which has dimensions of [temp/ temperature /],
and $\dimenless{\mathcal{L}}$ is a combination
of $x$, $t$, $\kappa$, and $Q'$ which is [dimenless/ dimensionless /].
----

----
Obviously
----
$$
\begin{aligned}
  [T] &= \dimen{Temp} \\
  [x] &= \dimen{Length} \\
  [t] &= \dimen{Time}.
\end{aligned}
$$

----
From the [PDE](#pde), we have
----
$$
  [\kappa] = \frac{\dimen{Length}^2}{\dimen{Time}},
$$
----
and from the [conservation of energy](#conservation) condition,
we see that
----
$$
  [Q'] = \dimen{Temp} \cdot \dimen{Length}.
$$

----
You should be able to show that
----
$$
\begin{aligned}
  \squarebr{\temp{\frac{Q'}{\sqrt{\kappa t}}}} &= \temp{\dimen{Temp}} \\
  \squarebr{\dimenless{\frac{x}{\sqrt{\kappa t}}}} &= \dimenless{\dimen{1}},
\end{aligned}
$$
----
and so $T$ must be of the form
----
$${.important}
  T =
    \temp{\frac{Q'}{\sqrt{\kappa t}}}
      \cdot
    U \roundbr{\dimenless{\frac{x}{\sqrt{\kappa t}}}},
$$
----
where $U$ is some dimensionless function.
We give the dimensionless group a name:
----
$${.important}
  \dimenless{\xi} = \dimenless{\frac{x}{\sqrt{\kappa t}}}
$$

||||{.qa}
__Q.__
  Is there a systematic way of doing this?
\+
__A.__
  Yes, read up on the [Buckingham pi theorem]. \+
  In the present scenario, suppose that
  $$
    \gdef \ind #1 {\colr{#1}}
    [T] = [x]^\ind{p} [t]^\ind{q} [\kappa]^\ind{r} [Q']^\ind{s}
  $$
  for some indices $\ind{p}$, $\ind{q}$, $\ind{r}$, and $\ind{s}$.
  Then
  $$
    \dimen{Temp} =
      \dimen{Length} ^ \ind{p}
        \cdot
      \dimen{Time} ^ \ind{q}
      \roundbr{\frac{\dimen{Length}^2}{\dimen{Time}}} ^ \ind{r}
      \roundbr{\dimen{Temp} \cdot \dimen{Length}} ^ \ind{s}.
  $$
  Equating powers of $\dimen{Length}$, $\dimen{Time}$, and $\dimen{Temp}$,
  we get the system of linear equations
  $$
  \begin{aligned}
    \ind{p} + 2 \ind{r} + \ind{s} &= 0 \\
    \ind{q} - \ind{r} &= 0 \\
    \ind{s} &= 1,
  \end{aligned}
  $$
  which solves to give
  $$
    \begin{pmatrix} \ind{p} \\ \ind{q} \\ \ind{r} \\ \ind{s} \end{pmatrix}
      =
    \underbrace{
      \begin{pmatrix} 0 \\ -1/2 \\ -1/2 \\ 1 \end{pmatrix}
    }_{
      \normalsize \temp{Q' / \sqrt{\kappa t}}
    }
      + a
    \underbrace{
      \begin{pmatrix} 1 \\ -1/2 \\ -1/2 \\ 0 \end{pmatrix}
    }_{
      \normalsize \dimenless{x / \sqrt{\kappa t}}
    },
  $$
  where $a$ is a free variable.
  Thus we obtain the temperature combination $\temp{Q' / \sqrt{\kappa t}}$
  and the dimensionless group $\dimenless{x / \sqrt{\kappa t}}$.
||||

@[Buckingham pi theorem]
  https://en.wikipedia.org/wiki/Buckingham_%CF%80_theorem @


\END

----
\home
----

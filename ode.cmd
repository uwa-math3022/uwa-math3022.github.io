< /resources/syntax.cmdr

OrdinaryDictionaryReplacement: #.boilerplate-properties-override
- queue_position: BEFORE #boilerplate-properties
* %title --> ODEs you must be able to solve
* %date-modified --> 2020-08-20
* %head-elements-after-viewport --> \resources:maths

%%%


# %title

\noscript

----
\home
----

----
You *must* be able to solve the following ODEs.
You **should** be able to **immediately write down** the general solution
in each case:
----


##{#decay} First order: exponential decay

### ODE

$${.important}
  \frac{\td Y}{\td t} = -\mu Y
$$

### Solution

$$
  Y (t) = A \ee ^ {-\mu t}
$$


##{#trigonometric} Second order: trigonometric

### ODE

$${.important}
  \frac{\td^2 Y}{{\td x}^2} = -\lambda^2 Y
$$

### Solution

$$
  Y (x) = A \cos (\lambda x) + B \sin (\lambda x)
$$

----
Note that $\cos$ is an even function and $\sin$ is an odd function:
----
====
* If $Y$ is zero at $x = 0$, you only want $\sin$
* If $Y$ has zero slope at $x = 0$, you only want $\cos$.
====


##{#hyperbolic} Second order: hyperbolic (or exponential)

### ODE

$${.important}
  \frac{\td^2 Y}{{\td x}^2} = +\lambda^2 Y
$$

### Solution

$$
  Y (x) = A \cosh (\lambda x) + B \sinh (\lambda x)
$$
----
OR
----
$$
  Y (x) = C \ee^ {\lambda x} + D \ee ^ {-\lambda x}
$$

----
When solving boundary value problems,
the first form with the [hyperbolic functions] $\cosh$ and $\sinh$
is much nicer to work with
because $\cosh$ is an even function and $\sinh$ is an odd function:
----
====
* If $Y$ is zero at $x = 0$, you only want $\sinh$
* If $Y$ has zero slope at $x = 0$, you only want $\cosh$.
====

[hyperbolic functions]: https://en.wikipedia.org/wiki/Hyperbolic_functions


\END

----
\home
----

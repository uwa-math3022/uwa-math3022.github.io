{+ resources/syntax.cmd +}

%%
  %title  Traffic light change
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
$

----
Cars lined bumper-to-bumper wait at a red traffic light
which turns green at $t = 0$.
In symbols,
----
$$
  \eval{N}_{t = 0} =
    \begin{cases}
      \Nmax, & x < 0 \\
      0, & x > 0
    \end{cases}.
$$
----
What happens?
----

##{#animation} Animation ##

{% \[ charac / (.*?) / \] % [v/ \1 /] %}
{% \[ sparse / (.*?) / \] % [b/ \1 /] %}
{% \[ dense  / (.*?) / \] % [r/ \1 /] %}

----
![Traffic light change animation][animation]
----
@[animation]{w240} light-change.gif @

====
* [charac/ Characteristics in purple /]
* [dense/ Dense/slow regions in red /]
* [sparse/ Sparse/fast regions in blue /]
* Trajectories in yellow
====


##{#characteristics} Characteristics ##

###{#dense-region} Dense region ###

----
First consider $t = 0$, $x < 0$,
i.e.~the left half of the $x$-axis,
where the cars are waiting at full density.
Here we have
----
$$
\begin{aligned}
  N &= \Nmax \\
  V &= 0 \\
  \frac{\td F}{\td N} &= -\Vmax.
\end{aligned}
$$
----
Thus the characteristics are straight lines with slope $-\Vmax$,
and so the left half of the $x$-axis extends into a
[dense/ triangular region with full density $N = \Nmax$ /].
----

###{#empty-region} Empty region ###

----
Next consider $t = 0$, $x > 0$,
i.e.~the right half of the $x$-axis,
which is initially empty.
Here we have
----
$$
\begin{aligned}
  N &= 0 \\
  V &= \Vmax \\
  \frac{\td F}{\td N} &= +\Vmax.
\end{aligned}
$$
----
Thus the characteristics are straight lines with slope $+\Vmax$,
and so the right half of the $x$-axis extends into a
[sparse/ triangular region with zero density /].
----


\END

----
\home
----

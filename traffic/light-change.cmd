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
Cars queued bumper-to-bumper wait at a red traffic light
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
![Animation for traffic light change][animation]
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
where the cars are initially waiting at [dense/ full density /].
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
Thus the [charac/ characteristics /] are straight lines with slope $-\Vmax$,
and so the left half of the $x$-axis extends into a
[dense/ lower-left triangular region~◣/]
with full density and zero speed.
----

###{#empty-region} Empty region ###

----
Next consider $t = 0$, $x > 0$,
i.e.~the right half of the $x$-axis,
which is initially [sparse/ empty /].
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
Thus the [charac/ characteristics /] are straight lines with slope $+\Vmax$,
and so the right half of the $x$-axis extends into a
[sparse/ lower-right triangular region~◢ with zero density /].
----

###{#transition-fan} Transition fan ###
$
  \gdef \charac #1 {\colv{#1}}
  \gdef \xc {x_\mathrm{c}}
$

----
What about the remaining triangular region~▼ in the middle?
----
----
Well, we haven't yet looked at the origin $t = 0$, $x = 0$.
There we have an instantaneous jump from [dense/ maximum density /]
to [sparse/ zero density /], so we have
----
$$
\begin{alignedat}{1}
  \Nmax &\ge N \ge 0 \\
  0 &\le V \le \Vmax \\
  -\Vmax &\le \frac{\td F}{\td N} \le +\Vmax.
\end{alignedat}
$$
----
Thus we get a fan of [charac/ characteristics /] emanating from the origin,
with slopes running from $-\Vmax$ up to $+\Vmax$.
In particular, the characteristic for a given density $N$ is given by
----
$$
  \charac{
    \xc (t)
    = \frac{\td F}{\td N} \cdot t
    = \Vmax \roundbr{1 - \frac{2 N}{\Nmax}} t
  }.
$$
----
Therefore we have
----
$$
  N (x, t) = \frac{\Nmax}{2} \roundbr{1 - \frac{x}{\Vmax t}}
$$
----
in the central triangular region~▼.
----


##{#remarks} Remarks ##

----
![Animation for traffic light change (again)][animation]
----
====
* [charac/ Characteristics in purple /]
* [dense/ Dense/slow regions in red /]
* [sparse/ Sparse/fast regions in blue /]
* Trajectories in yellow
====

----
The main results are:
----
====
* **The 'signal to go' propagates backwards at the speed limit**,
  along the [charac/ characteristic $\xc (t) = -\Vmax t$ /].
  ----
  Does this happen in real life? \+
  Yes, the further back you are in the queue,
  the longer you need to wait before you can go.
  ----
* **All cars pass the stop line at half the speed limit**,
  corresponding to the [charac/ characteristic $\xc (t) = 0$ /]
  for $N = \Nmax / 2$, $V = \Vmax / 2$.
  ----
  Does this happen in real life? \+
  Well, roughly. In the model, the first car is able to accelerate instantly
  from zero to the speed limit;
  this isn't possible in real life.
  If you're not first-in-line though, the model is pretty fair;
  in my experience I am usually in second or third gear
  by the time I pass the stop line for a traffic light in a 60kph zone.
  ----
====


\END

----
\home
----

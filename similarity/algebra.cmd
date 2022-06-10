< /resources/syntax.cmdr

OrdinaryDictionaryReplacement: #.boilerplate-properties-override
- queue_position: BEFORE #boilerplate-properties
* %title --> Algebra for %similarity-title
* %date-modified --> 2020-08-16
* %head-elements-after-viewport --> \resources:maths

OrdinaryDictionaryReplacement: #.similarity-title
- queue_position: BEFORE #boilerplate-properties
* %similarity-title --> '"Fundamental plane-source similarity solution"'

RegexDictionaryReplacement: #.coloured-text
- queue_position: BEFORE #.syntax.coloured-spans
* \[ old / (.*?) / \] --> [b/ \1 /]
* \[ new / (.*?) / \] --> [r/ \1 /]

%%%


# %title

\noscript

----
[Return to %similarity-title](/similarity/)
----

<##
  Styles
  * old coordinates: colour-b
  * new coordinates: colour-r
##>
$
  \gdef \old #1 {\colb{#1}}
  \gdef \new #1 {\colr{#1}}
$


##{#chain-rule} Chain rule

----
The coordinate transformation is given by
----
$$
\begin{aligned}
  \new{\xi} &= \frac{\old{x}}{\sqrt{\kappa \old{t}}} \\
  \new{t} &= \old{t}.
\end{aligned}
$$

----
By the chain rule, we have
----
$$
\begin{aligned}
  \old{\frac{\pd}{\pd x}}
    &=
      \old{\frac{\pd \xi}{\pd x}}
      \new{\frac{\pd}{\pd \xi}}
        +
      \old{\frac{\pd t}{\pd x}}
      \new{\roundbr{\frac{\pd}{\pd t}}_\xi}
      \\[\tallspace]
    &=
      \roundbr{
        \old{\frac{\pd}{\pd x}}
        \squarebr{
          \frac{\old{x}}{\sqrt{\kappa \old{t}}}
        }
      }
        \cdot
      \new{\frac{\pd}{\pd \xi}}
        +
      \old{0}
        \cdot
      \new{\roundbr{\frac{\pd}{\pd t}}_\xi}
      \\[\tallspace]
    &=
      \frac{1}{\sqrt{\kappa \old{t}}}
      \new{\frac{\pd}{\pd \xi}}
      \\[\tallspace]
    &=
      \frac{1}{\sqrt{\kappa \new{t}}}
      \new{\frac{\pd}{\pd \xi}}
\end{aligned}
$$
----
and
----
$$
\begin{aligned}
  \old{\roundbr{\frac{\pd}{\pd t}}_x}
    &=
      \old{\roundbr{\frac{\pd \xi}{\pd t}}_x}
        \cdot
      \new{\frac{\pd}{\pd \xi}}
        +
      \old{\roundbr{\frac{\pd t}{\pd t}}_x}
        \cdot
      \new{\roundbr{\frac{\pd}{\pd t}}_\xi}
      \\[\tallspace]
    &=
      \roundbr{
        \old{\frac{\pd}{\pd t}}
        \squarebr{
          \frac{\old{x}}{\sqrt{\kappa \old{t}}}
        }
      }_{\old{x}}
        \cdot
      \new{\frac{\pd}{\pd \xi}}
        +
      \old{1}
        \cdot
      \new{\roundbr{\frac{\pd}{\pd t}}_\xi}
      \\[\tallspace]
    &=
      \frac{\old{x}}{\sqrt{\kappa}}
        \cdot
      \frac{-1/2}{\old{t}^{3/2}}
        \cdot
      \new{\frac{\pd}{\pd \xi}}
        +
      \new{\roundbr{\frac{\pd}{\pd t}}_\xi}
      \\[\tallspace]
    &=
      -\frac{\old{x}}{\sqrt{\kappa \old{t}}}
        \cdot
      \frac{1}{2 \old{t}}
        \cdot
      \new{\frac{\pd}{\pd \xi}}
        +
      \new{\roundbr{\frac{\pd}{\pd t}}_\xi}
      \\[\tallspace]
    &=
      -\new{\xi}
        \cdot
      \frac{1}{2 \new{t}}
        \cdot
      \new{\frac{\pd}{\pd \xi}}
        +
      \new{\roundbr{\frac{\pd}{\pd t}}_\xi}.
\end{aligned}
$$
----
Therefore
----
$${.important}
\begin{aligned}
  \old{\frac{\pd}{\pd x}} &=
    \frac{1}{\sqrt{\kappa \new{t}}}
    \new{\frac{\pd}{\pd\xi}}
    \\[\tallspace]
  \old{\roundbr{\frac{\pd}{\pd t}}_x} &=
    -\frac{\new{\xi}}{2 \new{t}} \new{\frac{\pd}{\pd\xi}}
    + \new{\roundbr{\frac{\pd}{\pd t}}_\xi}.
\end{aligned}
$$

----
[Return to the corresponding line in %similarity-title.]\
  (/similarity/#algebra-chain-rule)
----


##{#derivatives} Derivatives of temperature

----
We have
----
$$
  T (\old{x}, \old{t}) =
    \frac{Q'}{\sqrt{\kappa \new{t}}}
      \cdot
    U (\new{\xi}).
$$
----
Applying
$
  \old{\pd / {\pd x}} =
    \roundbr{1 / \sqrt{\kappa \new{t}}}
    \new{\pd / {\pd\xi}}
$
(the chain-rule result for the position derivative),
we get
----
$$
\begin{aligned}
  \old{\frac{\pd T}{\pd x}}
    &=
      \frac{1}{\sqrt{\kappa \new{t}}}
      \new{\frac{\pd}{\pd\xi}}
      \squarebr{
        \frac{Q'}{\sqrt{\kappa \new{t}}}
          \cdot
        U (\new{\xi})
      }
      \\[\tallspace]
    &=
      \frac{Q'}{\kappa \new{t}}
      \frac{\new{\td} U}{\new{\td \xi}}.
\end{aligned}
$$
----
Applying it a second time, we get
----
$$
\begin{aligned}
  \old{\frac{\pd^2 T}{{\pd x}^2}}
    &=
      \frac{1}{\sqrt{\kappa \new{t}}}
      \new{\frac{\pd}{\pd\xi}}
      \squarebr{
        \frac{Q'}{\kappa \new{t}}
        \frac{\new{\td} U}{\new{\td \xi}}
      }
      \\[\tallspace]
    &=
      \frac{Q'}{(\kappa \new{t}) ^ {3/2}}
      \frac{\new{\td^2} U}{\new{{\td \xi}^2}}.
\end{aligned}
$$

----
Start again from
----
$$
  T (\old{x}, \old{t}) =
    \frac{Q'}{\sqrt{\kappa \new{t}}}
      \cdot
    U (\new{\xi}).
$$
----
Applying
$
  \old{\roundbr{\pd / {\pd t}}_x} =
    \roundbr{-\new{\xi} / (2 \new{t})}
    \new{\pd / {\pd\xi}}
      +
    \new{\roundbr{\pd / {\pd t}}_\xi}
$
(the chain-rule result for the time derivative),
we get
----
$$
\begin{aligned}
  \old{\roundbr{\frac{\pd T}{\pd t}}_x}
    &=
      -\frac{\new{\xi}}{2 \new{t}}
      \new{\frac{\pd}{\pd\xi}}
      \squarebr{
        \frac{Q'}{\sqrt{\kappa \new{t}}}
          \cdot
        U (\new{\xi})
      }
        +
      \roundbr{
        \new{\frac{\pd}{\pd t}}
        \squarebr{
          \frac{Q'}{\sqrt{\kappa \new{t}}}
            \cdot
          U (\new{\xi})
        }
      }_{\new{\xi}}
      \\[\tallspace]
    &=
      -\frac{\new{\xi}}{2 \new{t}}
      \frac{Q'}{\sqrt{\kappa \new{t}}}
      \frac{\new{\td} U}{\new{\td\xi}}
        +
      \frac{Q'}{\sqrt{\kappa}}
        \cdot
      \frac{-1/2}{\new{t} ^ {3/2}}
        \cdot
      U.
\end{aligned}
$$
----
Therefore
----
$${.important}
\begin{aligned}
  \old{\frac{\pd^2 T}{{\pd x}^2}} &=
    \frac{Q'}{(\kappa \new{t}) ^ {3/2}}
    \frac{\new{\td^2} U}{\new{{\td \xi}^2}}
    \\[\tallspace]
  \old{\roundbr{\frac{\pd T}{\pd t}}_x} &=
    -
      \frac{\new{\xi}}{2 \new{t}}
      \frac{Q'}{\sqrt{\kappa \new{t}}}
      \frac{\new{\td} U}{\new{\td \xi}}
    +
      \frac{Q'}{\sqrt{\kappa}}
        \cdot
      \frac{-1/2}{\new{t} ^ {3/2}}
        \cdot
      U.
\end{aligned}
$$

----
[Return to the corresponding line in %similarity-title.]\
  (/similarity/#algebra-derivatives)
----


##{#heat-equation} Heat equation

----
The heat equation says that
----
$$
  \old{\roundbr{\frac{\pd T}{\pd t}}_x}
    =
  \kappa
  \old{\frac{\pd^2 T}{{\pd x}^2}}.
$$
----
Substituting the results for the derivatives of temperature,
this becomes
----
$$
\begin{aligned}
  -\frac{\new{\xi}}{2 \new{t}}
  \frac{Q'}{\sqrt{\kappa \new{t}}}
  \frac{\new{\td} U}{\new{\td\xi}}
    +
  \frac{Q'}{\sqrt{\kappa}}
    \cdot
  \frac{-1/2}{\new{t} ^ {3/2}}
    \cdot
  U
    &=
  \kappa
    \cdot
  \frac{Q'}{(\kappa \new{t}) ^ {3/2}}
  \frac{\new{\td^2} U}{\new{{\td \xi}^2}}
    \\[\tallspace]
  \cancel{
    \frac{Q'}{\sqrt{\kappa} \cdot \new{t}^{3/2}}
  }
  \squarebr{
    -\frac{\new{\xi}}{2}
    \frac{\new{\td} U}{\new{\td\xi}}
      -
    \frac{U}{2}
  }
    &=
  \cancel{
    \frac{Q'}{\sqrt{\kappa} \cdot \new{t}^{3/2}}
  }
  \squarebr{
    \frac{\new{\td^2} U}{\new{{\td \xi}^2}}
  }
\end{aligned}
$$
----
Therefore
----
$${.important}
  \frac{\new{\td^2} U}{\new{{\td \xi}^2}}
  + \frac{\new{\xi}}{2} \frac{\new{\td} U}{\new{\td \xi}}
  + \frac{U}{2}
    = 0.
$$

----
[Return to the corresponding line in %similarity-title.]\
  (/similarity/#algebra-heat-equation)
----


\END

----
\home
----

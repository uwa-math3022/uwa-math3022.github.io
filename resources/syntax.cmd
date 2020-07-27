<##
  ----------------------------------------------------------------
  Preamble defaults
  ----------------------------------------------------------------
##>

p{%%
  ^
  (?P<percent_signs> [%]{2,} )
    \n
    (?P<content> [\s\S]*? )
  ^
  (?P=percent_signs)
%%
  \g<percent_signs>
    %title-suffix \\ | UWA MATH3022
    \g<content>
  \g<percent_signs>
%%}


<##
  ----------------------------------------------------------------
  Preamble resources
  ----------------------------------------------------------------
##>


p{::
  \resources:maths
::
  \\resources:no-maths
  a~~
    <script defer src="/resources/maths.min.js"></script>
    <link rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/katex@0.12.0/dist/katex.min.css"
      integrity="sha384-\
        AfEj0r4/OFrOo5t7NnNe46zW/tFgW6x/bCJG8FqQCEo3+Aro6EYUG4+cU+KJWu/X\
      "
      crossorigin="anonymous">
    <script defer
      src="https://cdn.jsdelivr.net/npm/katex@0.12.0/dist/katex.min.js"
      integrity="sha384-\
        g7c+Jr9ZivxKLnZTDUhnkOnsh30B4H0rpLUpJ4jAIKs4fnJI+sEnkvrMWph2EDg4\
      "
      crossorigin="anonymous"
      onload="renderMaths()"></script>
  ~~
::}


p{::
  \resources:no-maths
::
  %resources a~~
    <link rel="stylesheet" href="/resources/main.min.css">
  ~~
::}


<##
  ----------------------------------------------------------------
  Noscript for equation rendering
  ----------------------------------------------------------------
##>


Z{:: \noscript ::
  a~~
    <noscript>Enable JavaScript for equation rendering to work.</noscript>
  ~~
::}


<##
  ----------------------------------------------------------------
  Heading permalinks (<h2> through <h6>)
  ----------------------------------------------------------------
##>

s{%
  <h[2-6]
    [ ]
    id = " (?P<id_> [^"]+? ) "
  >
%
  \g<0><a class="permalink" href="#\g<id_>" aria-label="Permalink"></a>
%}


<##
  ----------------------------------------------------------------
  Coloured spans  [c/ /]
  ----------------------------------------------------------------
  c is the colour letter, one of r, g, b, v.
##>


Z{%
  \[ (?P<colour_letter> [rgbv] )
    /
      [\s]*
      (?P<content> [\s\S] *? )
      [\s]*
    /
  \]
%
  <span class="colour-\g<colour_letter>">\g<content></span>
%}


<##
  ----------------------------------------------------------------
  END
  ----------------------------------------------------------------
##>


b{: \END :
  ||||{.end}
    END
  ||||
:}


<##
  ----------------------------------------------------------------
  Return home
  ----------------------------------------------------------------
##>


b{: \home :
  ----
  [Return to the home page.](/)
  ----
:}


<##
  ----------------------------------------------------------------
  Footer
  ----------------------------------------------------------------
##>

p{%
  \Z
%
  <footer>
    Last modified: %date-modified
      \\+
    Content on this site is [released into the public domain](
      https://creativecommons.org/publicdomain/zero/1.0/
    ).
      \\+
    Mistakes/queries:
    [email me][email], [raise an issue][issue], or [make a pull request][pr].
  </footer>
  @@[email] mailto:conway.li@research.uwa.edu.au @@
  @[issue]
    https://github.com/uwa-math3022/uwa-math3022.github.io/issues @
  @[pr]
    https://github.com/uwa-math3022/uwa-math3022.github.io/pulls @
%}

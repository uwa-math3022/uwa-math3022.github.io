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
      href="https://cdn.jsdelivr.net/npm/katex@0.11.1/dist/katex.min.css"
      integrity="sha384-\
        zB1R0rpPzHqg7Kpt0Aljp8JPLqbXI3bhnPWROx27a9N0Ll6ZP/+DiW/UqRcLbRjq\
      "
      crossorigin="anonymous">
    <script defer
      src="https://cdn.jsdelivr.net/npm/katex@0.11.1/dist/katex.min.js"
      integrity="sha384-\
        y23I5Q6l+B6vatafAwxRu/0oK/79VlbSz7Q9aiSZUvyWYIYsd+qj+o24G5ZU2zJz\
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
  Footer
  ----------------------------------------------------------------
##>

p{%
  \Z
%
  <footer>
    Last modified: %date-modified \+
    Content on this site is [released into the public domain](
      https://creativecommons.org/publicdomain/zero/1.0/
    ).
  </footer>
%}

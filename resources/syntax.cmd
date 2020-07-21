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
  \resources:no-maths
::
  %resources
    <link rel="stylesheet" href="/resources/main.css">
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

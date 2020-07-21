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

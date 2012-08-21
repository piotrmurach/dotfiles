alias cd..='cd ..'
if $(gls &>/dev/null); then
  alias l="gls -lAh --color"
  alias ll="gls -l --color"
  alias la='gls -A --color'
fi

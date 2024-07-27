# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`
if $(gls &>/dev/null)
then
  alias ls="gls -F --color"
  alias l="gls -lAh --color"
  alias ll="gls -l --color"
  alias la='gls -A --color'
fi
# vscode alias
if [ -d "/Applications/Visual Studio Code.app" ]; then
  alias code="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code "
fi
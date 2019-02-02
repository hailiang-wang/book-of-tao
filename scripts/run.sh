#! /bin/bash
###########################################
# https://github.com/thomasWeise/docker-texlive
###########################################

# constants
baseDir=$(cd `dirname "$0"`;pwd)
# functions

# main
[ -z "${BASH_SOURCE[0]}" -o "${BASH_SOURCE[0]}" = "$0" ] || return
cd $baseDir/..
set -e

docker run -it --rm \
  -v $PWD:/doc \
  -v $PWD/others/msttcorefonts:/usr/share/fonts/external \
  samurais/texlive:1.0.0 \
  bash
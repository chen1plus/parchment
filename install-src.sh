#!/usr/bin/env bash
# @describe Install the Parchment Typst templates as local packages
# @meta require-tools curl,tar,typst
# @meta binname install.sh

# @option --path=`default_path` Installation path, default to the path shown in `typst info`
# @option --ref=main            Download reference from GitHub

function default_path {
  typst info 2>&1 | tr -d '\r' |
    sed -n 's/^[[:space:]]*Package path[[:space:]]\{1,\}//p' | head -n 1
}

function die {
  printf 'Error: %s\n' "$*" >&2
  exit 1
}

set -e
source_path=$(mktemp -d)
staging_dir=''

function cleanup {
  [ -z "$staging_dir" ] || rm -rf "$staging_dir"
  [ -z "$source_path" ] || rm -rf "$source_path"
}

trap cleanup EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

function fetch_source {
  local archive=$source_path/parchment.tar.gz
  local url=https://github.com/chen1plus/parchment/archive/refs/heads/${argc_ref}.tar.gz

  echo "Downloading $url"
  curl -fsSL "$url" >"$archive"
  tar -xf "$archive" -C "$source_path" --strip-components=1
}

function manifest_field {
  sed -n "s/^$2 *= *\"\([^\"]*\)\".*/\1/p" "$1"
}

function install_templates {
  local manifest name version
  for manifest in "$source_path"/*/typst.toml; do
    [ -f "$manifest" ] || continue
    name=$(manifest_field "$manifest" name)
    version=$(manifest_field "$manifest" version)

    local stage=$staging_dir/$name
    local dest_dir=$argc_path/local/$name
    local dest=$dest_dir/$version
    mkdir -p "$dest_dir"
    mkdir -p "$stage"

    cp -R "${manifest%/typst.toml}/." "$stage/"
    rm -f "$stage/example.pdf" "$stage/example-en.pdf"
    if [ -e "$dest" ]; then
      echo "Replacing local/$name:$version"
      rm -rf "$dest"
    fi

    mv "$stage" "$dest"
    echo "Installed local/$name:$version"
  done
}

function main {
  [ $# -eq 0 ] || die "unexpected argument: $1 (try --help)"

  mkdir -p "$argc_path"
  staging_dir=$(mktemp -d "$argc_path/.XXXXXX")

  fetch_source
  install_templates
  echo Parchment templates installed successfully
}

eval "$(argc --argc-eval "$0" "$@")"

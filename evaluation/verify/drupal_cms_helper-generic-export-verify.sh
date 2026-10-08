#!/usr/bin/env bash
# Execution VERIFY (hard): confirm the site's config was exported with drupal_cms_helper's
# `--generic` option to web/sites/default/files/eval-generic-export. Prints PASS/FAIL and
# exits 0 (pass) / 1 (fail). No arguments.
#
# Discriminator: `config:export --generic` strips `_core` and `uuid` from exported config.
# node.type.article is a config entity that normally carries a `uuid:` line; with --generic it
# must be gone. A plain `config:export` (no --generic) leaves the uuid in and FAILS here.
set -uo pipefail
cd /var/www/html
DIR=/var/www/html/web/sites/default/files/eval-generic-export
FILE="$DIR/node.type.article.yml"

if [ ! -f "$FILE" ]; then
  echo "FAIL: $FILE not found (config not exported to the expected directory)"
  exit 1
fi

uuid_line=$(grep -c '^uuid:' "$FILE" || true)
core_line=$(grep -c '^_core:' "$FILE" || true)

if [ "$uuid_line" -eq 0 ] && [ "$core_line" -eq 0 ]; then
  echo "PASS: generic export present; node.type.article.yml has no uuid/_core keys"
  exit 0
else
  echo "FAIL: node.type.article.yml still has uuid/_core (uuid_lines=$uuid_line core_lines=$core_line) — was --generic used?"
  exit 1
fi

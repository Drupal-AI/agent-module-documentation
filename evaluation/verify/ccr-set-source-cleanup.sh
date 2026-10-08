#!/usr/bin/env bash
# Execution CLEANUP: restore currency_source baseline.
set -uo pipefail
cd /var/www/html
STASH=/tmp/ccr-set-source.stash
if [ -f "$STASH" ]; then
  val=$(cat "$STASH"); [ -z "$val" ] && val=combo
  drush cset -y commerce_currency_resolver.settings currency_source "$val" >/dev/null 2>&1
  rm -f "$STASH"
  echo "cleanup: currency_source restored to $val"
else echo "cleanup: no stash"; fi

#!/usr/bin/env bash
# Introspection CLEANUP: restore currency_source from the stash. Idempotent.
set -uo pipefail
cd /var/www/html
STASH=/tmp/ccr-source-mode.stash
if [ -f "$STASH" ]; then
  val=$(cat "$STASH"); [ -z "$val" ] && val=combo
  drush cset -y commerce_currency_resolver.settings currency_source "$val" >/dev/null 2>&1
  rm -f "$STASH"
  echo "cleanup: currency_source restored to $val"
else
  echo "cleanup: no stash, nothing to restore"
fi

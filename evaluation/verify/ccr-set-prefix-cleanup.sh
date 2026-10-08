#!/usr/bin/env bash
# Execution CLEANUP: restore currency_field_prefix baseline.
set -uo pipefail
cd /var/www/html
STASH=/tmp/ccr-set-prefix.stash
if [ -f "$STASH" ]; then
  val=$(cat "$STASH"); [ -z "$val" ] && val=field_price_
  drush cset -y commerce_currency_resolver.settings currency_field_prefix "$val" >/dev/null 2>&1
  rm -f "$STASH"
  echo "cleanup: currency_field_prefix restored to $val"
else echo "cleanup: no stash"; fi

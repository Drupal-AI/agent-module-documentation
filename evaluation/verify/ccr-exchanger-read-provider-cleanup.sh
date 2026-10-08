#!/usr/bin/env bash
# Introspection CLEANUP: restore currency_exchange_rates baseline.
set -uo pipefail
cd /var/www/html
STASH=/tmp/ccr-exchanger-provider.stash
if [ -f "$STASH" ]; then
  val=$(cat "$STASH")
  drush cset -y commerce_currency_resolver.settings currency_exchange_rates "$val" >/dev/null 2>&1
  rm -f "$STASH"; echo "cleanup: currency_exchange_rates restored to '$val'"
else echo "cleanup: no stash"; fi

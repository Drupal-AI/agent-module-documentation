#!/usr/bin/env bash
# Introspection SETUP: stash currency_exchange_rates, set a known provider id 'ccr_demo_rates'.
set -uo pipefail
cd /var/www/html
STASH=/tmp/ccr-exchanger-provider.stash
[ -f "$STASH" ] || drush cget commerce_currency_resolver.settings currency_exchange_rates --format=string 2>/dev/null > "$STASH"
drush cset -y commerce_currency_resolver.settings currency_exchange_rates ccr_demo_rates >/dev/null 2>&1
echo "setup: currency_exchange_rates=ccr_demo_rates (baseline stashed)"

#!/usr/bin/env bash
# Execution RESET: stash currency_source, set to non-target 'combo' so verify FAILs until 'auto'.
set -uo pipefail
cd /var/www/html
STASH=/tmp/ccr-exchanger-source.stash
[ -f "$STASH" ] || drush cget commerce_currency_resolver.settings currency_source --format=string 2>/dev/null > "$STASH"
drush cset -y commerce_currency_resolver.settings currency_source combo >/dev/null 2>&1
echo "reset: currency_source=combo (target auto)"

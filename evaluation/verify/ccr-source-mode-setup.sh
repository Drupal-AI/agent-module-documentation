#!/usr/bin/env bash
# Introspection SETUP: stash live currency_source, then set it to a known value 'auto'
# so the agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
STASH=/tmp/ccr-source-mode.stash
[ -f "$STASH" ] || drush cget commerce_currency_resolver.settings currency_source --format=string 2>/dev/null > "$STASH"
drush cset -y commerce_currency_resolver.settings currency_source auto >/dev/null 2>&1
echo "setup: currency_source=auto (baseline stashed in $STASH)"

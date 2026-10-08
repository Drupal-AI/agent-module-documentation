#!/usr/bin/env bash
# Introspection SETUP: stash live currency_field_prefix, then set a distinctive known value.
set -uo pipefail
cd /var/www/html
STASH=/tmp/ccr-prefix.stash
[ -f "$STASH" ] || drush cget commerce_currency_resolver.settings currency_field_prefix --format=string 2>/dev/null > "$STASH"
drush cset -y commerce_currency_resolver.settings currency_field_prefix field_ccrtest_ >/dev/null 2>&1
echo "setup: currency_field_prefix=field_ccrtest_ (baseline stashed)"

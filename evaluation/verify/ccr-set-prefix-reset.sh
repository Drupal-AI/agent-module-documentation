#!/usr/bin/env bash
# Execution RESET: stash baseline, set prefix to default 'field_price_' (non-target) so verify
# FAILs until the agent sets 'field_money_'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
STASH=/tmp/ccr-set-prefix.stash
[ -f "$STASH" ] || drush cget commerce_currency_resolver.settings currency_field_prefix --format=string 2>/dev/null > "$STASH"
drush cset -y commerce_currency_resolver.settings currency_field_prefix field_price_ >/dev/null 2>&1
echo "reset: currency_field_prefix=field_price_ (target is field_money_)"

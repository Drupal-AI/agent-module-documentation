#!/usr/bin/env bash
# Execution RESET: stash baseline, set currency_source to a NON-target value ('field') so
# verify FAILs until the agent sets it to 'combo'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
STASH=/tmp/ccr-set-source.stash
[ -f "$STASH" ] || drush cget commerce_currency_resolver.settings currency_source --format=string 2>/dev/null > "$STASH"
drush cset -y commerce_currency_resolver.settings currency_source field >/dev/null 2>&1
echo "reset: currency_source=field (target is combo)"

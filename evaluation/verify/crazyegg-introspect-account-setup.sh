#!/usr/bin/env bash
# Introspection SETUP: set a known Crazy Egg account number and footer scope. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset crazyegg.settings crazyegg_account_id 7654321 -y >/dev/null 2>&1
drush cset crazyegg.settings crazyegg_js_scope footer -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: crazyegg.settings crazyegg_account_id=7654321 crazyegg_js_scope=footer"

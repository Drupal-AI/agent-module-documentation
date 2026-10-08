#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped defaults (empty account id, header scope). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("crazyegg.settings")->set("crazyegg_account_id","")->set("crazyegg_js_scope","header")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: crazyegg.settings restored (account_id='' js_scope=header)"

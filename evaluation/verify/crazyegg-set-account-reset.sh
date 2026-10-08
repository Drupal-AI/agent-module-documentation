#!/usr/bin/env bash
# Execution RESET: clear account id and force header scope so verify FAILS until agent sets them.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("crazyegg.settings")->set("crazyegg_account_id","")->set("crazyegg_js_scope","header")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: crazyegg.settings account_id='' js_scope=header"

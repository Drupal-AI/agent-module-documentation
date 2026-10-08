#!/usr/bin/env bash
# Introspection CLEANUP: remove copyprevention_body (restore shipped baseline: no body options). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("copyprevention.settings");
  $c->clear("copyprevention_body")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: copyprevention_body cleared"

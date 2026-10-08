#!/usr/bin/env bash
# Introspection CLEANUP: remove the tac_lite_storage_type key (baseline has none; code defaults
# to tid). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("tac_lite.settings")->clear("tac_lite_storage_type")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: tac_lite_storage_type removed (baseline restored)"

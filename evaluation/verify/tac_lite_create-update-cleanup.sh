#!/usr/bin/env bash
# Introspection CLEANUP: remove the scheme-1 config key (baseline has none). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("tac_lite.settings")->clear("tac_lite_config_scheme_1")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: tac_lite_config_scheme_1 removed (baseline restored)"

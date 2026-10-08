#!/usr/bin/env bash
# Execution CLEANUP: restore the number of tac_lite schemes to the baseline (1). Also clears any
# scheme-2 config the agent may have created. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("tac_lite.settings")
    ->set("tac_lite_schemes", 1)
    ->clear("tac_lite_config_scheme_2")
    ->clear("tac_lite_grants_scheme_2")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: tac_lite_schemes reset to 1 (baseline restored)"

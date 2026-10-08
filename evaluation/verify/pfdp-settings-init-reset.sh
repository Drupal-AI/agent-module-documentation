#!/usr/bin/env bash
# Execution RESET: delete the pfdp.settings config object entirely, restoring the state a plain
# install of this module leaves behind (config/install/pfdp.settings is missing its .yml
# extension, so the object never gets created). The matching verify FAILS in this state.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("pfdp.settings")->delete();
  $raw = \Drupal::service("config.storage")->read("pfdp.settings");
  print "pfdp.settings exists=" . var_export($raw !== FALSE, TRUE) . "\n";
' 2>/dev/null
echo "reset: pfdp.settings removed"

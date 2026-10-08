#!/usr/bin/env bash
# CLEANUP/baseline: remove the ipless mapping from system.performance (fresh-install default:
# the key is absent, all getters treat it as FALSE). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("system.performance")->clear("ipless")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: system.performance ipless key cleared (baseline)"

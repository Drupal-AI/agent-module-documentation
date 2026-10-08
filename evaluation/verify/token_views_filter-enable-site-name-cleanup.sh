#!/usr/bin/env bash
# Execution CLEANUP: delete the namespaced View config tvf_build (config API). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("views.view.tvf_build")->delete();' >/dev/null 2>&1
echo "cleanup: views.view.tvf_build deleted"

#!/usr/bin/env bash
# Introspection CLEANUP: delete the namespaced View config tvf_known (config API). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("views.view.tvf_known")->delete();' >/dev/null 2>&1
echo "cleanup: views.view.tvf_known deleted"

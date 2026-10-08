#!/usr/bin/env bash
# Execution CLEANUP: delete the styleguide settings config object (baseline: unset). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("simple_styleguide.styleguidesettings")->delete();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: simple_styleguide.styleguidesettings deleted"

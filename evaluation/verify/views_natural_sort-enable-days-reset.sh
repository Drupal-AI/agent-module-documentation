#!/usr/bin/env bash
# Execution RESET: force days_of_the_week.enabled = FALSE (baseline) so verify FAILS until enabled.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("views_natural_sort.settings")->set("transformation_settings.days_of_the_week.enabled", false)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: days_of_the_week.enabled=false"

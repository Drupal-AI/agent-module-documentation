#!/usr/bin/env bash
# Hard (execution) RESET: put composer_deploy prefixes back to the shipped default [drupal]
# so the "add acme prefix" task starts from a clean baseline (verify must FAIL here).
set -uo pipefail
cd /var/www/html
drush pm:enable composer_deploy -y >/dev/null 2>&1
drush php:eval '\Drupal::configFactory()->getEditable("composer_deploy.settings")
  ->set("prefixes", ["drupal"])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: composer_deploy.settings:prefixes = [drupal] (baseline)"

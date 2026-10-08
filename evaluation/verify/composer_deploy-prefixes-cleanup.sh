#!/usr/bin/env bash
# Medium (introspection) CLEANUP: restore prefixes to the shipped default [drupal].
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("composer_deploy.settings")
  ->set("prefixes", ["drupal"])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: composer_deploy.settings:prefixes restored to [drupal]"

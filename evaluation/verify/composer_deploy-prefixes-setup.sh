#!/usr/bin/env bash
# Medium (introspection) SETUP: write a known non-default prefixes value so the agent has
# something specific to read back from composer_deploy.settings on the live site.
set -uo pipefail
cd /var/www/html
drush pm:enable composer_deploy -y >/dev/null 2>&1
drush php:eval '\Drupal::configFactory()->getEditable("composer_deploy.settings")
  ->set("prefixes", ["drupal", "zeta"])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: composer_deploy.settings:prefixes = [drupal, zeta]"

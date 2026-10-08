#!/usr/bin/env bash
# Execution CLEANUP: restore add_another_link off. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("link_field_tweak.settings")->set("add_another_link", FALSE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: link_field_tweak.settings add_another_link=FALSE"

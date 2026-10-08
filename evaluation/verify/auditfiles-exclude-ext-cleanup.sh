#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("auditfiles.settings")->set("auditfiles_exclude_extensions", "")->save();' >/dev/null 2>&1
echo "cleanup: auditfiles_exclude_extensions restored to ''"

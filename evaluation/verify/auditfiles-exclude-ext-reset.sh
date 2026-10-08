#!/usr/bin/env bash
# Execution RESET: clear the excluded-extensions setting (shipped default is empty). verify
# FAILS until the agent adds 'tmp' to the excluded extensions. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("auditfiles.settings")->set("auditfiles_exclude_extensions", "")->save();' >/dev/null 2>&1
echo "reset: auditfiles_exclude_extensions='' (default)"

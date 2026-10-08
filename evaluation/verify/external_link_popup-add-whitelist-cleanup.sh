#!/usr/bin/env bash
# Execution CLEANUP: restore the global whitelist to its shipped default (empty). Idempotent.
# Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("external_link_popup.settings")->set("whitelist", "")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: external_link_popup.settings whitelist reset to empty"

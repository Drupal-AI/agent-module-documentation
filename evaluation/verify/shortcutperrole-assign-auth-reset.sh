#!/usr/bin/env bash
# Execution RESET (shortcutperrole, layman): ensure the authenticated role has NO shortcut set
# mapping so verify FAILS until assigned. Config-only. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("shortcutperrole.settings")
    ->clear("role.authenticated")->save();
' >/dev/null 2>&1 || true
echo "reset: shortcutperrole.settings role.authenticated cleared"
exit 0

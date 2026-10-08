#!/usr/bin/env bash
# Execution RESET (shortcutperrole): ensure the content_editor role has NO shortcut set mapping,
# so verify FAILS until the agent assigns one. Config-only. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("shortcutperrole.settings")
    ->clear("role.content_editor")->save();
' >/dev/null 2>&1 || true
echo "reset: shortcutperrole.settings role.content_editor cleared"
exit 0

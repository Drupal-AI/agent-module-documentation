#!/usr/bin/env bash
# Execution CLEANUP: drop the css_editor config/file for Stark and uninstall Stark. Idempotent.
# Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if (file_exists("public://css_editor/stark.css")) {
    \Drupal::service("file_system")->delete("public://css_editor/stark.css");
  }
  \Drupal::configFactory()->getEditable("css_editor.theme.stark")->delete();
' >/dev/null 2>&1
drush theme:uninstall stark -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: css_editor.theme.stark config, generated file and the Stark theme removed"

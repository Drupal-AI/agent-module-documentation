#!/usr/bin/env bash
# Execution RESET: install the core Stark theme and clear every trace of css_editor config and
# generated CSS for it, so verify FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush theme:enable stark -y >/dev/null 2>&1
drush php:eval '
  if (file_exists("public://css_editor/stark.css")) {
    \Drupal::service("file_system")->delete("public://css_editor/stark.css");
  }
  \Drupal::configFactory()->getEditable("css_editor.theme.stark")->delete();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: Stark installed, css_editor.theme.stark config and generated file removed"

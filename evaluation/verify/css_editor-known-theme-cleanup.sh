#!/usr/bin/env bash
# Introspection CLEANUP: delete the css_editor config and generated file for Stark and
# uninstall the Stark theme. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $path = \Drupal::config("css_editor.theme.stark")->get("path");
  if ($path && file_exists($path)) { \Drupal::service("file_system")->delete($path); }
  \Drupal::configFactory()->getEditable("css_editor.theme.stark")->delete();
' >/dev/null 2>&1
drush theme:uninstall stark -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: css_editor.theme.stark config, generated file and the Stark theme removed"

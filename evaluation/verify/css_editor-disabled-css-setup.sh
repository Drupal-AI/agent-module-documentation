#!/usr/bin/env bash
# Introspection SETUP: install the core Stark theme and save custom CSS for it via css_editor
# but leave the master switch OFF and remove any generated stylesheet, so the CSS exists in
# config yet is never served. The agent must diagnose that from the live site. Idempotent.
# Exit 0.
set -uo pipefail
cd /var/www/html
drush theme:enable stark -y >/dev/null 2>&1
drush php:eval '
  \Drupal::configFactory()->getEditable("css_editor.theme.stark")
    ->set("enabled", FALSE)
    ->set("css", ".ce-offline-note { color: #ff0066; }")
    ->set("plaintext_enabled", FALSE)
    ->set("autopreview_enabled", TRUE)
    ->set("path", "public://css_editor/stark.css")
    ->save();
  if (file_exists("public://css_editor/stark.css")) {
    \Drupal::service("file_system")->delete("public://css_editor/stark.css");
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: css_editor.theme.stark has css but enabled=FALSE and no generated file"

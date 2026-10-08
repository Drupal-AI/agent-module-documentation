#!/usr/bin/env bash
# Introspection SETUP: install the core Stark theme (as an isolated sandbox theme) and give it
# custom CSS through css_editor, generating the real stylesheet file. The default theme is NOT
# changed. The agent must read css_editor.theme.* on the live site to answer. Idempotent.
# Exit 0.
set -uo pipefail
cd /var/www/html
drush theme:enable stark -y >/dev/null 2>&1
drush php:eval '
  \Drupal::configFactory()->getEditable("css_editor.theme.stark")
    ->set("enabled", TRUE)
    ->set("css", ".ce-probe-banner { background-color: #bada55; border: 2px dashed #123456; }")
    ->set("plaintext_enabled", TRUE)
    ->set("autopreview_enabled", FALSE)
    ->save();
  \Drupal::service("css_editor.css_generator")->generateCssFile("stark");
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: css_editor.theme.stark enabled with .ce-probe-banner rule; file generated"

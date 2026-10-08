#!/usr/bin/env bash
# Execution RESET: install Stark and give it ACTIVE css_editor custom CSS (enabled + generated
# stylesheet), so the module really would serve it and verify FAILS until the agent turns it
# off. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush theme:enable stark -y >/dev/null 2>&1
drush php:eval '
  \Drupal::configFactory()->getEditable("css_editor.theme.stark")
    ->set("enabled", TRUE)
    ->set("css", ".ce-rollback-marker { display: none !important; }")
    ->set("plaintext_enabled", FALSE)
    ->set("autopreview_enabled", FALSE)
    ->save();
  \Drupal::service("css_editor.css_generator")->generateCssFile("stark");
' >/dev/null 2>&1
echo "reset: css_editor.theme.stark enabled with .ce-rollback-marker and stylesheet generated"

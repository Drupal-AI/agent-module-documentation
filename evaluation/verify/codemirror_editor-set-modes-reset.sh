#!/usr/bin/env bash
# Execution RESET: restore codemirror_editor.settings defaults (language_modes=[xml] only), so
# verify FAILS until the agent adds the required modes. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("codemirror_editor.settings")
    ->set("cdn", TRUE)->set("minified", TRUE)->set("theme", "default")
    ->set("language_modes", ["xml"])->save();' >/dev/null 2>&1
echo "reset: codemirror_editor.settings defaults (language_modes=[xml])"

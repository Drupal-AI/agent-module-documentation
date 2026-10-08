#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped codemirror_editor.settings defaults. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("codemirror_editor.settings")
    ->set("cdn", TRUE)->set("minified", TRUE)->set("theme", "default")
    ->set("language_modes", ["xml"])->save();' >/dev/null 2>&1
echo "cleanup: codemirror_editor.settings restored to defaults"

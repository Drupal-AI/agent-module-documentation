#!/usr/bin/env bash
# Execution RESET: restore defaults (cdn=true, minified=true), so verify FAILS until the agent
# switches CodeMirror to a self-hosted, un-minified build. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("codemirror_editor.settings")
    ->set("cdn", TRUE)->set("minified", TRUE)->set("theme", "default")
    ->set("language_modes", ["xml"])->save();' >/dev/null 2>&1
echo "reset: codemirror_editor.settings defaults (cdn=true, minified=true)"

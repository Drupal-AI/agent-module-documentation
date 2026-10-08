#!/usr/bin/env bash
# Introspection SETUP: set a known CodeMirror theme and preloaded language modes so an agent
# can read them back from codemirror_editor.settings. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("codemirror_editor.settings")
    ->set("theme", "material")
    ->set("language_modes", ["css", "javascript", "twig"])->save();
' >/dev/null 2>&1
echo "setup: codemirror theme=material, language_modes=[css,javascript,twig]"

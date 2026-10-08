#!/usr/bin/env bash
# Introspection SETUP: set DubBot report position to 'Top' (off_canvas_top) and a distinctive
# preview selector, so an agent can read the live config back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("dubbot.settings")
    ->set("dialog_renderer", "off_canvas_top")
    ->set("preview_selector", ".dubbot-probe-region")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: dubbot.settings dialog_renderer=off_canvas_top preview_selector=.dubbot-probe-region"

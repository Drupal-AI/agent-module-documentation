#!/usr/bin/env bash
# Introspection SETUP: give Type Tray a non-default fallback label and text format so the agent
# has to read the live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("type_tray.settings")
    ->set("categories", ["tt_editorial" => "Editorial"])
    ->set("fallback_label", "Other content")
    ->set("text_format", "basic_html")
    ->save();
' >/dev/null 2>&1
echo "setup: type_tray.settings fallback_label='Other content' text_format=basic_html"

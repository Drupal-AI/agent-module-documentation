#!/usr/bin/env bash
# Introspection SETUP: set the global previewer view mode to a non-default value so the agent
# has to read the live config instead of reciting the "full" default. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("paragraphs_previewer.settings")
    ->set("previewer_view_mode", "teaser")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: paragraphs_previewer.settings previewer_view_mode=teaser"

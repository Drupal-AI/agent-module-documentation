#!/usr/bin/env bash
# Introspection SETUP: set the diff context lines that the Config Log Views diff field reads.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("config_log.settings")
    ->set("leading_context_lines", 3)->set("trailing_context_lines", 3)->save();
' >/dev/null 2>&1
echo "setup: leading/trailing_context_lines=3"

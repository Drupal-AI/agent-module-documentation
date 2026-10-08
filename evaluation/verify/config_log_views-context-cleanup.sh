#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("config_log.settings")
    ->set("leading_context_lines", 0)->set("trailing_context_lines", 0)->save();
' >/dev/null 2>&1
echo "cleanup: leading/trailing_context_lines=0 (default)"

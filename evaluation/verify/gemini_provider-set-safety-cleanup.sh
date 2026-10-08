#!/usr/bin/env bash
# Execution CLEANUP: clear safety_settings. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("gemini_provider.settings")->set("safety_settings", [])->save();
' >/dev/null 2>&1
echo "cleanup: safety_settings cleared"

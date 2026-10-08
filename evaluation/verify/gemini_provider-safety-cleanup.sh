#!/usr/bin/env bash
# Introspection CLEANUP: clear safety_settings back to empty. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("gemini_provider.settings")->set("safety_settings", [])->save();
' >/dev/null 2>&1
echo "cleanup: safety_settings cleared"

#!/usr/bin/env bash
# Execution RESET: clear gemini_provider safety_settings (verify FAILS until the agent sets the
# hate-speech threshold). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("gemini_provider.settings")->set("safety_settings", [])->save();
' >/dev/null 2>&1
echo "reset: safety_settings empty"

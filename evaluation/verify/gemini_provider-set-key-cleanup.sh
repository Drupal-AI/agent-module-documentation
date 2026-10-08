#!/usr/bin/env bash
# Execution CLEANUP: clear api_key and delete the Key entity. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\key\Entity\Key;
  \Drupal::configFactory()->getEditable("gemini_provider.settings")->set("api_key", "")->save();
  if ($k = Key::load("gemini_task_key")) { $k->delete(); }
' >/dev/null 2>&1
echo "cleanup: api_key reset, gemini_task_key deleted"

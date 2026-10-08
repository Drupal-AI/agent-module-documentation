#!/usr/bin/env bash
# Execution RESET: ensure the custom_language.lf_new config entity does NOT exist, so verify
# FAILS until the agent creates it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("custom_language");
  if ($e = $s->load("lf_new")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: custom_language.lf_new absent"

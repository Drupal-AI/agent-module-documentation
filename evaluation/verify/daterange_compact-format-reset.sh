#!/usr/bin/env bash
# Execution RESET (daterange_compact create format): ensure format dc_task is ABSENT, so verify
# FAILS until the agent creates it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("daterange_compact_format");
  if ($e = $s->load("dc_task")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: format dc_task absent"

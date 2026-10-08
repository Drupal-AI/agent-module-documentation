#!/usr/bin/env bash
# Execution RESET: ensure the ssi_task migration config entity does NOT exist, so verify
# FAILS until the agent creates one that uses the smart_sql id map. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("migration");
  if ($e = $s->load("ssi_task")) { $e->delete(); }
' >/dev/null 2>&1
echo "reset: ssi_task absent"

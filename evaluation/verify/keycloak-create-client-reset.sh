#!/usr/bin/env bash
# Execution RESET: ensure the openid_connect.client.kc_task client does NOT exist, so verify
# FAILS until the agent creates it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("openid_connect_client");
  if ($e = $s->load("kc_task")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: openid_connect.client.kc_task absent"

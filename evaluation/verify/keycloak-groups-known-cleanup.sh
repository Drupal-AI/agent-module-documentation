#!/usr/bin/env bash
# Introspection CLEANUP: delete the openid_connect.client.kc_groups client created by setup.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("openid_connect_client");
  if ($e = $s->load("kc_groups")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: openid_connect.client.kc_groups removed"

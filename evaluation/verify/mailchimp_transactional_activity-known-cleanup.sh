#!/usr/bin/env bash
# Introspection CLEANUP: delete the mta_user and mta_off Activity config entities. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("mailchimp_transactional_activity");
  foreach (["mta_user","mta_off"] as $id) { if ($e = $s->load($id)) { $e->delete(); } }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: mta_user, mta_off removed"

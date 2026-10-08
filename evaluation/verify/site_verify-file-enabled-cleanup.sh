#!/usr/bin/env bash
# Introspection CLEANUP: remove sv_file_on and sv_file_off created by the matching setup.
# Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("site_verification");
  foreach (["sv_file_on", "sv_file_off"] as $id) {
    if ($entity = $storage->load($id)) {
      $entity->delete();
    }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: sv_file_on and sv_file_off removed"

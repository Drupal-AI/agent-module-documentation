#!/usr/bin/env bash
# Introspection CLEANUP: remove the sv_known_meta entity created by the matching setup.
# Restores baseline (no sv_known_meta entity). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("site_verification");
  if ($entity = $storage->load("sv_known_meta")) {
    $entity->delete();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: sv_known_meta removed"

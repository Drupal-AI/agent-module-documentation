#!/usr/bin/env bash
# Introspection CLEANUP: delete the two text formats created by the matching setup.
# Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("filter_format");
  foreach (["iv_probe", "iv_plain"] as $id) {
    if ($f = $storage->load($id)) { $f->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: text formats iv_probe and iv_plain removed"

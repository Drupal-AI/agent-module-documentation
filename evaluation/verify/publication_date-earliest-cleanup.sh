#!/usr/bin/env bash
# Introspection CLEANUP: remove both 'PD First Post' and 'PD Second Post', restoring baseline.
# Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)
    ->condition("title", ["PD First Post", "PD Second Post"], "IN")->execute();
  if ($ids) { $storage->delete($storage->loadMultiple($ids)); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: removed 'PD First Post' + 'PD Second Post'"

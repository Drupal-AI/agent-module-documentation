#!/usr/bin/env bash
# Introspection CLEANUP: delete the known Article node created by setup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  $ids = $storage->getQuery()->accessCheck(FALSE)->condition("title", "EEP Preview Node 9K2")->execute();
  if ($ids) { $storage->delete($storage->loadMultiple($ids)); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: 'EEP Preview Node 9K2' removed"

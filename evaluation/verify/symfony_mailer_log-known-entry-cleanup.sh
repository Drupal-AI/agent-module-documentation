#!/usr/bin/env bash
# Introspection CLEANUP: delete the known symfony_mailer_log fixture entry. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("symfony_mailer_log");
  $ids = $storage->getQuery()->accessCheck(FALSE)
    ->condition("subject", "SMLOG Known Subject 7F3")->execute();
  if ($ids) { $storage->delete($storage->loadMultiple($ids)); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: SMLOG fixture entries removed"

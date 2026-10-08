#!/usr/bin/env bash
# Execution CLEANUP: delete the gapi_oauth OAuth account(s). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("google_api_client");
  $ids = $storage->getQuery()->accessCheck(FALSE)->condition("name", "gapi_oauth")->execute();
  if ($ids) { $storage->delete($storage->loadMultiple($ids)); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: gapi_oauth account removed"

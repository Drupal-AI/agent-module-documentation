#!/usr/bin/env bash
# Execution RESET: delete any google_api_client OAuth account named 'gapi_oauth' so verify FAILS
# until the agent creates it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("google_api_client");
  $ids = $storage->getQuery()->accessCheck(FALSE)->condition("name", "gapi_oauth")->execute();
  if ($ids) { $storage->delete($storage->loadMultiple($ids)); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: no google_api_client account named gapi_oauth"

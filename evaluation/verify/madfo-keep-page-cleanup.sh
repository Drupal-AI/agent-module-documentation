#!/usr/bin/env bash
# Execution CLEANUP: delete 'MAD Keep Page'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'foreach (\Drupal::entityTypeManager()->getStorage("media")->loadByProperties(["name" => "MAD Keep Page"]) as $m) { $m->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: MAD Keep Page removed"

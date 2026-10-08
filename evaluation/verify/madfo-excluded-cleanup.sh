#!/usr/bin/env bash
# Introspection CLEANUP: delete 'MAD Eval Excluded'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'foreach (\Drupal::entityTypeManager()->getStorage("media")->loadByProperties(["name" => "MAD Eval Excluded"]) as $m) { $m->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: MAD Eval Excluded removed"

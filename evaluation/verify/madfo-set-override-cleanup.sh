#!/usr/bin/env bash
# Execution CLEANUP: delete 'MAD Override Task'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'foreach (\Drupal::entityTypeManager()->getStorage("media")->loadByProperties(["name" => "MAD Override Task"]) as $m) { $m->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: MAD Override Task removed"

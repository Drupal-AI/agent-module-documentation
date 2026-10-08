#!/usr/bin/env bash
# Introspection CLEANUP (cacheflush): remove preset cf_known. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'foreach(\Drupal::entityTypeManager()->getStorage("cacheflush")->loadByProperties(["title"=>"cf_known"]) as $e){$e->delete();}' >/dev/null 2>&1
echo "cleanup: cf_known removed"

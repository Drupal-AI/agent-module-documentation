#!/usr/bin/env bash
# Introspection CLEANUP (cacheflush): remove cf_on and cf_off. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s=\Drupal::entityTypeManager()->getStorage("cacheflush");
  foreach($s->loadByProperties(["title"=>"cf_on"]) as $e){$e->delete();}
  foreach($s->loadByProperties(["title"=>"cf_off"]) as $e){$e->delete();}
' >/dev/null 2>&1
echo "cleanup: cf_on, cf_off removed"

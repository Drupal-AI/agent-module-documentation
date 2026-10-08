#!/usr/bin/env bash
# event_log_track_clear_cache introspection SETUP: insert one known 'cache_clear' sentinel row. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::database()->delete("event_log_track")->condition("ref_char","ELT_CACHE_MED")->execute();
  \Drupal::database()->insert("event_log_track")->fields([
    "type"=>"cache_clear","operation"=>"cache_clear","description"=>"ELT_CACHE_DESC","path"=>"/elt-cache",
    "ref_numeric"=>101,"ref_char"=>"ELT_CACHE_MED","uid"=>1,"ip"=>"127.0.0.1","created"=>\Drupal::time()->getRequestTime(),
  ])->execute();
' >/dev/null 2>&1
echo "setup: event_log_track cache_clear row (ref_char=ELT_CACHE_MED, operation=cache_clear, description=ELT_CACHE_DESC)"

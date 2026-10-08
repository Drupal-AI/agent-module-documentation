#!/usr/bin/env bash
# event_log_track_auth introspection SETUP: insert one known 'authentication' sentinel row. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::database()->delete("event_log_track")->condition("ref_char","ELT_AUTH_MED")->execute();
  \Drupal::database()->insert("event_log_track")->fields([
    "type"=>"authentication","operation"=>"login","description"=>"ELT_AUTH_DESC","path"=>"/elt-auth",
    "ref_numeric"=>101,"ref_char"=>"ELT_AUTH_MED","uid"=>1,"ip"=>"127.0.0.1","created"=>\Drupal::time()->getRequestTime(),
  ])->execute();
' >/dev/null 2>&1
echo "setup: event_log_track authentication row (ref_char=ELT_AUTH_MED, operation=login, description=ELT_AUTH_DESC)"

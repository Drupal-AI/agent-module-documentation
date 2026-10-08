#!/usr/bin/env bash
# event_log_track_tfa introspection SETUP: insert one known 'authentication_tfa' sentinel row. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::database()->delete("event_log_track")->condition("ref_char","ELT_TFA_MED")->execute();
  \Drupal::database()->insert("event_log_track")->fields([
    "type"=>"authentication_tfa","operation"=>"TFA login","description"=>"ELT_TFA_DESC","path"=>"/elt-tfa",
    "ref_numeric"=>101,"ref_char"=>"ELT_TFA_MED","uid"=>1,"ip"=>"127.0.0.1","created"=>\Drupal::time()->getRequestTime(),
  ])->execute();
' >/dev/null 2>&1
echo "setup: event_log_track authentication_tfa row (ref_char=ELT_TFA_MED, operation=TFA login, description=ELT_TFA_DESC)"

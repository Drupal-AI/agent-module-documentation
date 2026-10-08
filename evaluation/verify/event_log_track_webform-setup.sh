#!/usr/bin/env bash
# event_log_track_webform introspection SETUP: insert one known 'webform_submission' sentinel row. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::database()->delete("event_log_track")->condition("ref_char","ELT_WEBFORM_MED")->execute();
  \Drupal::database()->insert("event_log_track")->fields([
    "type"=>"webform_submission","operation"=>"insert","description"=>"ELT_WEBFORM_DESC","path"=>"/elt-webform",
    "ref_numeric"=>101,"ref_char"=>"ELT_WEBFORM_MED","uid"=>1,"ip"=>"127.0.0.1","created"=>\Drupal::time()->getRequestTime(),
  ])->execute();
' >/dev/null 2>&1
echo "setup: event_log_track webform_submission row (ref_char=ELT_WEBFORM_MED, operation=insert, description=ELT_WEBFORM_DESC)"

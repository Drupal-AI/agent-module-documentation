#!/usr/bin/env bash
# event_log_track_taxonomy introspection SETUP: insert one known 'taxonomy' sentinel row. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::database()->delete("event_log_track")->condition("ref_char","ELT_TAX_MED")->execute();
  \Drupal::database()->insert("event_log_track")->fields([
    "type"=>"taxonomy","operation"=>"term insert","description"=>"ELT_TAX_DESC","path"=>"/elt-tax",
    "ref_numeric"=>101,"ref_char"=>"ELT_TAX_MED","uid"=>1,"ip"=>"127.0.0.1","created"=>\Drupal::time()->getRequestTime(),
  ])->execute();
' >/dev/null 2>&1
echo "setup: event_log_track taxonomy row (ref_char=ELT_TAX_MED, operation=term insert, description=ELT_TAX_DESC)"

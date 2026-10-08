#!/usr/bin/env bash
# event_log_track_group_membership introspection SETUP: insert one known 'group_membership' sentinel row. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::database()->delete("event_log_track")->condition("ref_char","ELT_GMEMBER_MED")->execute();
  \Drupal::database()->insert("event_log_track")->fields([
    "type"=>"group_membership","operation"=>"insert","description"=>"ELT_GMEMBER_DESC","path"=>"/elt-gmember",
    "ref_numeric"=>101,"ref_char"=>"ELT_GMEMBER_MED","uid"=>1,"ip"=>"127.0.0.1","created"=>\Drupal::time()->getRequestTime(),
  ])->execute();
' >/dev/null 2>&1
echo "setup: event_log_track group_membership row (ref_char=ELT_GMEMBER_MED, operation=insert, description=ELT_GMEMBER_DESC)"

#!/usr/bin/env bash
# event_log_track_menu introspection SETUP: insert one known 'menu' sentinel row. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::database()->delete("event_log_track")->condition("ref_char","ELT_MENU_MED")->execute();
  \Drupal::database()->insert("event_log_track")->fields([
    "type"=>"menu","operation"=>"insert","description"=>"ELT_MENU_DESC","path"=>"/elt-menu",
    "ref_numeric"=>101,"ref_char"=>"ELT_MENU_MED","uid"=>1,"ip"=>"127.0.0.1","created"=>\Drupal::time()->getRequestTime(),
  ])->execute();
' >/dev/null 2>&1
echo "setup: event_log_track menu row (ref_char=ELT_MENU_MED, operation=insert, description=ELT_MENU_DESC)"

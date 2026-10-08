#!/usr/bin/env bash
# event_log_track_config introspection SETUP: insert one known 'config' sentinel row. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::database()->delete("event_log_track")->condition("ref_char","ELT_CONFIG_MED")->execute();
  \Drupal::database()->insert("event_log_track")->fields([
    "type"=>"config","operation"=>"save","description"=>"ELT_CONFIG_DESC","path"=>"/elt-config",
    "ref_numeric"=>101,"ref_char"=>"ELT_CONFIG_MED","uid"=>1,"ip"=>"127.0.0.1","created"=>\Drupal::time()->getRequestTime(),
  ])->execute();
' >/dev/null 2>&1
echo "setup: event_log_track config row (ref_char=ELT_CONFIG_MED, operation=save, description=ELT_CONFIG_DESC)"

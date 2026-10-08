#!/usr/bin/env bash
# event_log_track_masquerade introspection SETUP: insert one known 'masquerade' sentinel row. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::database()->delete("event_log_track")->condition("ref_char","ELT_MASQ_MED")->execute();
  \Drupal::database()->insert("event_log_track")->fields([
    "type"=>"masquerade","operation"=>"masquerade","description"=>"ELT_MASQ_DESC","path"=>"/elt-masq",
    "ref_numeric"=>101,"ref_char"=>"ELT_MASQ_MED","uid"=>1,"ip"=>"127.0.0.1","created"=>\Drupal::time()->getRequestTime(),
  ])->execute();
' >/dev/null 2>&1
echo "setup: event_log_track masquerade row (ref_char=ELT_MASQ_MED, operation=masquerade, description=ELT_MASQ_DESC)"

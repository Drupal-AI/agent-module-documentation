#!/usr/bin/env bash
# event_log_track_node introspection SETUP: insert one known 'node' sentinel row. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::database()->delete("event_log_track")->condition("ref_char","ELT_NODE_MED")->execute();
  \Drupal::database()->insert("event_log_track")->fields([
    "type"=>"node","operation"=>"insert","description"=>"ELT_NODE_DESC","path"=>"/elt-node",
    "ref_numeric"=>101,"ref_char"=>"ELT_NODE_MED","uid"=>1,"ip"=>"127.0.0.1","created"=>\Drupal::time()->getRequestTime(),
  ])->execute();
' >/dev/null 2>&1
echo "setup: event_log_track node row (ref_char=ELT_NODE_MED, operation=insert, description=ELT_NODE_DESC)"

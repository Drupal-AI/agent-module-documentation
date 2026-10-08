#!/usr/bin/env bash
# event_log_track_workflows introspection SETUP: insert one known 'workflows' sentinel row. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::database()->delete("event_log_track")->condition("ref_char","ELT_WORKFLOW_MED")->execute();
  \Drupal::database()->insert("event_log_track")->fields([
    "type"=>"workflows","operation"=>"insert","description"=>"ELT_WORKFLOW_DESC","path"=>"/elt-workflow",
    "ref_numeric"=>101,"ref_char"=>"ELT_WORKFLOW_MED","uid"=>1,"ip"=>"127.0.0.1","created"=>\Drupal::time()->getRequestTime(),
  ])->execute();
' >/dev/null 2>&1
echo "setup: event_log_track workflows row (ref_char=ELT_WORKFLOW_MED, operation=insert, description=ELT_WORKFLOW_DESC)"

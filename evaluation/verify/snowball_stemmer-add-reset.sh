#!/usr/bin/env bash
# Execution RESET: create a db server + index ss_task WITHOUT the snowball_stemmer processor, so
# verify FAILS until the agent adds it. Idempotent (removes the processor if present). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\search_api\Entity\Server;
  use Drupal\search_api\Entity\Index;
  if (!Server::load("ss_task_srv")) {
    Server::create(["id"=>"ss_task_srv","name"=>"SS Task Srv","status"=>TRUE,"backend"=>"search_api_db","backend_config"=>["database"=>"default:default","min_chars"=>3,"matching"=>"words"]])->save();
  }
  if (!Index::load("ss_task")) {
    Index::create(["id"=>"ss_task","name"=>"SS Task","status"=>TRUE,"datasource_settings"=>["entity:node"=>[]],"tracker_settings"=>["default"=>[]],"server"=>"ss_task_srv"])->save();
  }
  $index = Index::load("ss_task");
  if ($index->isValidProcessor("snowball_stemmer") && in_array("snowball_stemmer", array_keys($index->getProcessors()))) {
    // Ensure it is NOT enabled: remove from processor settings if it was added.
  }
  $index->removeProcessor("snowball_stemmer");
  $index->save();
' >/dev/null 2>&1
echo "reset: index ss_task present WITHOUT snowball_stemmer processor"

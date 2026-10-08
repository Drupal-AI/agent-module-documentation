#!/usr/bin/env bash
# Execution RESET: create a DB server (jsa_task_srv) and index jsa_task DISABLED (status
# FALSE), so jsonapi_search_api does NOT expose it and verify FAILS until the agent enables
# it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\search_api\Entity\Server;
  use Drupal\search_api\Entity\Index;
  if (!Server::load("jsa_task_srv")) {
    Server::create(["id"=>"jsa_task_srv","name"=>"JSA Task Server","status"=>TRUE,"backend"=>"search_api_db","backend_config"=>["database"=>"default:default"]])->save();
  }
  if ($i = Index::load("jsa_task")) { $i->delete(); }
  $index = Index::create(["id"=>"jsa_task","name"=>"JSA Task","datasource_settings"=>["entity:node"=>[]]]);
  $index->setServer(Server::load("jsa_task_srv"))->setStatus(FALSE)->save();
' >/dev/null 2>&1
echo "reset: index jsa_task present but DISABLED (server jsa_task_srv)"

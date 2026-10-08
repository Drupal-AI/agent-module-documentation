#!/usr/bin/env bash
# Introspection SETUP: create a DB-backed Search API server (jsa_known_srv) and an ENABLED
# index (jsa_known, datasource entity:node) so jsonapi_search_api exposes it at
# /jsonapi/index/jsa_known. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\search_api\Entity\Server;
  use Drupal\search_api\Entity\Index;
  if (!Server::load("jsa_known_srv")) {
    Server::create(["id"=>"jsa_known_srv","name"=>"JSA Known Server","status"=>TRUE,"backend"=>"search_api_db","backend_config"=>["database"=>"default:default"]])->save();
  }
  if ($i = Index::load("jsa_known")) { $i->delete(); }
  $index = Index::create(["id"=>"jsa_known","name"=>"JSA Known","datasource_settings"=>["entity:node"=>[]]]);
  $index->setServer(Server::load("jsa_known_srv"))->setStatus(TRUE)->save();
' >/dev/null 2>&1
echo "setup: enabled index jsa_known on DB server jsa_known_srv -> /jsonapi/index/jsa_known"

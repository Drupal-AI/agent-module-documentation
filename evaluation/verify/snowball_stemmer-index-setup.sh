#!/usr/bin/env bash
# Introspection SETUP: create a Search API db server + index ss_known with the snowball_stemmer
# processor enabled and a distinctive stemming exception (drupaling => drupal). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\search_api\Entity\Server;
  use Drupal\search_api\Entity\Index;
  if (!Server::load("ss_known_srv")) {
    Server::create(["id"=>"ss_known_srv","name"=>"SS Known Srv","status"=>TRUE,"backend"=>"search_api_db","backend_config"=>["database"=>"default:default","min_chars"=>3,"matching"=>"words"]])->save();
  }
  if (!Index::load("ss_known")) {
    Index::create(["id"=>"ss_known","name"=>"SS Known","status"=>TRUE,"datasource_settings"=>["entity:node"=>[]],"tracker_settings"=>["default"=>[]],"server"=>"ss_known_srv"])->save();
  }
  $index = Index::load("ss_known");
  $index->addProcessor(\Drupal::service("plugin.manager.search_api.processor")->createInstance("snowball_stemmer",["exceptions"=>["drupaling"=>"drupal"]]));
  $index->save();
' >/dev/null 2>&1
echo "setup: index ss_known has snowball_stemmer processor with exception drupaling=>drupal"

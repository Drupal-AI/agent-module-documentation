#!/usr/bin/env bash
# Execution RESET: create a db server + index ss_exc WITH the snowball_stemmer processor enabled
# but with NO stemming exceptions, so verify FAILS until the agent adds the exception. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\search_api\Entity\Server;
  use Drupal\search_api\Entity\Index;
  if (!Server::load("ss_exc_srv")) {
    Server::create(["id"=>"ss_exc_srv","name"=>"SS Exc Srv","status"=>TRUE,"backend"=>"search_api_db","backend_config"=>["database"=>"default:default","min_chars"=>3,"matching"=>"words"]])->save();
  }
  if (!Index::load("ss_exc")) {
    Index::create(["id"=>"ss_exc","name"=>"SS Exc","status"=>TRUE,"datasource_settings"=>["entity:node"=>[]],"tracker_settings"=>["default"=>[]],"server"=>"ss_exc_srv"])->save();
  }
  $index = Index::load("ss_exc");
  $index->removeProcessor("snowball_stemmer");
  $index->addProcessor(\Drupal::service("plugin.manager.search_api.processor")->createInstance("snowball_stemmer",["exceptions"=>[]]));
  $index->save();
' >/dev/null 2>&1
echo "reset: index ss_exc has snowball_stemmer processor with EMPTY exceptions"

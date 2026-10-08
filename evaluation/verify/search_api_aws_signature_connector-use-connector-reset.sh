#!/usr/bin/env bash
# Execution RESET: (re)create server saws_task on the opensearch backend using the STANDARD
# connector, so verify FAILS until the agent switches it to the aws_signature connector.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\search_api\Entity\Server; if($s=Server::load("saws_task")){$s->delete();}' >/dev/null 2>&1
drush php:eval '
  use Drupal\search_api\Entity\Server;
  Server::create([
    "id"=>"saws_task","name"=>"AWS task","status"=>TRUE,"backend"=>"opensearch",
    "backend_config"=>[
      "connector"=>"standard",
      "connector_config"=>["url"=>"https://search-mydomain.eu-west-1.es.amazonaws.com","ssl_verification"=>TRUE],
      "advanced"=>["fuzziness"=>"auto","prefix"=>"","synonyms"=>[]],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: search_api.server saws_task uses standard connector"

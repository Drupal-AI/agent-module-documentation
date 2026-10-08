#!/usr/bin/env bash
# Execution RESET: create/replace server sao_switch using the opensearch backend with the
# STANDARD (no-auth) connector, so verify FAILS until the agent switches it to basic auth.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\search_api\Entity\Server;
  if ($s = Server::load("sao_switch")) { $s->delete(); }
' >/dev/null 2>&1
drush php:eval '
  use Drupal\search_api\Entity\Server;
  Server::create([
    "id"=>"sao_switch","name"=>"SAO switch","status"=>TRUE,"backend"=>"opensearch",
    "backend_config"=>[
      "connector"=>"standard",
      "connector_config"=>["url"=>"https://os.example.com:9200","ssl_verification"=>TRUE],
      "advanced"=>["fuzziness"=>"auto","prefix"=>"","synonyms"=>[]],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: search_api.server sao_switch uses standard connector"

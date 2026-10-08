#!/usr/bin/env bash
# Introspection SETUP: create a Search API server using the OpenSearch backend with a known
# connector (basicauth) and cluster URL, so an agent can read the server's backend_config.
# Config only - no live OpenSearch cluster is contacted.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\search_api\Entity\Server;
  if (!Server::load("sao_med_conn")) {
    Server::create([
      "id"=>"sao_med_conn","name"=>"SAO medium connector","status"=>TRUE,"backend"=>"opensearch",
      "backend_config"=>[
        "connector"=>"basicauth",
        "connector_config"=>["url"=>"https://os-medium.example.com:9200","ssl_verification"=>TRUE,"username"=>"searchuser","password"=>"secret"],
        "advanced"=>["fuzziness"=>"auto","prefix"=>"","synonyms"=>[]],
      ],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: search_api.server sao_med_conn opensearch/basicauth url=https://os-medium.example.com:9200"

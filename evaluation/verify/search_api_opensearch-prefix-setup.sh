#!/usr/bin/env bash
# Introspection SETUP: create an OpenSearch-backed Search API server with a known index prefix in
# its advanced settings, so an agent can read backend_config.advanced.prefix. Config only.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\search_api\Entity\Server;
  if (!Server::load("sao_med_prefix")) {
    Server::create([
      "id"=>"sao_med_prefix","name"=>"SAO medium prefix","status"=>TRUE,"backend"=>"opensearch",
      "backend_config"=>[
        "connector"=>"standard",
        "connector_config"=>["url"=>"https://os.example.com:9200","ssl_verification"=>TRUE],
        "advanced"=>["fuzziness"=>"auto","prefix"=>"sao_med_","synonyms"=>[]],
      ],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: search_api.server sao_med_prefix advanced.prefix=sao_med_"

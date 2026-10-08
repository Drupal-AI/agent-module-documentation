#!/usr/bin/env bash
# Introspection SETUP: create an OpenSearch-backed Search API server that uses the aws_signature
# connector with a known AWS region, so an agent can read connector_config.aws_region. Config only.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\search_api\Entity\Server;
  if (!Server::load("saws_med")) {
    Server::create([
      "id"=>"saws_med","name"=>"AWS medium","status"=>TRUE,"backend"=>"opensearch",
      "backend_config"=>[
        "connector"=>"aws_signature",
        "connector_config"=>["url"=>"https://search-mydomain.eu-west-1.es.amazonaws.com","ssl_verification"=>TRUE,"api_key"=>"","api_secret"=>"","aws_region"=>"eu-west-1"],
        "advanced"=>["fuzziness"=>"auto","prefix"=>"","synonyms"=>[]],
      ],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: search_api.server saws_med aws_signature aws_region=eu-west-1"

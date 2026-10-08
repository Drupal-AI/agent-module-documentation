#!/usr/bin/env bash
# Introspection SETUP: write a known search_api.server config entity, ec_hosted, using the
# elasticsearch backend with the 'elastic_cloud_id' connector and a distinctive Elastic Cloud
# ID, so an inspecting agent can read back which connector/Cloud ID it uses. Written as RAW
# CONFIG (configFactory) - never via Server::create()->save() or any live backend call.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("search_api.server.ec_hosted")->setData([
    "langcode" => "en",
    "status" => TRUE,
    "dependencies" => ["module" => ["elasticsearch_connector"]],
    "id" => "ec_hosted",
    "name" => "EC Hosted Server",
    "description" => "Introspection fixture for elasticsearch_connector evals.",
    "backend" => "elasticsearch",
    "backend_config" => [
      "connector" => "elastic_cloud_id",
      "connector_config" => [
        "elastic_cloud_id" => "ec-eval-deployment:ZXhhbXBsZWNsb3VkaWQ=",
        "api_key_id" => "ec_hosted_test_key",
        "enable_debug_logging" => FALSE,
      ],
      "advanced" => [
        "fuzziness" => "auto",
        "prefix" => "",
        "suffix" => "",
        "synonyms" => [],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: search_api.server.ec_hosted backend=elasticsearch connector=elastic_cloud_id elastic_cloud_id=ec-eval-deployment:ZXhhbXBsZWNsb3VkaWQ="

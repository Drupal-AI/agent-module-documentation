#!/usr/bin/env bash
# Introspection SETUP: write a known search_api.server config entity, ec_known, using the
# elasticsearch backend with the 'standard' connector and a distinctive URL, so an inspecting
# agent can read back which connector/URL it uses. Written as RAW CONFIG (configFactory) -
# never via Server::create()->save() or any live backend call. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("search_api.server.ec_known")->setData([
    "langcode" => "en",
    "status" => TRUE,
    "dependencies" => ["module" => ["elasticsearch_connector"]],
    "id" => "ec_known",
    "name" => "EC Known Server",
    "description" => "Introspection fixture for elasticsearch_connector evals.",
    "backend" => "elasticsearch",
    "backend_config" => [
      "connector" => "standard",
      "connector_config" => [
        "url" => "http://localhost:9243",
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
echo "setup: search_api.server.ec_known backend=elasticsearch connector=standard url=http://localhost:9243"

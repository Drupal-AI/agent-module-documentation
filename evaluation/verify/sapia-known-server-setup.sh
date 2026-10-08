#!/usr/bin/env bash
# Introspection SETUP: create a Search API server sapia_known using the Algolia backend with a
# known Application ID (dummy credentials; no connection is made on save). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\search_api\Entity\Server;
  if (!Server::load("sapia_known")) {
    Server::create([
      "id" => "sapia_known", "name" => "SAPIA Known", "status" => TRUE,
      "backend" => "search_api_algolia",
      "backend_config" => [
        "application_id" => "APPID_KNOWN_123",
        "api_key" => "KEY_KNOWN_123",
        "disable_truncate" => FALSE,
      ],
    ])->save();
  }
' >/dev/null 2>&1
echo "setup: server sapia_known (search_api_algolia, app APPID_KNOWN_123)"

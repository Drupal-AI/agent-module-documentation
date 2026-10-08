#!/usr/bin/env bash
# Execution VERIFY for "build a search_api.server ec_cloud on the elasticsearch backend using an
# authenticated connector". PASS when search_api.server.ec_cloud exists with
# backend=='elasticsearch' AND EITHER (backend_config.connector=='basicauth' with a non-empty
# username) OR (backend_config.connector=='elastic_cloud_id' with a non-empty elastic_cloud_id).
# Reads config only - never calls the backend/connector. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $config = \Drupal::config("search_api.server.ec_cloud");
  $backend = $config->get("backend");
  $connector = $config->get("backend_config.connector");
  $username = $config->get("backend_config.connector_config.username");
  $cloud_id = $config->get("backend_config.connector_config.elastic_cloud_id");
  $ok = ($backend === "elasticsearch") && (
    ($connector === "basicauth" && !empty($username)) ||
    ($connector === "elastic_cloud_id" && !empty($cloud_id))
  );
  print ($ok ? "PASS" : "FAIL") . " backend=" . var_export($backend, TRUE) . " connector=" . var_export($connector, TRUE) . " username=" . var_export($username, TRUE) . " elastic_cloud_id=" . var_export($cloud_id, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

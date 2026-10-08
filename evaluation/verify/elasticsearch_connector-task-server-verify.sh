#!/usr/bin/env bash
# Execution VERIFY for "build a search_api.server ec_task on the elasticsearch backend using
# the standard connector". PASS when search_api.server.ec_task exists with backend=='elasticsearch'
# and backend_config.connector=='standard'. Reads config only - never calls the backend/connector.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $config = \Drupal::config("search_api.server.ec_task");
  $backend = $config->get("backend");
  $connector = $config->get("backend_config.connector");
  $ok = ($backend === "elasticsearch" && $connector === "standard");
  print ($ok ? "PASS" : "FAIL") . " backend=" . var_export($backend, TRUE) . " connector=" . var_export($connector, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

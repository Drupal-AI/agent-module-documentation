#!/usr/bin/env bash
# Execution VERIFY: PASS when a Search API server sapia_server exists using the search_api_algolia
# backend with backend_config.application_id === 'APPID_TASK'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\search_api\Entity\Server;
  $s = Server::load("sapia_server");
  $backend = $s ? $s->getBackendId() : NULL;
  $app = $s ? ($s->getBackendConfig()["application_id"] ?? NULL) : NULL;
  $ok = ($s && $backend === "search_api_algolia" && $app === "APPID_TASK");
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($s ? "yes" : "no") . " backend=" . var_export($backend, TRUE) . " app=" . var_export($app, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

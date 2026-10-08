#!/usr/bin/env bash
# HARD execution verify: an Acquia Search Solr server config entity 'acquia_search_server'
# must exist, wired to the Acquia Solr connector. Prints PASS/FAIL, exits 0 (pass) / 1 (fail).
# Reads config (not the loaded entity) so the module's runtime load hooks — which may disable
# the server or rewrite its backend when no live Acquia subscription is present — don't skew
# the check. Accepts either the default backend+connector (search_api_solr / solr_acquia_connector)
# or the module's own acquia_search_solr backend.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $c = \Drupal::config("search_api.server.acquia_search_server");
  $exists = ($c->get("id") === "acquia_search_server");
  $backend = (string) $c->get("backend");
  $conn = (string) $c->get("backend_config.connector");
  $ok = $exists && ($conn === "solr_acquia_connector" || $backend === "acquia_search_solr");
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($exists?1:0) . " backend=" . $backend . " connector=" . $conn . "\n";
' 2>/dev/null | grep -Ev '^\s*(Deprecated|Warning|Notice):' | grep -E '^(PASS|FAIL)')

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

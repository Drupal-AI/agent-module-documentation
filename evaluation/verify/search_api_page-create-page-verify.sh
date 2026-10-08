#!/usr/bin/env bash
# HARD execution verify: a search_api_page config entity 'site_search' must exist, serve the
# path 'search/site', and be bound to the Search API index 'sap_eval_index' that reset created.
# Prints PASS/FAIL with detail; exits 0 (pass) / 1 (fail). Reads config directly.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $c = \Drupal::config("search_api_page.search_api_page.site_search");
  $exists = ($c->get("id") === "site_search");
  $path = ltrim((string) $c->get("path"), "/");
  $index = (string) $c->get("index");
  $index_ok = ($index === "sap_eval_index")
    && (\Drupal::entityTypeManager()->getStorage("search_api_index")->load($index) !== NULL);
  $path_ok = ($path === "search/site");
  $ok = $exists && $path_ok && $index_ok;
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($exists?1:0) . " path=" . $path . " index=" . $index . "\n";
' 2>/dev/null | grep -Ev '^\s*(Deprecated|Warning|Notice):' | grep -E '^(PASS|FAIL)')

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

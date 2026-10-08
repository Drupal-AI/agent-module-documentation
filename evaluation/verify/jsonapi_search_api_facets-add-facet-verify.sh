#!/usr/bin/env bash
# Execution VERIFY: PASS when facet jsaf_task exists on a jsonapi_search_api_facets source AND
# has been given the jsonapi_search_api widget (by the submodule presave). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\facets\Entity\Facet;
  $f = Facet::load("jsaf_task");
  $src = $f ? $f->getFacetSourceId() : "none";
  $w = $f ? ($f->getWidget()["type"] ?? "none") : "none";
  $ok = ($f && strpos($src, "jsonapi_search_api_facets") === 0 && $w === "jsonapi_search_api");
  print ($ok ? "PASS" : "FAIL") . " source=" . $src . " widget=" . $w . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

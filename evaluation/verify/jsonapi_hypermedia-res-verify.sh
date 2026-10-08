#!/usr/bin/env bash
# Execution VERIFY: PASS when the provider manager has a LinkProvider from module
# 'jsonapi_hypermedia_res' with link_key 'res_action' targeting a resource_object context.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $defs = \Drupal::service("jsonapi_hypermedia_provider.manager")->getDefinitions();
  $ok = FALSE;
  foreach ($defs as $id => $d) {
    if (($d["provider"] ?? "") === "jsonapi_hypermedia_res"
        && ($d["link_key"] ?? "") === "res_action"
        && array_key_exists("resource_object", $d["link_context"] ?? [])) { $ok = TRUE; }
  }
  print ($ok ? "PASS" : "FAIL") . " ids=" . implode(",", array_keys($defs)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

#!/usr/bin/env bash
# Execution VERIFY: PASS when a consumer with client_id sopg_new_client exists AND has the
# password grant enabled in grant_types. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $cs = \Drupal::entityTypeManager()->getStorage("consumer")->loadByProperties(["client_id" => "sopg_new_client"]);
  $c = $cs ? reset($cs) : NULL;
  $grants = $c ? array_column($c->get("grant_types")->getValue(), "value") : [];
  $ok = ($c && in_array("password", $grants, TRUE));
  print ($ok ? "PASS" : "FAIL") . " consumer=" . ($c ? "sopg_new_client" : "missing") . " grants=" . implode("|", $grants) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

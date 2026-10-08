#!/usr/bin/env bash
# Execution VERIFY: PASS when field_ef component has empty_fields.handler=='nbsp'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_ef") : NULL;
  $h = $c["third_party_settings"]["empty_fields"]["handler"] ?? NULL;
  $ok = ($h === "nbsp");
  print ($ok ? "PASS" : "FAIL") . " handler=" . var_export($h, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

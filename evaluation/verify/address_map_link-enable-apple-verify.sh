#!/usr/bin/env bash
# Execution VERIFY: PASS when field_aml_store links to Apple Maps (link_address TRUE and
# map_link_type 'apple_maps'). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_aml_store") : NULL;
  $s = $c["third_party_settings"]["address_map_link"] ?? [];
  $ok = (($s["link_address"] ?? FALSE) === TRUE) && (($s["map_link_type"] ?? "") === "apple_maps");
  print ($ok ? "PASS" : "FAIL")." link=".var_export($s["link_address"] ?? NULL,TRUE)." provider=".($s["map_link_type"] ?? "none")."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

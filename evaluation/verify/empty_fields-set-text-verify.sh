#!/usr/bin/env bash
# Execution VERIFY: PASS when field_ef component has empty_fields.handler=='text' and
# settings.empty_text=='Not provided'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_ef") : NULL;
  $h = $c["third_party_settings"]["empty_fields"]["handler"] ?? NULL;
  $t = $c["third_party_settings"]["empty_fields"]["settings"]["empty_text"] ?? NULL;
  $ok = ($h === "text" && $t === "Not provided");
  print ($ok ? "PASS" : "FAIL") . " handler=" . var_export($h, TRUE) . " empty_text=" . var_export($t, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

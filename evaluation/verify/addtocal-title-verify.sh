#!/usr/bin/env bash
# Execution VERIFY: PASS when field_atc_title uses addtocal_view AND event_title === 'ATC Launch'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_atc_title") : NULL;
  $type = $c["type"] ?? "none";
  $title = $c["settings"]["event_title"] ?? "";
  $ok = ($type === "addtocal_view" && $title === "ATC Launch");
  print ($ok ? "PASS" : "FAIL") . " formatter=" . $type . " event_title=" . var_export($title, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

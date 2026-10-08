#!/usr/bin/env bash
# Execution VERIFY: PASS when field_mtb_task's component in the Article default view display
# uses type media_tableau AND settings.toolbar is truthy. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_mtb_task") : NULL;
  $type = $c["type"] ?? "none";
  $toolbar = $c["settings"]["toolbar"] ?? NULL;
  $ok = ($type === "media_tableau") && (bool) $toolbar;
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " toolbar=" . var_export($toolbar, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

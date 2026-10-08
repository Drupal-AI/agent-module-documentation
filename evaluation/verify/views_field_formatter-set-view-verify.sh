#!/usr/bin/env bash
# Execution VERIFY: PASS when field_vff_task's component in node.article default view display
# uses formatter type 'views_field_formatter' with settings.view referencing the frontpage
# view (starts with "frontpage"). Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_vff_task") : NULL;
  $type = $c["type"] ?? "none";
  $view = $c["settings"]["view"] ?? "";
  $ok = ($type === "views_field_formatter" && strpos((string) $view, "frontpage") === 0);
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " view=" . $view . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

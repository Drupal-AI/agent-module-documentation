#!/usr/bin/env bash
# Execution VERIFY: PASS when field_vff_mult's views_field_formatter settings have
# multiple === TRUE AND implode_character === " | ". Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_vff_mult") : NULL;
  $s = $c["settings"] ?? [];
  $mult = !empty($s["multiple"]);
  $imp = $s["implode_character"] ?? "";
  $ok = (($c["type"] ?? "") === "views_field_formatter" && $mult && $imp === " | ");
  print ($ok ? "PASS" : "FAIL") . " multiple=" . var_export($mult, TRUE) . " implode=" . var_export($imp, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

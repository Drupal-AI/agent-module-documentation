#!/usr/bin/env bash
# Execution VERIFY: PASS when field_ecf_cols's component in
# core.entity_view_display.node.article.default uses entity_class_formatter with
# settings.attr === "data-ecf-columns". Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_ecf_cols") : NULL;
  $type = $c["type"] ?? "none";
  $attr = $c["settings"]["attr"] ?? NULL;
  $ok = ($type === "entity_class_formatter" && $attr === "data-ecf-columns");
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " attr=" . var_export($attr, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

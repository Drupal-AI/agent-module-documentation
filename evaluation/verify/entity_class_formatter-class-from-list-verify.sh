#!/usr/bin/env bash
# Execution VERIFY: PASS when field_ecf_task's component in
# core.entity_view_display.node.article.default uses the entity_class_formatter formatter with
# settings.prefix === "palette-" (and no custom attr, i.e. it writes a CSS class).
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_ecf_task") : NULL;
  $type = $c["type"] ?? "none";
  $prefix = $c["settings"]["prefix"] ?? NULL;
  $attr = $c["settings"]["attr"] ?? "";
  $ok = ($type === "entity_class_formatter" && $prefix === "palette-" && ($attr === "" || $attr === "class"));
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " prefix=" . var_export($prefix, TRUE) . " attr=" . var_export($attr, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

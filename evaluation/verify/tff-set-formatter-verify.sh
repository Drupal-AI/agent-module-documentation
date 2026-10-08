#!/usr/bin/env bash
# Execution VERIFY: PASS when field_tff_task uses text_field_formatter with wrap_tag 'div' and
# wrap_class containing 'callout'. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_tff_task") : NULL;
  $type = $c["type"] ?? "none";
  $tag = $c["settings"]["wrap_tag"] ?? "";
  $class = (string) ($c["settings"]["wrap_class"] ?? "");
  $ok = ($type === "text_field_formatter") && ($tag === "div") && (strpos($class, "callout") !== FALSE);
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " wrap_tag=" . $tag . " wrap_class=" . $class . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

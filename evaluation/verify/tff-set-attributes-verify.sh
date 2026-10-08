#!/usr/bin/env bash
# Execution VERIFY: PASS when field_tff_task2 uses text_field_formatter with wrap_tag 'span' and
# wrap_attributes containing 'data-role|note'. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_tff_task2") : NULL;
  $type = $c["type"] ?? "none";
  $tag = $c["settings"]["wrap_tag"] ?? "";
  $attrs = (string) ($c["settings"]["wrap_attributes"] ?? "");
  $ok = ($type === "text_field_formatter") && ($tag === "span") && (strpos($attrs, "data-role|note") !== FALSE);
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " wrap_tag=" . $tag . " wrap_attributes=" . str_replace("\n", "\\n", $attrs) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

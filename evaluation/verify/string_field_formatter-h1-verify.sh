#!/usr/bin/env bash
# Execution VERIFY: PASS when field_sff_head uses plain_string_formatter with wrap_tag=h1.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_sff_head") : NULL;
  $type = $c["type"] ?? "none";
  $tag = $c["settings"]["wrap_tag"] ?? "";
  $ok = ($type === "plain_string_formatter" && $tag === "h1");
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " wrap_tag=" . var_export($tag, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

#!/usr/bin/env bash
# Execution VERIFY: PASS when field_hdg_fmt's default display component uses the heading_text
# formatter. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_hdg_fmt") : NULL;
  $type = $c["type"] ?? "none";
  $ok = ($type === "heading_text");
  print ($ok ? "PASS" : "FAIL") . " formatter=" . $type . " size=" . ($c["settings"]["size"] ?? "-") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

#!/usr/bin/env bash
# Execution VERIFY: PASS when field_taw_task component widget type === string_textarea. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_taw_task") : NULL;
  $t = $c["type"] ?? "none";
  $ok = ($t === "string_textarea");
  print ($ok ? "PASS" : "FAIL") . " widget=" . $t . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

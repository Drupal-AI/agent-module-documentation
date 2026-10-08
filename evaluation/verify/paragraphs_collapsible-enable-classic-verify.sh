#!/usr/bin/env bash
# Execution VERIFY: PASS when field_pgc_task on node.article.default uses the classic
# entity_reference_paragraphs widget (the one paragraphs_collapsible enhances). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_pgc_task") : NULL;
  $type = $c["type"] ?? "none";
  $ok = ($type === "entity_reference_paragraphs");
  print ($ok ? "PASS" : "FAIL") . " widget=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

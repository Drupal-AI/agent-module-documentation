#!/usr/bin/env bash
# hard VERIFY (entity_reference_tree): PASS when field_ert_task's form-display widget is
# entity_reference_tree. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_ert_task") : NULL;
  $type = $c["type"] ?? "none";
  $ok = ($type === "entity_reference_tree");
  print ($ok ? "PASS" : "FAIL") . " widget=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

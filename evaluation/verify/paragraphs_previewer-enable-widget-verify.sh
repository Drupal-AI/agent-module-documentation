#!/usr/bin/env bash
# Execution VERIFY: PASS when field_pp_task on core.entity_form_display.node.article.default
# uses one of the paragraphs_previewer widgets (the correct id is paragraphs_previewer; the
# deprecated paragraphs_previwer and the legacy entity_reference_paragraphs_previewer also
# provide the previewer). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_pp_task") : NULL;
  $type = $c["type"] ?? "none";
  $ok = in_array($type, ["paragraphs_previewer", "entity_reference_paragraphs_previewer", "paragraphs_previwer"], TRUE);
  print ($ok ? "PASS" : "FAIL") . " widget=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

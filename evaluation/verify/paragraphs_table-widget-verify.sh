#!/usr/bin/env bash
# Execution VERIFY: PASS when the Article default FORM display edits field_pt_evh with the
# paragraphs_table_widget. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $d = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $d ? $d->getComponent("field_pt_evh") : NULL;
  $type = $c["type"] ?? "none";
  print (($type === "paragraphs_table_widget") ? "PASS" : "FAIL") . " type=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

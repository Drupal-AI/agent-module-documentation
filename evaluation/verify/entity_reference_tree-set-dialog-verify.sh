#!/usr/bin/env bash
# hard VERIFY (entity_reference_tree): PASS when field_ert_dialog uses the tree widget AND its
# dialog_title setting === 'Select items'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_ert_dialog") : NULL;
  $type = $c["type"] ?? "none";
  $title = $c["settings"]["dialog_title"] ?? NULL;
  $ok = ($type === "entity_reference_tree" && $title === "Select items");
  print ($ok ? "PASS" : "FAIL") . " widget=" . $type . " dialog_title=" . var_export($title, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

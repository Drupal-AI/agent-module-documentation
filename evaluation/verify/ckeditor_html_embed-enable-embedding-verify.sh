#!/usr/bin/env bash
# Execution VERIFY: PASS when 'htmlEmbed' is in the chte_hard2 CKEditor 5 toolbar items.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $items = \Drupal::config("editor.editor.chte_hard2")->get("settings.toolbar.items") ?: [];
  $ok = in_array("htmlEmbed", $items, TRUE);
  print ($ok ? "PASS" : "FAIL") . " items=" . implode(",", $items) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

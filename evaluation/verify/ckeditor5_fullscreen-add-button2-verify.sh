#!/usr/bin/env bash
# Execution VERIFY for "add the Fullscreen button to ck5fs_task2's CKEditor5 toolbar".
# PASS when editor.editor.ck5fs_task2 settings.toolbar.items contains "Fullscreen".
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ed = \Drupal::entityTypeManager()->getStorage("editor")->load("ck5fs_task2");
  $items = $ed ? ($ed->getSettings()["toolbar"]["items"] ?? []) : [];
  $ok = in_array("Fullscreen", $items, TRUE);
  print ($ok ? "PASS" : "FAIL") . " items=" . implode(",", $items) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

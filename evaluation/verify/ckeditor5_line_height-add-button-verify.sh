#!/usr/bin/env bash
# Execution VERIFY: PASS when the clh_task CKEditor 5 toolbar contains the 'lineHeight' item.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\editor\Entity\Editor;
  $ed = Editor::load("clh_task");
  $items = $ed ? ($ed->getSettings()["toolbar"]["items"] ?? []) : [];
  $ok = in_array("lineHeight", $items, TRUE);
  print ($ok ? "PASS" : "FAIL") . " items=" . implode(",", $items) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

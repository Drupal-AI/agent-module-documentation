#!/usr/bin/env bash
# Execution VERIFY: PASS when editor.editor.crt_hard toolbar items include customTable.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal\editor\Entity\Editor::load("crt_hard");
  $items = $e ? ($e->getSettings()["toolbar"]["items"] ?? []) : [];
  $ok = in_array("customTable", $items, TRUE);
  print ($ok ? "PASS" : "FAIL") . " items=" . implode(",", $items) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

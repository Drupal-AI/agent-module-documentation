#!/usr/bin/env bash
# Execution VERIFY: PASS when the ckabbr_task CKEditor 5 editor toolbar contains the
# 'abbreviation' toolbar item. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\editor\Entity\Editor;
  $e = Editor::load("ckabbr_task");
  $items = $e ? ($e->getSettings()["toolbar"]["items"] ?? []) : [];
  $ok = in_array("abbreviation", $items, TRUE);
  print ($ok ? "PASS" : "FAIL") . " items=" . implode(",", $items) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

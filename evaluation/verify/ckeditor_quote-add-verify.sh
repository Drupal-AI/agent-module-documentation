#!/usr/bin/env bash
# Execution VERIFY: PASS when the ckq_task CKEditor 5 editor toolbar includes the ckeditor_quote
# "Quote" item. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\editor\Entity\Editor;
  $e = Editor::load("ckq_task");
  $items = ($e && $e->getEditor() === "ckeditor5") ? ($e->getSettings()["toolbar"]["items"] ?? []) : [];
  $ok = in_array("Quote", $items, TRUE);
  print ($ok ? "PASS" : "FAIL") . " items=" . implode(",", $items) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

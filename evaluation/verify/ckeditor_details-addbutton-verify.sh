#!/usr/bin/env bash
# Execution VERIFY: PASS when CKEditor5 format ckd_task's toolbar includes the 'detail' accordion item. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\editor\Entity\Editor;
  $e = Editor::load("ckd_task");
  $items = ($e && $e->getEditor()==="ckeditor5") ? ($e->getSettings()["toolbar"]["items"] ?? []) : [];
  $ok = in_array("detail", $items, TRUE);
  print ($ok ? "PASS" : "FAIL") . " editor=" . ($e?$e->getEditor():"none") . " items=[" . implode(",", $items) . "]";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

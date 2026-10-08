#!/usr/bin/env bash
# Execution VERIFY: PASS when a text format ckd_new exists using CKEditor 5 with the 'detail' accordion
# button in its toolbar. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  $f = FilterFormat::load("ckd_new");
  $e = Editor::load("ckd_new");
  $items = ($e && $e->getEditor()==="ckeditor5") ? ($e->getSettings()["toolbar"]["items"] ?? []) : [];
  $ok = ($f && $e && $e->getEditor()==="ckeditor5" && in_array("detail", $items, TRUE));
  print ($ok ? "PASS" : "FAIL") . " format=" . ($f?"yes":"no") . " editor=" . ($e?$e->getEditor():"none") . " detail=" . (in_array("detail",$items,TRUE)?"yes":"no");
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

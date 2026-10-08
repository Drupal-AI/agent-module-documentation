#!/usr/bin/env bash
# Execution VERIFY: PASS when text format ckq_new exists, uses the CKEditor 5 editor, and its
# toolbar includes the ckeditor_quote "Quote" item. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  $f = FilterFormat::load("ckq_new");
  $e = Editor::load("ckq_new");
  $items = ($e && $e->getEditor() === "ckeditor5") ? ($e->getSettings()["toolbar"]["items"] ?? []) : [];
  $ok = $f && $e && in_array("Quote", $items, TRUE);
  print ($ok ? "PASS" : "FAIL") . " format=" . ($f ? "yes" : "no") . " editor=" . ($e ? $e->getEditor() : "no") . " items=" . implode(",", $items) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

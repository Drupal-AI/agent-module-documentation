#!/usr/bin/env bash
# Execution VERIFY: PASS when the ckeditor_bidi_h1 editor's CKEditor 5 toolbar contains the
# 'direction' item. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\editor\Entity\Editor;
  $ed = Editor::load("ckeditor_bidi_h1");
  $items = $ed ? ($ed->getSettings()["toolbar"]["items"] ?? []) : [];
  $ok = in_array("direction", $items, TRUE);
  print ($ok ? "PASS" : "FAIL") . " items=" . implode(",", $items) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

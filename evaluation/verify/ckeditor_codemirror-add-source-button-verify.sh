#!/usr/bin/env bash
# Execution VERIFY for "add the Source button to ckeditor_codemirror_nosrc and turn on
# CodeMirror highlighting in PHP mode with code folding".
# PASS when settings.toolbar.items contains 'sourceEditing' AND
#   settings.plugins.ckeditor_codemirror_source_editing has enable === TRUE,
#   mode === 'application/x-httpd-php' and options.folding === TRUE.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal\editor\Entity\Editor::load("ckeditor_codemirror_nosrc");
  $s = $e ? $e->getSettings() : [];
  $items = $s["toolbar"]["items"] ?? [];
  $cm = $s["plugins"]["ckeditor_codemirror_source_editing"] ?? [];
  $src = in_array("sourceEditing", $items, TRUE);
  $enable = $cm["enable"] ?? NULL;
  $mode = $cm["mode"] ?? NULL;
  $fold = $cm["options"]["folding"] ?? NULL;
  $ok = $src && ($enable === TRUE || $enable === 1) && $mode === "application/x-httpd-php" && ($fold === TRUE || $fold === 1);
  print ($ok ? "PASS" : "FAIL")
    . " sourceEditing=" . var_export($src, TRUE)
    . " enable=" . var_export($enable, TRUE)
    . " mode=" . var_export($mode, TRUE)
    . " folding=" . var_export($fold, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

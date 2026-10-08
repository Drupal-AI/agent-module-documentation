#!/usr/bin/env bash
# Execution VERIFY for "enable CodeMirror in SCSS mode with line numbers on the
# ckeditor_codemirror_task text format".
# PASS when editor.editor.ckeditor_codemirror_task ->
#   settings.plugins.ckeditor_codemirror_source_editing has enable === TRUE,
#   mode === 'text/x-scss' and options.lineNumbers === TRUE.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal\editor\Entity\Editor::load("ckeditor_codemirror_task");
  $s = $e ? $e->getSettings() : [];
  $cm = $s["plugins"]["ckeditor_codemirror_source_editing"] ?? [];
  $enable = $cm["enable"] ?? NULL;
  $mode = $cm["mode"] ?? NULL;
  $lines = $cm["options"]["lineNumbers"] ?? NULL;
  $ok = ($enable === TRUE || $enable === 1) && $mode === "text/x-scss" && ($lines === TRUE || $lines === 1);
  print ($ok ? "PASS" : "FAIL")
    . " enable=" . var_export($enable, TRUE)
    . " mode=" . var_export($mode, TRUE)
    . " lineNumbers=" . var_export($lines, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

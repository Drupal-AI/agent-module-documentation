#!/usr/bin/env bash
# Execution VERIFY (canvas_full_html H2): PASS when the 'code' inline-code button has been
# added to the canvas_full_html CKEditor 5 editor toolbar. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
has="$(drush php:eval '
$items = \Drupal::config("editor.editor.canvas_full_html")->get("settings.toolbar.items") ?: [];
echo in_array("code", $items, TRUE) ? "yes" : "no";
' 2>/dev/null | tr -d '[:space:]')"
if [ "$has" = "yes" ]; then
  echo "PASS: 'code' is present in editor.editor.canvas_full_html toolbar items"
  exit 0
fi
echo "FAIL: 'code' button not found in canvas_full_html toolbar items"
exit 1

#!/usr/bin/env bash
# Execution RESET (canvas_full_html H2): restore the canvas_full_html CKEditor 5 toolbar to
# its shipped default (no 'code' button), so verify FAILS on baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
$c = \Drupal::configFactory()->getEditable("editor.editor.canvas_full_html");
$c->set("settings.toolbar.items", ["heading","|","bold","italic","underline","strikethrough","superscript","subscript","removeFormat","|","link","bulletedList","numberedList","blockQuote","horizontalLine","|","sourceEditing"]);
$c->save();
' >/dev/null 2>&1
echo "reset: canvas_full_html editor toolbar restored to shipped default (no code button)"

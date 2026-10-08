#!/usr/bin/env bash
# Execution CLEANUP (canvas_full_html H2): restore shipped default toolbar (no code). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
$c = \Drupal::configFactory()->getEditable("editor.editor.canvas_full_html");
$c->set("settings.toolbar.items", ["heading","|","bold","italic","underline","strikethrough","superscript","subscript","removeFormat","|","link","bulletedList","numberedList","blockQuote","horizontalLine","|","sourceEditing"]);
$c->save();
' >/dev/null 2>&1
echo "cleanup: canvas_full_html editor toolbar restored to shipped default"

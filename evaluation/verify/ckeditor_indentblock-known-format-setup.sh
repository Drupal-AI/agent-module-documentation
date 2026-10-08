#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# MEDIUM setup: enable CKEditor IndentBlock on the `full_html` text format so exactly one
# format has block indentation active. Appends the core Indent/Outdent toolbar items (which
# satisfy IndentBlock's `ckeditor5_indent` condition) and sets the plugin's enable flag on
# editor.editor.full_html. The agent must inspect live editor config to find which format it
# is. Idempotent (only appends items if missing). Paths relative to /var/www/html.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("editor.editor.full_html");
  $items = $c->get("settings.toolbar.items") ?: [];
  if (!in_array("indent", $items, TRUE))  { $items[] = "indent"; }
  if (!in_array("outdent", $items, TRUE)) { $items[] = "outdent"; }
  $c->set("settings.toolbar.items", $items);
  $c->set("settings.plugins.ckeditor_indentblock_indent.enable", TRUE);
  $c->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: IndentBlock enabled on full_html (indent/outdent + ckeditor_indentblock_indent.enable=TRUE)"

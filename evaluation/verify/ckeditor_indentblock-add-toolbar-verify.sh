#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Live-state verification for the "enable CKEditor IndentBlock on basic_html" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Checks the editor.editor.basic_html config entity:
#   ck   — it is still a ckeditor5 editor
#   tb   — the Indent toolbar item (`indent`) is present in settings.toolbar.items
#          (this is what activates the ckeditor_indentblock_indent plugin's condition)
#   en   — IndentBlock is not explicitly disabled: settings.plugins
#          .ckeditor_indentblock_indent.enable is unset (defaults TRUE) or TRUE
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $ck = $tb = FALSE; $en = TRUE; $detail = "";
  $ed = \Drupal::entityTypeManager()->getStorage("editor")->load("basic_html");
  if ($ed && $ed->getEditor() === "ckeditor5") {
    $ck = TRUE;
    $c = \Drupal::config("editor.editor.basic_html");
    $items = $c->get("settings.toolbar.items") ?: [];
    $tb = in_array("indent", $items, TRUE);
    $flag = $c->get("settings.plugins.ckeditor_indentblock_indent.enable");
    $en = ($flag === NULL) ? TRUE : (bool) $flag;
    $detail = "items=" . json_encode(array_values($items)) . " enable=" . var_export($flag, TRUE);
  }
  $ok = $ck && $tb && $en;
  print ($ok ? "PASS" : "FAIL") . " ck=".($ck?1:0)." tb=".($tb?1:0)." en=".($en?1:0)." ".$detail."\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Live-state verification for the "add the Iframe Embed button to basic_html" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Checks the editor.editor.basic_html config entity:
#   ck   — it is still a ckeditor5 editor
#   tb   — the Iframe Embed toolbar item (`iframeEmbed`) is present in settings.toolbar.items
#          (this is what activates the ckeditor_iframe_embed_iframeembed plugin)
# Paths relative to /var/www/html.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $ck = $tb = FALSE; $detail = "";
  $ed = \Drupal::entityTypeManager()->getStorage("editor")->load("basic_html");
  if ($ed && $ed->getEditor() === "ckeditor5") {
    $ck = TRUE;
    $c = \Drupal::config("editor.editor.basic_html");
    $items = $c->get("settings.toolbar.items") ?: [];
    $tb = in_array("iframeEmbed", $items, TRUE);
    $detail = "items=" . json_encode(array_values($items));
  }
  $ok = $ck && $tb;
  print ($ok ? "PASS" : "FAIL") . " ck=".($ck?1:0)." tb=".($tb?1:0)." ".$detail."\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Live-state verification for the "configure a CKEditor 5 Link Style on basic_html" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Checks the editor.editor.basic_html config entity:
#   ck  — it is still a ckeditor5 editor
#   st  — settings.plugins.ckeditor_link_styles_linkStyles.styles has >= 1 entry, each with a
#         non-empty label and an `element` that is an <a ...> carrying a class attribute
#         (the stored shape the ckeditor_link_styles plugin produces)
# Paths relative to /var/www/html.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $ck = $st = FALSE; $detail = "";
  $ed = \Drupal::entityTypeManager()->getStorage("editor")->load("basic_html");
  if ($ed && $ed->getEditor() === "ckeditor5") {
    $ck = TRUE;
    $styles = \Drupal::config("editor.editor.basic_html")
      ->get("settings.plugins.ckeditor_link_styles_linkStyles.styles");
    if (is_array($styles) && count($styles) > 0) {
      $ok = TRUE;
      foreach ($styles as $s) {
        $label = $s["label"] ?? "";
        $element = $s["element"] ?? "";
        if ($label === "" || stripos($element, "<a") !== 0 || stripos($element, "class") === FALSE) {
          $ok = FALSE;
        }
      }
      $st = $ok;
    }
    $detail = "styles=" . json_encode($styles);
  }
  $pass = $ck && $st;
  print ($pass ? "PASS" : "FAIL") . " ck=".($ck?1:0)." st=".($st?1:0)." ".$detail."\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

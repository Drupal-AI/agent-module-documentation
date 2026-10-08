#!/usr/bin/env bash
# Execution VERIFY (ui_styles_ckeditor5): PASS when editor.editor.basic_html has the style id
# 'ui_styles_eval_ck2' in the enabled_styles of EITHER UI Styles CKEditor 5 button (block/inline).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $plugins = \Drupal::config("editor.editor.basic_html")->get("settings.plugins") ?: [];
  $ok = FALSE;
  foreach (["ui_styles_ckeditor5_uiStylesBlock", "ui_styles_ckeditor5_uiStylesInline"] as $p) {
    $styles = $plugins[$p]["enabled_styles"] ?? [];
    if (\is_array($styles) && \in_array("ui_styles_eval_ck2", $styles, TRUE)) { $ok = TRUE; }
  }
  print ($ok ? "PASS" : "FAIL") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

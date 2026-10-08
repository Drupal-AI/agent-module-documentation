#!/usr/bin/env bash
# Execution VERIFY: PASS when field_cjs_lbl still uses a Clipboard.js formatter and its label
# setting is 'Copy value'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::service("entity_display.repository")->getViewDisplay("node", "article", "default");
  $c = $vd->getComponent("field_cjs_lbl");
  $type = $c["type"] ?? "none";
  $label = $c["settings"]["label"] ?? "";
  $is_cjs = in_array($type, ["clipboard_button", "clipboard_snippet", "clipboard_textfield", "clipboard_textarea"], TRUE);
  $ok = $is_cjs && ($label === "Copy value");
  print ($ok ? "PASS" : "FAIL") . " formatter=" . $type . " label=" . var_export($label, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1

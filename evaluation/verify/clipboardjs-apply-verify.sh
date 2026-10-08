#!/usr/bin/env bash
# Execution VERIFY: PASS when field_cjs_task's default view-display formatter is one of the
# Clipboard.js formatters. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::service("entity_display.repository")->getViewDisplay("node", "article", "default");
  $c = $vd->getComponent("field_cjs_task");
  $type = $c["type"] ?? "none";
  $ok = in_array($type, ["clipboard_button", "clipboard_snippet", "clipboard_textfield", "clipboard_textarea"], TRUE);
  print ($ok ? "PASS" : "FAIL") . " formatter=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1

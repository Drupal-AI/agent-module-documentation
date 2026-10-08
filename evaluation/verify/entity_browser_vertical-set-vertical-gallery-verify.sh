#!/usr/bin/env bash
# Execution VERIFY (entity_browser_vertical, layman): PASS when field_ebv_gallery uses the
# Entity Browser widget with settings.field_widget_display === "entity_browser_vertical_label".
# Read-only. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_ebv_gallery") : NULL;
  $type = $c["type"] ?? "none";
  $disp = $c["settings"]["field_widget_display"] ?? NULL;
  $ok = ($type === "entity_browser_entity_reference" && $disp === "entity_browser_vertical_label");
  print ($ok ? "PASS" : "FAIL") . " widget=" . $type . " field_widget_display=" . var_export($disp, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

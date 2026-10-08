#!/usr/bin/env bash
# Execution VERIFY (ui_styles_layout_builder): PASS when the first section of node.page.default
# carries the CSS class 'ui-styles-eval-lb2' via ui_styles (section selected values or extra).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $display = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.page.default");
  $ok = FALSE;
  if ($display && $display->isLayoutBuilderEnabled()) {
    foreach ($display->getSections() as $section) {
      $selected = $section->getThirdPartySetting("ui_styles", "selected") ?: [];
      $extra = (string) ($section->getThirdPartySetting("ui_styles", "extra") ?: "");
      $classes = \array_merge(\array_values($selected), \explode(" ", $extra));
      if (\in_array("ui-styles-eval-lb2", $classes, TRUE)) { $ok = TRUE; }
    }
  }
  print ($ok ? "PASS" : "FAIL") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

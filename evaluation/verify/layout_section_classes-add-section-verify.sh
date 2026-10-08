#!/usr/bin/env bash
# Execution VERIFY: PASS when node.lsc_demo.default has a Layout Builder section using
# lsc_fixture_layout whose additional.classes.style is a non-empty class. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.lsc_demo.default");
  $secs = $vd ? $vd->getThirdPartySetting("layout_builder", "sections", []) : [];
  $found = FALSE; $style = NULL;
  foreach ($secs as $s) {
    if ($s->getLayoutId() === "lsc_fixture_layout") {
      $style = $s->getLayoutSettings()["additional"]["classes"]["style"] ?? NULL;
      if (is_string($style) && $style !== "") { $found = TRUE; break; }
    }
  }
  print ($found ? "PASS" : "FAIL") . " classySection=" . var_export($found, TRUE) . " style=" . var_export($style, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

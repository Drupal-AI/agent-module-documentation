#!/usr/bin/env bash
# Execution VERIFY: PASS when the first Layout Builder section on node.lsc_demo.default uses
# lsc_fixture_layout and its additional.classes.style equals 'bg-primary'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.lsc_demo.default");
  $secs = $vd ? $vd->getThirdPartySetting("layout_builder", "sections", []) : [];
  $style = NULL; $lid = NULL;
  foreach ($secs as $s) {
    if ($s->getLayoutId() === "lsc_fixture_layout") { $lid = "lsc_fixture_layout"; $style = $s->getLayoutSettings()["additional"]["classes"]["style"] ?? NULL; break; }
  }
  $ok = ($lid === "lsc_fixture_layout" && $style === "bg-primary");
  print ($ok ? "PASS" : "FAIL") . " layout=" . var_export($lid, TRUE) . " style=" . var_export($style, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

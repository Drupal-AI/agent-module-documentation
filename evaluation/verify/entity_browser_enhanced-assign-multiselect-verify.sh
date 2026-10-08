#!/usr/bin/env bash
# Execution VERIFY: PASS when the Enhanced Multiselect enhancer is assigned to the View widget
# of the ebe_task entity browser, i.e. entity_browser_enhanced.widgets.ebe_task has the widget's
# UUID mapped to "multiselect". exit 0 = pass, 1 = fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $b = \Drupal::entityTypeManager()->getStorage("entity_browser")->load("ebe_task");
  $cfg = \Drupal::config("entity_browser_enhanced.widgets.ebe_task")->getRawData();
  $ok = FALSE; $seen = [];
  if ($b) {
    foreach ($b->get("widgets") as $uuid => $w) {
      if (($w["id"] ?? "") !== "view") { continue; }
      $val = $cfg[$uuid] ?? NULL;
      $seen[] = $uuid . "=" . var_export($val, TRUE);
      if ($val === "multiselect") { $ok = TRUE; }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " browser=" . ($b ? "yes" : "no") . " widgets[" . implode(", ", $seen) . "]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

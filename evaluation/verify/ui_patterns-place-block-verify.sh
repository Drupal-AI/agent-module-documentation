#!/usr/bin/env bash
# Live-state verification for "place a UI Patterns component as a block".
# PASS when an enabled block config entity exists whose plugin is ui_patterns:<component>
# and whose settings carry a component_id. Exit 0 = pass, 1 = fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ok = FALSE; $found = "";
  foreach (\Drupal::entityTypeManager()->getStorage("block")->loadMultiple() as $b) {
    $pid = (string) $b->getPluginId();
    if (strpos($pid, "ui_patterns:") === 0 && $b->status()) {
      $s = $b->get("settings");
      if (!empty($s["ui_patterns"]["component_id"])) { $ok = TRUE; $found = $pid; break; }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " plugin=" . $found . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

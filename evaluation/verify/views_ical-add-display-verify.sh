#!/usr/bin/env bash
# Execution VERIFY (views_ical H2): PASS when the existing view 'vical_base' now has an iCal
# feed display added — a display with plugin 'ical' OR style 'ical'/'ical_wizard'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $cfg = \Drupal::config("views.view.vical_base");
  $displays = $cfg->get("display") ?: [];
  $ok = FALSE; $found = "none";
  foreach ($displays as $d) {
    $dp = $d["display_plugin"] ?? "";
    $st = $d["display_options"]["style"]["type"] ?? "";
    if ($dp === "ical" || in_array($st, ["ical","ical_wizard"], TRUE)) { $ok = TRUE; $found = $dp."/".$st; }
  }
  print ($ok ? "PASS" : "FAIL")." display=".$found."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

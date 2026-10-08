#!/usr/bin/env bash
# Execution VERIFY (views_ical H1): PASS when a view 'vical_task' exists with a display that is
# an iCal feed — i.e. a display whose plugin is 'ical' OR whose style plugin is 'ical'/'ical_wizard'.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $cfg = \Drupal::config("views.view.vical_task");
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

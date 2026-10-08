#!/usr/bin/env bash
# Execution VERIFY: PASS when view fcl_plan has a fullcalendar_legend area handler in any
# display region. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal\views\Entity\View::load("fcl_plan");
  $found = "no";
  if ($v) {
    foreach ($v->get("display") as $d) {
      foreach (["header", "footer", "empty"] as $region) {
        foreach (($d["display_options"][$region] ?? []) as $key => $h) {
          $pid = $h["plugin_id"] ?? ($h["id"] ?? $key);
          if ($pid === "fullcalendar_legend") { $found = "yes"; }
        }
      }
    }
  }
  print (($found === "yes") ? "PASS" : "FAIL") . " view=" . ($v ? "fcl_plan" : "missing") . " legend=" . $found . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

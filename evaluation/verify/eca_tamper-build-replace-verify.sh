#!/usr/bin/env bash
# Execution VERIFY: PASS when ECA model ectamp_task2 exists and an action uses the eca_tamper
# Find Replace derivative (plugin eca_tamper:find_replace). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("eca")->load("ectamp_task2");
  $found = "";
  if ($e) {
    foreach ($e->get("actions") ?? [] as $a) {
      if (($a["plugin"] ?? "") === "eca_tamper:find_replace") { $found = $a["plugin"]; break; }
    }
  }
  print ($found ? "PASS" : "FAIL") . " model=" . ($e ? "yes" : "no") . " action=" . ($found ?: "none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

#!/usr/bin/env bash
# Execution VERIFY: PASS when an ECA model eca_crowdsec_task exists whose events include an event
# plugin crowdsec:banned. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\eca\Entity\Eca;
  $e = Eca::load("eca_crowdsec_task");
  $ok = FALSE; $found = "none";
  if ($e) {
    foreach ($e->get("events") ?? [] as $ev) {
      if (($ev["plugin"] ?? "") === "crowdsec:banned") { $ok = TRUE; $found = "crowdsec:banned"; break; }
      $found = $ev["plugin"] ?? "none";
    }
  }
  print ($ok ? "PASS" : "FAIL") . " model=" . ($e ? "present" : "absent") . " event=" . $found . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

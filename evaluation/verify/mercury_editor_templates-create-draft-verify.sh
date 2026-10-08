#!/usr/bin/env bash
# Execution VERIFY: PASS when a me_template labeled 'ME Hero Draft' with status=0 exists.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("me_template");
  $found = $s->loadByProperties(["label" => "ME Hero Draft"]);
  $ok = FALSE;
  foreach ($found as $e) { if ((int) $e->get("status")->value === 0) { $ok = TRUE; } }
  print ($ok ? "PASS" : "FAIL") . " matches=" . count($found) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

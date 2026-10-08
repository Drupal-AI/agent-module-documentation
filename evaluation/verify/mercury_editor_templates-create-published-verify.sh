#!/usr/bin/env bash
# Execution VERIFY: PASS when a me_template labeled 'ME Task Template' with status=1 exists.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("me_template");
  $found = $s->loadByProperties(["label" => "ME Task Template"]);
  $ok = FALSE;
  foreach ($found as $e) { if ((int) $e->get("status")->value === 1) { $ok = TRUE; } }
  print ($ok ? "PASS" : "FAIL") . " matches=" . count($found) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

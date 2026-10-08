#!/usr/bin/env bash
# Execution VERIFY: PASS when an ENABLED response_header entity outputs X-Frame-Options: DENY.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ok = FALSE;
  foreach (\Drupal::entityTypeManager()->getStorage("response_header")->loadMultiple() as $e) {
    if ($e->get("status") && $e->get("name") === "X-Frame-Options" && $e->get("value") === "DENY") { $ok = TRUE; }
  }
  print ($ok ? "PASS" : "FAIL") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

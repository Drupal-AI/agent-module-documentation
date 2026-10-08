#!/usr/bin/env bash
# Execution VERIFY: PASS when an ENABLED response_header outputs X-Robots-Tag with a value
# containing 'noindex'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ok = FALSE;
  foreach (\Drupal::entityTypeManager()->getStorage("response_header")->loadMultiple() as $e) {
    if ($e->get("status") && $e->get("name") === "X-Robots-Tag" && stripos((string) $e->get("value"), "noindex") !== FALSE) { $ok = TRUE; }
  }
  print ($ok ? "PASS" : "FAIL") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

#!/usr/bin/env bash
# Execution VERIFY: PASS when reporting_ep_toggle still exists but status is FALSE (disabled).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal\reporting\Entity\ReportingEndpoint::load("reporting_ep_toggle");
  $ok = $e && !$e->status();
  print ($ok ? "PASS" : "FAIL") . " exists=" . var_export((bool) $e, TRUE) . " status=" . var_export($e ? $e->status() : NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

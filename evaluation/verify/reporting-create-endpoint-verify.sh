#!/usr/bin/env bash
# Execution VERIFY: PASS when reporting_endpoint 'reporting_ep_task' exists and is enabled.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal\reporting\Entity\ReportingEndpoint::load("reporting_ep_task");
  $ok = $e && $e->status();
  print ($ok ? "PASS" : "FAIL") . " exists=" . var_export((bool) $e, TRUE) . " status=" . var_export($e ? $e->status() : NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

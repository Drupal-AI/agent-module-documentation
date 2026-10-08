#!/usr/bin/env bash
# Execution VERIFY: PASS when the Nagios status page is enabled AND its path is
# 'nagios_status_task'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("nagios.settings");
  $enabled = $c->get("nagios.statuspage.enabled");
  $path = $c->get("nagios.statuspage.path");
  $ok = (($enabled === TRUE || $enabled === 1 || $enabled === "1") && $path === "nagios_status_task");
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($enabled, TRUE) . " path=" . var_export($path, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

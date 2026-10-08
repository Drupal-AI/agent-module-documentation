#!/usr/bin/env bash
# Hard (execution) VERIFY for the "add the acme vendor prefix" task.
# PASS (exit 0) iff composer_deploy.settings:prefixes contains 'acme' on the live site.
# FAIL (exit 1) on the reset baseline of [drupal]. No arguments.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $prefixes = \Drupal::config("composer_deploy.settings")->get("prefixes") ?: [];
  $has = in_array("acme", $prefixes, TRUE);
  print ($has ? "PASS" : "FAIL") . " prefixes=" . implode(",", $prefixes) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

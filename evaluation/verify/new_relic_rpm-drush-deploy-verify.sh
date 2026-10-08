#!/usr/bin/env bash
# Execution VERIFY: PASS when track_drush==='ignore' AND module_deployment===TRUE.
# Prints PASS/FAIL. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("new_relic_rpm.settings");
  $td = $c->get("track_drush");
  $md = $c->get("module_deployment");
  $ok = ($td === "ignore" && $md === TRUE);
  print ($ok ? "PASS" : "FAIL") . " track_drush=" . var_export($td, TRUE) . " module_deployment=" . var_export($md, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

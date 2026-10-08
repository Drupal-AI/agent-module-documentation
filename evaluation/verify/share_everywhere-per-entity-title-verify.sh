#!/usr/bin/env bash
# Execution VERIFY: PASS when per_entity truthy and title==='Share this'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("share_everywhere.settings");
  $ok = ((int) $c->get("per_entity") === 1) && ($c->get("title") === "Share this");
  print ($ok ? "PASS" : "FAIL") . " per_entity=" . var_export($c->get("per_entity"), TRUE) . " title=" . var_export($c->get("title"), TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

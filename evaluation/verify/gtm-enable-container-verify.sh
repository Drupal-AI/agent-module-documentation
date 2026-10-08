#!/usr/bin/env bash
# Live-state verification for "enable GTM with a valid container ID".
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Reads gtm.settings and checks:
#   en  — the master 'enable' switch is on
#   id  — 'google-tag' is a non-empty GTM container ID (matches GTM-XXXX...)
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $c = \Drupal::config("gtm.settings");
  $en = (bool) $c->get("enable");
  $tag = (string) $c->get("google-tag");
  $id = (bool) preg_match("/^GTM-[A-Z0-9]+$/i", $tag);
  $ok = $en && $id;
  print ($ok ? "PASS" : "FAIL") . " en=" . ($en?1:0) . " id=" . ($id?1:0) . " tag=" . $tag . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

#!/usr/bin/env bash
# Live-state verification for "GTM fires front-end only and excludes the superuser".
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Reads gtm.settings and checks all four conditions:
#   en   — 'enable' is on
#   id   — 'google-tag' is a valid non-empty GTM-XXXX container ID
#   fe   — 'admin-pages' is off (0) so GTM does NOT fire on /admin/* (front-end only)
#   xu1  — 'admin-disable' is on (1) so uid 1 is excluded
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $c = \Drupal::config("gtm.settings");
  $en  = (bool) $c->get("enable");
  $tag = (string) $c->get("google-tag");
  $id  = (bool) preg_match("/^GTM-[A-Z0-9]+$/i", $tag);
  $fe  = !((bool) $c->get("admin-pages"));
  $xu1 = (bool) $c->get("admin-disable");
  $ok = $en && $id && $fe && $xu1;
  print ($ok ? "PASS" : "FAIL") . " en=" . ($en?1:0) . " id=" . ($id?1:0)
      . " fe=" . ($fe?1:0) . " xu1=" . ($xu1?1:0) . " tag=" . $tag . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

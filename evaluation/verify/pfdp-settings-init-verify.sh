#!/usr/bin/env bash
# Execution VERIFY for "make per-user download grants work on this site and log every pfdp
# decision, without turning on attachment or override mode".
# PASS when pfdp.settings actually exists in config storage with by_user_checks TRUE,
# debug_mode TRUE, and attachment_mode / override_mode falsy.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $raw = \Drupal::service("config.storage")->read("pfdp.settings");
  if ($raw === FALSE) { print "FAIL pfdp.settings=missing\n"; return; }
  $c = \Drupal::config("pfdp.settings");
  $truthy = fn($v) => ($v === TRUE || $v === 1 || $v === "1");
  $falsy = fn($v) => ($v === FALSE || $v === 0 || $v === "0" || $v === NULL);
  $ok = $truthy($c->get("by_user_checks")) && $truthy($c->get("debug_mode"))
    && $falsy($c->get("attachment_mode")) && $falsy($c->get("override_mode"));
  print ($ok ? "PASS" : "FAIL")
    . " by_user_checks=" . var_export($c->get("by_user_checks"), TRUE)
    . " debug_mode=" . var_export($c->get("debug_mode"), TRUE)
    . " attachment_mode=" . var_export($c->get("attachment_mode"), TRUE)
    . " override_mode=" . var_export($c->get("override_mode"), TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

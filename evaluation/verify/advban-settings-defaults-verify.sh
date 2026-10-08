#!/usr/bin/env bash
# Execution VERIFY for "make new advban bans default to +2 hours and protect 198.51.100.0/24".
# PASS when advban.settings has default_expiry_duration '+2 hours', that duration is present
# in the expiry_durations list, and advban_protected_ips contains 198.51.100.0/24.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("advban.settings");
  $default = trim((string) $c->get("default_expiry_duration"));
  $durations = array_map("trim", explode("\n", str_replace("\r", "", (string) $c->get("expiry_durations"))));
  $protected = (string) $c->get("advban_protected_ips");
  $in_list = in_array("+2 hours", $durations, TRUE);
  $has_cidr = strpos($protected, "198.51.100.0/24") !== FALSE;
  $ok = ($default === "+2 hours") && $in_list && $has_cidr;
  print ($ok ? "PASS" : "FAIL")
    . " default=" . var_export($default, TRUE)
    . " in_durations=" . var_export($in_list, TRUE)
    . " protected_cidr=" . var_export($has_cidr, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

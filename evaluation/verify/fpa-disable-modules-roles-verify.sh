#!/usr/bin/env bash
# Live-state verification for the "disable the Module listing and Role filter sections" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# PASS only if fpa.settings disabled_sections contains BOTH `modules` and `roles`
# (regardless of whether the values are stored as a list or a key=>key map).
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $raw = \Drupal::config("fpa.settings")->get("disabled_sections");
  $vals = is_array($raw) ? array_values($raw) : [];
  $has_modules = in_array("modules", $vals, TRUE);
  $has_roles = in_array("roles", $vals, TRUE);
  print (($has_modules && $has_roles) ? "PASS" : "FAIL")
    . " modules=" . ($has_modules?1:0) . " roles=" . ($has_roles?1:0)
    . " | disabled_sections=[" . implode(",", $vals) . "]\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

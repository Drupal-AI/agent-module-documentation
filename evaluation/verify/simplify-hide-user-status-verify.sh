#!/usr/bin/env bash
# Live-state verification for "hide the Status (blocked/active) control on user account forms".
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Reads simplify.global:simplify_users_global and requires the element key `status` to be present.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $vals = \Drupal::config("simplify.global")->get("simplify_users_global");
  $vals = is_array($vals) ? $vals : [];
  $status = in_array("status", $vals, TRUE);
  print ($status ? "PASS" : "FAIL") . " status=" . ($status?1:0)
    . " set=[" . implode(",", $vals) . "]\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

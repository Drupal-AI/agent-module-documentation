#!/usr/bin/env bash
# Live-state verification for the "disable the page help text and the permission status
# filter sections" task. Prints PASS/FAIL and exits 0 (pass) / 1 (fail). No arguments.
# PASS only if fpa.settings disabled_sections contains BOTH `help` and `status`
# (values stored as a list or a key=>key map are both accepted).
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $raw = \Drupal::config("fpa.settings")->get("disabled_sections");
  $vals = is_array($raw) ? array_values($raw) : [];
  $has_help = in_array("help", $vals, TRUE);
  $has_status = in_array("status", $vals, TRUE);
  print (($has_help && $has_status) ? "PASS" : "FAIL")
    . " help=" . ($has_help?1:0) . " status=" . ($has_status?1:0)
    . " | disabled_sections=[" . implode(",", $vals) . "]\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

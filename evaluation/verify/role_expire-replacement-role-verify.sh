#!/usr/bin/env bash
# Execution VERIFY: PASS when Role Expire maps re_task -> re_after on expiry. Tolerant of the
# value being a JSON string (as the settings form stores it) or a raw array. Read-only.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $raw = \Drupal::config("role_expire.config")->get("role_expire_default_roles");
  $map = is_array($raw) ? $raw : (empty($raw) ? [] : (json_decode($raw, TRUE) ?: []));
  $v = $map["re_task"] ?? NULL;
  print (($v === "re_after") ? "PASS" : "FAIL") . " map=" . json_encode($map) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1

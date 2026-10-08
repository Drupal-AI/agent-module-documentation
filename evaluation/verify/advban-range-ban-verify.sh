#!/usr/bin/env bash
# Execution VERIFY for "ban the whole 203.0.113.0 - 203.0.113.255 range with the reason
# 'subnet abuse'".
# PASS when the advban IP manager reports an address in the middle of the range as banned
# (which only works if the range was stored the way advban stores ranges: ip/ip_end as
# ip2long integers with ip_end <> ''), and a row carries the reason 'subnet abuse'.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $m = \Drupal::service("advban.ip_manager");
  $mid = $m->isBanned("203.0.113.128", ["expiry_check" => TRUE]);
  $first = $m->isBanned("203.0.113.0", ["expiry_check" => TRUE]);
  $reason = $m->isBannedByReason("subnet abuse");
  $rows = \Drupal::database()->query("SELECT COUNT(*) FROM {advban_ip} WHERE ip_end <> \x27\x27")->fetchField();
  $outside = $m->isBanned("198.51.100.7", ["expiry_check" => TRUE]);
  $ok = (bool) $mid && (bool) $first && !empty($reason["is_banned"]) && $rows > 0 && !$outside;
  print ($ok ? "PASS" : "FAIL")
    . " mid=" . var_export((bool) $mid, TRUE)
    . " first=" . var_export((bool) $first, TRUE)
    . " reason_row=" . var_export(!empty($reason["is_banned"]), TRUE)
    . " range_rows=" . $rows
    . " outside_range_banned=" . var_export((bool) $outside, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

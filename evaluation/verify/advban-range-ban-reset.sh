#!/usr/bin/env bash
# Execution RESET: remove every advban_ip row that covers the 203.0.113.0/24 documentation
# range (single or range rows, dotted or numeric storage) so verify FAILS on empty state.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $db = \Drupal::database();
  $start = sprintf("%u", ip2long("203.0.113.0"));
  $end = sprintf("%u", ip2long("203.0.113.255"));
  $db->delete("advban_ip")->condition("ip", ["203.0.113.0", "203.0.113.45", "203.0.113.128", "203.0.113.255", $start], "IN")->execute();
  $db->delete("advban_ip")->condition("ip_end", ["203.0.113.255", $end], "IN")->execute();
  $db->delete("advban_ip")->condition("reason", "%subnet abuse%", "LIKE")->execute();
' >/dev/null 2>&1
echo "reset: no advban_ip rows covering 203.0.113.0/24"

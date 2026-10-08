#!/usr/bin/env bash
# Execution VERIFY: PASS when masquerade_log is enabled AND it has decorated the dblog logger
# (get_class(logger.dblog) === Drupal\masquerade_log\MasqueradeLogLogger). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $enabled = \Drupal::moduleHandler()->moduleExists("masquerade_log");
  $cls = $enabled ? get_class(\Drupal::service("logger.dblog")) : "";
  $ok = $enabled && ($cls === "Drupal\\masquerade_log\\MasqueradeLogLogger");
  print ($ok?"PASS":"FAIL")." enabled=".var_export($enabled,TRUE)." logger.dblog=".$cls."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1

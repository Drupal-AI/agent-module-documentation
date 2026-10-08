#!/usr/bin/env bash
# Execution VERIFY: PASS when feature ft_switch is ON (FeatureStatus getStatus === TRUE).
# Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::service("feature_toggle.feature_status");
  $on = $s->getStatus("ft_switch");
  print ($on === TRUE ? "PASS" : "FAIL") . " ft_switch_status=" . var_export($on, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

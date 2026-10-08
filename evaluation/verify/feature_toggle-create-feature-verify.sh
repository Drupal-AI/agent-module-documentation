#!/usr/bin/env bash
# Execution VERIFY: PASS when a feature named ft_task is defined (in feature_toggle.features).
# Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $m = \Drupal::service("feature_toggle.feature_manager");
  $ok = $m->featureExists("ft_task");
  print ($ok ? "PASS" : "FAIL") . " ft_task_exists=" . var_export($ok, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

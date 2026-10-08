#!/usr/bin/env bash
# Execution RESET: ensure feature ft_task does NOT exist, so verify FAILS until the agent creates
# it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $m = \Drupal::service("feature_toggle.feature_manager");
  if ($m->featureExists("ft_task")) { $m->deleteFeature("ft_task"); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: feature ft_task removed"

#!/usr/bin/env bash
# Execution CLEANUP: delete feature ft_task. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $m = \Drupal::service("feature_toggle.feature_manager");
  if ($m->featureExists("ft_task")) { $m->deleteFeature("ft_task"); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: feature ft_task removed"

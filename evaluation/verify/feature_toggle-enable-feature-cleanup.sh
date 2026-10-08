#!/usr/bin/env bash
# Execution CLEANUP: delete feature ft_switch. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $m = \Drupal::service("feature_toggle.feature_manager");
  if ($m->featureExists("ft_switch")) { $m->deleteFeature("ft_switch"); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: feature ft_switch removed"

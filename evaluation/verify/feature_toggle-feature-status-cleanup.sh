#!/usr/bin/env bash
# Introspection CLEANUP: delete feature ft_known (removes config entry and status flag). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $m = \Drupal::service("feature_toggle.feature_manager");
  if ($m->featureExists("ft_known")) { $m->deleteFeature("ft_known"); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: feature ft_known removed"

#!/usr/bin/env bash
# Introspection CLEANUP: delete features ft_on and ft_off. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $m = \Drupal::service("feature_toggle.feature_manager");
  foreach (["ft_on", "ft_off"] as $n) { if ($m->featureExists($n)) { $m->deleteFeature($n); } }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ft_on and ft_off removed"

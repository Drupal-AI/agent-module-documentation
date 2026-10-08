#!/usr/bin/env bash
# Introspection SETUP: define two features - ft_on (enabled) and ft_off (disabled). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\feature_toggle\Feature;
  $m = \Drupal::service("feature_toggle.feature_manager");
  $s = \Drupal::service("feature_toggle.feature_status");
  if (!$m->featureExists("ft_on")) { $m->addFeature(new Feature("ft_on", "Feature On", "")); }
  if (!$m->featureExists("ft_off")) { $m->addFeature(new Feature("ft_off", "Feature Off", "")); }
  $s->setStatus($m->getFeature("ft_on"), TRUE);
  $s->setStatus($m->getFeature("ft_off"), FALSE);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ft_on enabled, ft_off disabled"

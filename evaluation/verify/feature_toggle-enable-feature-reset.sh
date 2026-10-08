#!/usr/bin/env bash
# Execution RESET: ensure feature ft_switch exists but is turned OFF, so verify FAILS until the
# agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\feature_toggle\Feature;
  $m = \Drupal::service("feature_toggle.feature_manager");
  $s = \Drupal::service("feature_toggle.feature_status");
  if (!$m->featureExists("ft_switch")) { $m->addFeature(new Feature("ft_switch", "Switch Feature", "")); }
  $s->setStatus($m->getFeature("ft_switch"), FALSE);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: feature ft_switch defined and disabled"

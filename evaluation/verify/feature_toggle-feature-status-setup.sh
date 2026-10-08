#!/usr/bin/env bash
# Introspection SETUP: define a feature ft_known and turn it ON. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\feature_toggle\Feature;
  $m = \Drupal::service("feature_toggle.feature_manager");
  $s = \Drupal::service("feature_toggle.feature_status");
  if (!$m->featureExists("ft_known")) { $m->addFeature(new Feature("ft_known", "Known Feature", "Set by eval setup.")); }
  $s->setStatus($m->getFeature("ft_known"), TRUE);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: feature ft_known defined and enabled"

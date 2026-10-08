#!/usr/bin/env bash
# Introspection CLEANUP: remove the vfp_known view created by the matching setup. Restores
# baseline (no views.view.vfp_known). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $config = \Drupal::configFactory()->getEditable("views.view.vfp_known");
  if (!$config->isNew()) { $config->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: views.view.vfp_known removed"

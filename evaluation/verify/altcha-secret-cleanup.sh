#!/usr/bin/env bash
# hard CLEANUP (altcha): ensure a self-hosted secret key exists (regenerate if missing) so the site
# is left functional. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $sm = \Drupal::service("altcha.secret_manager");
  if (empty($sm->getSecretKey())) { $sm->generateSecretKey(); }
' >/dev/null 2>&1
echo "cleanup: ensured ALTCHA self-hosted secret key exists"

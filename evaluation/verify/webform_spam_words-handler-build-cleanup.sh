#!/usr/bin/env bash
# Execution CLEANUP: delete the wsw_test webform created for this case. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\webform\Entity\Webform;
  if ($w = Webform::load("wsw_test")) { $w->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: wsw_test removed"

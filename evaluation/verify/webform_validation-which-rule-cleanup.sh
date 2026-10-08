#!/usr/bin/env bash
# Introspection CLEANUP: delete webform wfv_known. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\webform\Entity\Webform;
  if ($w = Webform::load("wfv_known")) { $w->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: webform wfv_known removed"

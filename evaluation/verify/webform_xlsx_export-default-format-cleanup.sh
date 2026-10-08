#!/usr/bin/env bash
# Execution CLEANUP: delete the wfx_pref webform. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\webform\Entity\Webform;
  if ($w = Webform::load("wfx_pref")) { $w->delete(); }
' >/dev/null 2>&1
echo "cleanup: wfx_pref webform deleted"

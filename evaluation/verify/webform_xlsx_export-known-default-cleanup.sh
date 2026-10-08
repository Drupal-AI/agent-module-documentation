#!/usr/bin/env bash
# Introspection CLEANUP: delete the webform created by the setup (which also drops its
# saved export state). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\webform\Entity\Webform;
  if ($w = Webform::load("wfx_known")) { $w->delete(); }
' >/dev/null 2>&1
echo "cleanup: webform wfx_known deleted"

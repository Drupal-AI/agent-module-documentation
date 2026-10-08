#!/usr/bin/env bash
# Introspection CLEANUP: delete vmsw_probe workflow (its hook clears the weight rows). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\workflows\Entity\Workflow;
  if ($w = Workflow::load("vmsw_probe")) { $w->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: vmsw_probe removed"

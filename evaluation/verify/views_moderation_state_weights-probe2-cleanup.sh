#!/usr/bin/env bash
# Introspection CLEANUP: delete vmsw_probe2. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\workflows\Entity\Workflow;
  if ($w = Workflow::load("vmsw_probe2")) { $w->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: vmsw_probe2 removed"

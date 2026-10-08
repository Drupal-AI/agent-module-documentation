#!/usr/bin/env bash
# Execution CLEANUP: delete any SARE_Task site_audit_report entity. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("site_audit_report");
  $ids = $s->getQuery()->accessCheck(FALSE)->condition("label","SARE_Task")->execute();
  if ($ids) { $s->delete($s->loadMultiple($ids)); }
' >/dev/null 2>&1
echo "cleanup: SARE_Task entities removed"

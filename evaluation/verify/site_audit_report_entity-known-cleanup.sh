#!/usr/bin/env bash
# Introspection CLEANUP: delete site_audit_report entities labelled SARE_Known_Report. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("site_audit_report");
  $ids = $s->getQuery()->accessCheck(FALSE)->condition("label","SARE_Known_Report")->execute();
  if ($ids) { $s->delete($s->loadMultiple($ids)); }
' >/dev/null 2>&1
echo "cleanup: SARE_Known_Report entities removed"

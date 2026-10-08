#!/usr/bin/env bash
# Execution RESET: ensure NO site_audit_report entity labelled SARE_Task exists, so verify FAILS
# until the agent creates one. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("site_audit_report");
  $ids = $s->getQuery()->accessCheck(FALSE)->condition("label","SARE_Task")->execute();
  if ($ids) { $s->delete($s->loadMultiple($ids)); }
' >/dev/null 2>&1
echo "reset: no SARE_Task site_audit_report entity"

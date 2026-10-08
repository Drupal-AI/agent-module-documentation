#!/usr/bin/env bash
# Introspection SETUP: create a site_audit_report entity with a distinctive label. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\site_audit_report_entity\Entity\SiteAuditReport;
  $s = \Drupal::entityTypeManager()->getStorage("site_audit_report");
  $ids = $s->getQuery()->accessCheck(FALSE)->condition("label","SARE_Known_Report")->execute();
  if (empty($ids)) {
    SiteAuditReport::create(["label"=>"SARE_Known_Report","data"=>[]])->save();
  }
' >/dev/null 2>&1
echo "setup: site_audit_report entity labelled SARE_Known_Report exists"

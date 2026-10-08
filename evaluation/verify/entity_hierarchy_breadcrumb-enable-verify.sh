#!/usr/bin/env bash
# HARD VERIFY: PASS when entity_hierarchy_breadcrumb is installed AND its breadcrumb_builder
# service (entity_hierarchy.breadcrumb) exists. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $installed = \Drupal::moduleHandler()->moduleExists("entity_hierarchy_breadcrumb");
  $svc = \Drupal::hasService("entity_hierarchy.breadcrumb");
  print (($installed && $svc) ? "PASS" : "FAIL") . " installed=" . var_export($installed,true) . " service=" . var_export($svc,true) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

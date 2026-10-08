#!/usr/bin/env bash
# Execution VERIFY: PASS when at least one site_audit_report entity labelled SARE_Task exists.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("site_audit_report");
  $ids = $s->getQuery()->accessCheck(FALSE)->condition("label","SARE_Task")->execute();
  print (count($ids) >= 1 ? "PASS" : "FAIL") . " count=" . count($ids) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

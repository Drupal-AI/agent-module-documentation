#!/usr/bin/env bash
# Execution VERIFY: PASS when a job_schedule entity name=jsw_worker type=jsw_worker_type id=7
# period=3600 exists. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("job_schedule");
  $ids = $s->getQuery()->accessCheck(FALSE)
    ->condition("name","jsw_worker")->condition("type","jsw_worker_type")
    ->condition("id",7)->condition("period",3600)->execute();
  print (!empty($ids) ? "PASS" : "FAIL") . " matches=" . count($ids) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

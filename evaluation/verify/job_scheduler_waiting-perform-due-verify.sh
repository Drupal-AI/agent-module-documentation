#!/usr/bin/env bash
# Execution VERIFY: PASS when no 'jsw_task' job remains pending (perform dispatched/removed it).
# exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("job_schedule");
  $ids = $s->getQuery()->accessCheck(FALSE)->condition("name","jsw_task")->execute();
  print (empty($ids) ? "PASS" : "FAIL") . " remaining=" . count($ids) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

#!/usr/bin/env bash
# Execution VERIFY: PASS when a job_schedule entity name=js_task type=js_task_type id=55 period=3600
# exists. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("job_schedule");
  $ids = $s->getQuery()->accessCheck(FALSE)
    ->condition("name","js_task")->condition("type","js_task_type")
    ->condition("id",55)->condition("period",3600)->execute();
  $ok = !empty($ids);
  print ($ok ? "PASS" : "FAIL") . " matches=" . count($ids) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1

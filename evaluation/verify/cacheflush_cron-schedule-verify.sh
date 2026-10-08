#!/usr/bin/env bash
# Execution VERIFY (cacheflush_cron): PASS when a preset 'cfc_task' has cron enabled AND its Ultimate
# Cron job cacheflush_preset_<id> exists. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\ultimate_cron\Entity\CronJob;
  $ok=FALSE;
  foreach(\Drupal::entityTypeManager()->getStorage("cacheflush")->loadByProperties(["title"=>"cfc_task"]) as $e){
    $cron = (bool) $e->get("cron")->value;
    if ($cron && CronJob::load("cacheflush_preset_".$e->id())) { $ok=TRUE; }
  }
  print $ok?"PASS":"FAIL";
' 2>/dev/null)
echo "$out" | grep -q 'PASS' && { echo PASS; exit 0; }
echo FAIL; exit 1

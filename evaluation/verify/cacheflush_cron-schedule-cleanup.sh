#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\ultimate_cron\Entity\CronJob;
  foreach(\Drupal::entityTypeManager()->getStorage("cacheflush")->loadByProperties(["title"=>"cfc_task"]) as $e){
    if($j=CronJob::load("cacheflush_preset_".$e->id())){$j->delete();}
    $e->delete();
  }
' >/dev/null 2>&1
echo "cleanup: cfc_task removed"

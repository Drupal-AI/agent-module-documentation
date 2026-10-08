#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'if(\Drupal::database()->schema()->tableExists("queue_unique")){\Drupal::database()->delete("queue_unique")->condition("name","qu_task")->execute();}' >/dev/null 2>&1
echo "cleanup: qu_task emptied"

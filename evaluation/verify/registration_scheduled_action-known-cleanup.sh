#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'if($sa=\Drupal::entityTypeManager()->getStorage("registration_scheduled_action")->load("reg_sched_known")){$sa->delete();}' >/dev/null 2>&1
echo "cleanup: registration_scheduled_action.reg_sched_known removed"

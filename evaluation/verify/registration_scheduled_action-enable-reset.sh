#!/usr/bin/env bash
# Execution RESET: ensure reg_sched_build does NOT exist so verify fails first.
set -uo pipefail
cd /var/www/html
drush php:eval 'if($sa=\Drupal::entityTypeManager()->getStorage("registration_scheduled_action")->load("reg_sched_build")){$sa->delete();}' >/dev/null 2>&1
echo "reset: registration_scheduled_action.reg_sched_build absent"

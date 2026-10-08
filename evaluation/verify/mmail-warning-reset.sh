#!/usr/bin/env bash
# Execution RESET: ensure monitoring_mail enabled and severities = [CRITICAL] only (verify FAILS
# until WARNING added). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:install monitoring_mail -y >/dev/null 2>&1
drush php:eval '$c=\Drupal::configFactory()->getEditable("monitoring_mail.settings"); $c->set("severities", ["CRITICAL"])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: monitoring_mail enabled; severities=[CRITICAL]"

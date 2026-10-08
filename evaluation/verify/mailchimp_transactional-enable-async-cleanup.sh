#!/usr/bin/env bash
# Execution CLEANUP: restore process_async=false, queue_worker_timeout=15 (shipped defaults). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("mailchimp_transactional.settings"); $c->set("process_async", FALSE)->set("queue_worker_timeout", 15)->save();' >/dev/null 2>&1
echo "cleanup: mailchimp_transactional.settings process_async=false queue_worker_timeout=15"

#!/usr/bin/env bash
# Execution RESET: force synchronous sending (process_async=false) and default timeout (15) so
# verify FAILS until the agent enables async with timeout 25. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("mailchimp_transactional.settings"); $c->set("process_async", FALSE)->set("queue_worker_timeout", 15)->save();' >/dev/null 2>&1
echo "reset: mailchimp_transactional.settings process_async=false queue_worker_timeout=15"

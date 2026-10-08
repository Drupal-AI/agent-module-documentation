#!/usr/bin/env bash
# Introspection CLEANUP: restore async + timeout to shipped defaults (false / 15). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("mailchimp_transactional.settings"); $c->set("process_async", FALSE)->set("queue_worker_timeout", 15)->save();' >/dev/null 2>&1
echo "cleanup: mailchimp_transactional.settings process_async=false queue_worker_timeout=15"

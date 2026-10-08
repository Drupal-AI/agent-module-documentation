#!/usr/bin/env bash
# Introspection SETUP: enable async processing and set a known queue worker timeout, so an agent
# can read the running mail-sending mode back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("mailchimp_transactional.settings"); $c->set("process_async", TRUE)->set("queue_worker_timeout", 30)->save();' >/dev/null 2>&1
echo "setup: mailchimp_transactional.settings process_async=true queue_worker_timeout=30"

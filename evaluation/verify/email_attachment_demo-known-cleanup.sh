#!/usr/bin/env bash
# Introspection CLEANUP: delete the demo spec State fixture. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->delete("email_attachment_demo_eval.spec");' >/dev/null 2>&1
echo "cleanup: State email_attachment_demo_eval.spec deleted"

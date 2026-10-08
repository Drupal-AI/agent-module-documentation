#!/usr/bin/env bash
# Execution CLEANUP: delete the demo result State key. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->delete("email_attachment_demo_eval.result");' >/dev/null 2>&1
echo "cleanup: State email_attachment_demo_eval.result deleted"

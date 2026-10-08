#!/usr/bin/env bash
# Execution CLEANUP: delete the State result key. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->delete("email_attachment_eval.result");' >/dev/null 2>&1
echo "cleanup: State email_attachment_eval.result deleted"

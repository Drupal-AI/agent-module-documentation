#!/usr/bin/env bash
# Execution RESET (demo): clear the State result so verify FAILS until the agent builds it.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->delete("email_attachment_demo_eval.result");' >/dev/null 2>&1
echo "reset: State email_attachment_demo_eval.result cleared"

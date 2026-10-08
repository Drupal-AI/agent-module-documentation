#!/usr/bin/env bash
# Execution RESET: clear the State result key so verify FAILS until the agent replicates the
# email_attachment_demo behavior (attach the demo's hook file to a contact_page_mail message and
# run it through the parent email_attachment module). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->delete("email_attachment_demo_eval.result");' >/dev/null 2>&1
echo "reset: State email_attachment_demo_eval.result cleared"

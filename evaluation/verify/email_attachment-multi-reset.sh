#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->delete("email_attachment_eval.result2");' >/dev/null 2>&1
echo "reset: State email_attachment_eval.result2 cleared"

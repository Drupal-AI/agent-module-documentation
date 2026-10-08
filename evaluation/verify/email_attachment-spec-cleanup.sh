#!/usr/bin/env bash
# Introspection CLEANUP: delete the State spec fixture. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->delete("email_attachment_eval.spec");' >/dev/null 2>&1
echo "cleanup: State email_attachment_eval.spec deleted"

#!/usr/bin/env bash
# Execution RESET: ensure payment gateway ca_hosted_task does NOT exist. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("commerce_payment_gateway");
  if ($e = $s->load("ca_hosted_task")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: ca_hosted_task absent"

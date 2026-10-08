#!/usr/bin/env bash
# Execution CLEANUP: delete the fbpc_eval_flow checkout flow. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("commerce_checkout_flow");
  if ($flow = $storage->load("fbpc_eval_flow")) { $flow->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: checkout flow fbpc_eval_flow deleted"

#!/usr/bin/env bash
# Execution RESET: delete the fbpc_eval_flow checkout flow so verify FAILS on empty state.
# Leaves facebook_pixel_commerce enabled (it is the module under test). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en facebook_pixel_commerce -y >/dev/null 2>&1
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("commerce_checkout_flow");
  if ($flow = $storage->load("fbpc_eval_flow")) { $flow->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: checkout flow fbpc_eval_flow deleted"

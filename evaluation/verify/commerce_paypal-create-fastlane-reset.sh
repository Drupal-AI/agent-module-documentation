#!/usr/bin/env bash
# HARD execution reset: remove the fastlane_sandbox payment gateway so the "create a Fastlane
# by PayPal gateway in sandbox mode" build task starts from a missing (failing) state.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $g = \Drupal::entityTypeManager()->getStorage("commerce_payment_gateway")->load("fastlane_sandbox");
  if ($g) { $g->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: payment gateway fastlane_sandbox removed (if it existed)"

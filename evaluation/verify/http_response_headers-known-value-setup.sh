#!/usr/bin/env bash
# Introspection SETUP: create an enabled response_header entity with a known value so an
# agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("response_header");
  if (!$s->load("hrh_med_value")) {
    $s->create([
      "id" => "hrh_med_value", "label" => "HRH Medium Value",
      "name" => "X-Custom-Test", "value" => "medium-value", "status" => TRUE,
    ])->save();
  }
' >/dev/null 2>&1
echo "setup: response_header hrh_med_value -> X-Custom-Test: medium-value"

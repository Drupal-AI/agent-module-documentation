#!/usr/bin/env bash
# Introspection SETUP: create a DISABLED response_header entity so an agent must read its
# status. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("response_header");
  $e = $s->load("hrh_med_disabled");
  if (!$e) {
    $e = $s->create(["id" => "hrh_med_disabled", "label" => "HRH Medium Disabled",
      "name" => "X-Disabled-Test", "value" => "off"]);
  }
  $e->set("status", FALSE)->save();
' >/dev/null 2>&1
echo "setup: response_header hrh_med_disabled (X-Disabled-Test) status=FALSE"

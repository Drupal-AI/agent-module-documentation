#!/usr/bin/env bash
# Introspection SETUP: write a known sdc_tags rule for tag 'sdct_status' permitting only 'stable'
# components (and forbidding the demo card). Only touches its own tag key. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("sdc_tags.settings")
    ->set("component_tags.sdct_status", [
      "tag_id" => "sdct_status",
      "statuses" => ["stable"],
      "allowed" => [],
      "forbidden" => ["cl_editorial:component-card"],
    ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: sdc_tags.settings component_tags.sdct_status statuses=[stable]"

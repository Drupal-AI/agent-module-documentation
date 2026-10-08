#!/usr/bin/env bash
# Introspection SETUP: write a known sdc_tags tagging rule for tag 'sdct_known' that allow-lists
# the cl_editorial:component-card component. Only touches its own tag key. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("sdc_tags.settings")
    ->set("component_tags.sdct_known", [
      "tag_id" => "sdct_known",
      "statuses" => ["stable", "experimental"],
      "allowed" => ["cl_editorial:component-card"],
      "forbidden" => [],
    ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: sdc_tags.settings component_tags.sdct_known allow-lists cl_editorial:component-card"

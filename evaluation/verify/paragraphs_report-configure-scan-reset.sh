#!/usr/bin/env bash
# Execution RESET: clear content_types and disable watch_content so verify FAILS until the agent sets them.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("paragraphs_report.settings")
    ->set("content_types", [])->set("watch_content", FALSE)->save();
' >/dev/null 2>&1
echo "reset: content_types cleared, watch_content=FALSE"

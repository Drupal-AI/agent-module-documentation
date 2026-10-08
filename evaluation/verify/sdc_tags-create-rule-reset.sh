#!/usr/bin/env bash
# Execution RESET: ensure no tagging rule exists for tag 'sdct_task', so verify FAILS until the
# agent creates one. Only touches its own tag key. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("sdc_tags.settings")->clear("component_tags.sdct_task")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: sdc_tags.settings component_tags.sdct_task cleared"

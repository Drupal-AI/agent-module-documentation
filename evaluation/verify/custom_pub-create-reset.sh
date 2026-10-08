#!/usr/bin/env bash
# Execution RESET: ensure custom publishing option cpub_task does NOT exist (and its node field is
# uninstalled), so verify FAILS until the agent creates it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\custom_pub\Entity\CustomPublishingOption;
  if ($o=CustomPublishingOption::load("cpub_task")) { $o->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: custom_publishing_option cpub_task absent"

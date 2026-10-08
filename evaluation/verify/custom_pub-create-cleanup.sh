#!/usr/bin/env bash
# Execution CLEANUP: delete option cpub_task (uninstalls its node field). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\custom_pub\Entity\CustomPublishingOption;
  if ($o=CustomPublishingOption::load("cpub_task")) { $o->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: custom_publishing_option cpub_task removed"

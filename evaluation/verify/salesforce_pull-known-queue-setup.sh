#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("salesforce.settings")->set("pull_max_queue_size",750)->save();' >/dev/null 2>&1
echo "setup: salesforce.settings pull_max_queue_size=750"

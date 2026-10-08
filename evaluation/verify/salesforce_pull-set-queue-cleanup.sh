#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("salesforce.settings")->set("pull_max_queue_size",100000)->save();' >/dev/null 2>&1
echo "cleanup: pull_max_queue_size restored to 100000"

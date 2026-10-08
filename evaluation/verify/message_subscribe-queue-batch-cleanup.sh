#!/usr/bin/env bash
# Execution CLEANUP (message_subscribe): restore shipped defaults use_queue=false, range=100. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("message_subscribe.settings")->set("use_queue", FALSE)->set("range", 100)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: message_subscribe.settings use_queue/range restored to defaults"

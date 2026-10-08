#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped default away threshold (120). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("private_message.settings")
    ->set("number_of_seconds_considered_away", 120)->save();
' >/dev/null 2>&1
echo "cleanup: private_message.settings number_of_seconds_considered_away restored to 120"

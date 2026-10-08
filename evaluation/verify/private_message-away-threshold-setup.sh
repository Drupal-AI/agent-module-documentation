#!/usr/bin/env bash
# Introspection SETUP: set private_message.settings number_of_seconds_considered_away to a
# distinctive value (4242; default is 120) so the agent can read the live away threshold.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("private_message.settings")
    ->set("number_of_seconds_considered_away", 4242)->save();
' >/dev/null 2>&1
echo "setup: private_message.settings number_of_seconds_considered_away=4242"

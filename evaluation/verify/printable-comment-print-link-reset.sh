#!/usr/bin/env bash
# Execution RESET: set printable.settings.printable_print_link_locations to the default [node]
# so verify FAILS until the agent adds 'comment'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("printable.settings")->set("printable_print_link_locations", ["node"])->save();' >/dev/null 2>&1
echo "reset: printable_print_link_locations = [node]"

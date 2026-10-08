#!/usr/bin/env bash
# Execution CLEANUP: restore printable.settings.printable_print_link_locations to [node].
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("printable.settings")->set("printable_print_link_locations", ["node"])->save();' >/dev/null 2>&1
echo "cleanup: printable_print_link_locations restored to [node]"

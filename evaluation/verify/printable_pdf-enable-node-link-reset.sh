#!/usr/bin/env bash
# Execution RESET: set printable_pdf_link_locations to the default [''] so verify FAILS until
# the agent enables the PDF link on nodes. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("printable.settings")->set("printable_pdf_link_locations", [""])->save();' >/dev/null 2>&1
echo "reset: printable_pdf_link_locations = ['']"

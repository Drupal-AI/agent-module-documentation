#!/usr/bin/env bash
# Execution CLEANUP: restore printable_pdf_link_locations to ['']. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("printable.settings")->set("printable_pdf_link_locations", [""])->save();' >/dev/null 2>&1
echo "cleanup: printable_pdf_link_locations restored to ['']"

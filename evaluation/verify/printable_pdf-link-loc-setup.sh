#!/usr/bin/env bash
# Introspection SETUP: configure printable_pdf_link_locations so the PDF link shows on nodes,
# for an agent to read back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("printable.settings")->set("printable_pdf_link_locations", ["node"])->save();' >/dev/null 2>&1
echo "setup: printable_pdf_link_locations = [node]"

#!/usr/bin/env bash
# Execution RESET: set save_pdf to the default FALSE so verify FAILS until the agent switches
# the PDF to download (attachment) mode. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("printable.settings")->set("save_pdf", FALSE)->save();' >/dev/null 2>&1
echo "reset: printable.settings save_pdf = FALSE"

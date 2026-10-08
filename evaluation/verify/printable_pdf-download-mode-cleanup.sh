#!/usr/bin/env bash
# Execution CLEANUP: restore save_pdf to FALSE (inline). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("printable.settings")->set("save_pdf", FALSE)->save();' >/dev/null 2>&1
echo "cleanup: printable.settings save_pdf restored to FALSE"

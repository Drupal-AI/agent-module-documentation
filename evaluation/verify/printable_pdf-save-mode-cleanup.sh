#!/usr/bin/env bash
# Introspection CLEANUP: restore save_pdf to its shipped default FALSE (inline). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("printable.settings")->set("save_pdf", FALSE)->save();' >/dev/null 2>&1
echo "cleanup: printable.settings save_pdf restored to FALSE"

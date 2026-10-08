#!/usr/bin/env bash
# Introspection CLEANUP: restore printable.settings.pdf_tool to its shipped default (empty).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("printable.settings")->set("pdf_tool", "")->save();' >/dev/null 2>&1
echo "cleanup: printable.settings pdf_tool restored to '' (default)"

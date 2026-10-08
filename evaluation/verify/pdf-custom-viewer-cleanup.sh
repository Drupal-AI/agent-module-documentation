#!/usr/bin/env bash
# Introspection CLEANUP: delete the `pdf.settings` config object written by the matching
# setup, restoring baseline (the pdf module ships no default config, so "absent" is
# baseline). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("pdf.settings")->delete();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: pdf.settings deleted"

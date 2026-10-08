#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped default (empty allowed-domains list).
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("noreferrer.settings")->set("allowed_domains", [])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: noreferrer.settings allowed_domains restored to []"

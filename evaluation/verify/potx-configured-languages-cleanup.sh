#!/usr/bin/env bash
# Introspection CLEANUP: remove the German (de) language added by setup, restoring baseline. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\language\Entity\ConfigurableLanguage;
  if ($l = ConfigurableLanguage::load("de")) { $l->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: configurable language de removed"

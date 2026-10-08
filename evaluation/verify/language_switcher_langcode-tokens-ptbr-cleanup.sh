#!/usr/bin/env bash
# CLEANUP: remove language 'pt-br' to restore the English-only baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\language\Entity\ConfigurableLanguage;
  if ($l = ConfigurableLanguage::load("pt-br")) { $l->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: language pt-br removed"

#!/usr/bin/env bash
# Restore eu_cookie_compliance_matomo.settings to shipped default (categories: []).
# Used as medium cleanup and hard reset. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("eu_cookie_compliance_matomo.settings")
    ->set("categories", [])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "restore: eu_cookie_compliance_matomo.settings categories=[]"

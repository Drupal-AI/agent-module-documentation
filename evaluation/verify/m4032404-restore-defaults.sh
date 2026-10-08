#!/usr/bin/env bash
# Restore m4032404.settings to shipped install defaults (admin_only=false, pages=[], negate=true).
# Used as medium cleanup and hard reset. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("m4032404.settings")
    ->set("admin_only", FALSE)->set("pages", [])->set("negate", TRUE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "restore: m4032404.settings = {admin_only:false, pages:[], negate:true}"

#!/usr/bin/env bash
# Execution CLEANUP: restore config defaults, remove the verify user, and remove the nl language.
set -uo pipefail
cd /var/www/html
drush cset admin_user_language.settings default_language_to_assign '-1' -y >/dev/null 2>&1
drush cset admin_user_language.settings prevent_user_override false -y >/dev/null 2>&1
drush php:eval '
  use Drupal\language\Entity\ConfigurableLanguage;
  if ($u = user_load_by_name("aul_verify_user")) { $u->delete(); }
  if ($l = ConfigurableLanguage::load("nl")) { $l->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: config defaults restored, verify user + nl language removed"

#!/usr/bin/env bash
# Execution RESET: ensure Dutch (nl) is an active language and baseline the module config to defaults
# (no preference / override allowed), and remove any leftover verify user. So a newly saved user does
# NOT get 'nl' until the agent configures it. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\language\Entity\ConfigurableLanguage;
  if (!ConfigurableLanguage::load("nl")) { ConfigurableLanguage::createFromLangcode("nl")->save(); }
  if ($u = user_load_by_name("aul_verify_user")) { $u->delete(); }
' >/dev/null 2>&1
drush cset admin_user_language.settings default_language_to_assign '-1' -y >/dev/null 2>&1
drush cset admin_user_language.settings prevent_user_override false -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: nl language present; admin_user_language.settings = -1 / false; no verify user"

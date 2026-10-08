#!/usr/bin/env bash
# Introspection SETUP: enable the Spanish (es) language so the toolbar switcher would list it and an
# agent can report the enabled languages. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\language\Entity\ConfigurableLanguage;
  if (!ConfigurableLanguage::load("es")) { ConfigurableLanguage::createFromLangcode("es")->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: language es enabled"

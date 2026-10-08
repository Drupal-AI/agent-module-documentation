#!/usr/bin/env bash
# Introspection SETUP: ensure language 'pt-br' is configured so the switcher shows its uppercase code.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\language\Entity\ConfigurableLanguage;
  if (!ConfigurableLanguage::load("pt-br")) { ConfigurableLanguage::createFromLangcode("pt-br")->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: language pt-br configured"

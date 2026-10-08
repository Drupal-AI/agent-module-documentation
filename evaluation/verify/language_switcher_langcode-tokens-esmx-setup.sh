#!/usr/bin/env bash
# Introspection SETUP: ensure language 'es-mx' is configured so the switcher shows its uppercase code.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\language\Entity\ConfigurableLanguage;
  if (!ConfigurableLanguage::load("es-mx")) { ConfigurableLanguage::createFromLangcode("es-mx")->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: language es-mx configured"

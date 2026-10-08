#!/usr/bin/env bash
# Introspection SETUP: add German (de) as a configured language so an inspecting agent can see
# which non-English languages potx could build templates for. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\language\Entity\ConfigurableLanguage;
  if (!ConfigurableLanguage::load("de")) {
    ConfigurableLanguage::createFromLangcode("de")->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: configurable language de (German) added"

#!/usr/bin/env bash
# Execution RESET: ensure the German (de) language is NOT enabled, so verify FAILS until the agent
# adds it (giving the switcher a second language to switch to). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\language\Entity\ConfigurableLanguage;
  if ($l = ConfigurableLanguage::load("de")) { $l->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: language de absent"

#!/usr/bin/env bash
# Introspection SETUP: set a known alphabetic group label ("Alphabet") in search_api_glossary.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("search_api_glossary.settings")->set("group_prefix", ["alpha" => "Alphabet", "numeric" => "0-9", "special" => "#"])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: search_api_glossary.settings group_prefix.alpha=Alphabet"

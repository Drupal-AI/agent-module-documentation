#!/usr/bin/env bash
# Introspection SETUP: set a known cache_tag_excludelist on cloudflarepurger.settings.
set -uo pipefail
cd /var/www/html
drush en cloudflarepurger -y >/dev/null 2>&1
drush php:eval '$c=\Drupal::configFactory()->getEditable("cloudflarepurger.settings");$c->set("cache_tag_excludelist",["config:","user:"])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: cloudflarepurger cache_tag_excludelist=[config:, user:]"

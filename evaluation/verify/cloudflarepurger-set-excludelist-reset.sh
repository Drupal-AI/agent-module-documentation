#!/usr/bin/env bash
# Execution RESET: empty cache_tag_excludelist so verify FAILS until agent adds a prefix.
set -uo pipefail
cd /var/www/html
drush en cloudflarepurger -y >/dev/null 2>&1
drush php:eval '$c=\Drupal::configFactory()->getEditable("cloudflarepurger.settings");$c->set("cache_tag_excludelist",[])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: cloudflarepurger cache_tag_excludelist empty"

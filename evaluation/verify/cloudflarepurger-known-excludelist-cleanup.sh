#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("cloudflarepurger.settings");$c->set("cache_tag_excludelist",[])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: cloudflarepurger cache_tag_excludelist restored to empty (shipped default)"

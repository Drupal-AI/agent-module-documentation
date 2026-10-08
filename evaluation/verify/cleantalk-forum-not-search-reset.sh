#!/usr/bin/env bash
# HARD reset: put cleantalk.settings in the install-default shape that FAILS the
# "protect forum topics, stop checking the search form" task — empty key, forum check OFF,
# search-form check ON (its default).
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("cleantalk.settings")
    ->set("cleantalk_authkey", "")
    ->set("cleantalk_check_forum_topics", FALSE)
    ->set("cleantalk_check_search_form", TRUE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: cleantalk_authkey cleared; forum-topics OFF, search-form ON"

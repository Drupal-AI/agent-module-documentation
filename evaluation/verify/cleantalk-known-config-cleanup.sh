#!/usr/bin/env bash
# MEDIUM introspection cleanup: restore cleantalk.settings to its install defaults
# (empty Access key; the shipped per-form protection defaults).
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("cleantalk.settings")
    ->set("cleantalk_authkey", "")
    ->set("cleantalk_check_comments", TRUE)
    ->set("cleantalk_check_register", TRUE)
    ->set("cleantalk_check_webforms", TRUE)
    ->set("cleantalk_check_contact_forms", TRUE)
    ->set("cleantalk_check_search_form", TRUE)
    ->set("cleantalk_check_forum_topics", FALSE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: cleantalk.settings restored to install defaults"

#!/usr/bin/env bash
# MEDIUM introspection setup: write a KNOWN cleantalk.settings baseline so the agent can be
# asked to read back the stored Access key and which forms are protected from live config.
# Grounded in config only (no live spam checks / network). Restored by
# cleantalk-known-config-cleanup.sh.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("cleantalk.settings")
    ->set("cleantalk_authkey", "known1234evalkey")
    ->set("cleantalk_check_comments", TRUE)
    ->set("cleantalk_check_register", TRUE)
    ->set("cleantalk_check_webforms", FALSE)
    ->set("cleantalk_check_contact_forms", FALSE)
    ->set("cleantalk_check_search_form", FALSE)
    ->set("cleantalk_check_forum_topics", TRUE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: cleantalk.settings key=known1234evalkey; comments+register+forum on, webforms/contact/search off"

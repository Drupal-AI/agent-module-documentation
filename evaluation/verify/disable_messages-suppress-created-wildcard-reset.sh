#!/usr/bin/env bash
# HARD reset: clear all suppression patterns so verify FAILs on empty state. Filtering stays
# enabled; the agent must add a wildcard pattern for "... has been created.". Re-run as the
# post-run cleaner to leave the site clean.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("disable_messages.settings")
    ->set("disable_messages_enable", "1")
    ->set("disable_messages_ignore_case", "1")
    ->set("disable_messages_ignore_patterns", "")
    ->set("disable_messages_ignore_regex", [])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: disable_messages patterns cleared (no messages suppressed)"

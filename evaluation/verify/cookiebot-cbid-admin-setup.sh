#!/usr/bin/env bash
# Introspection SETUP: set a known CBID and exclude admin pages, so an inspecting agent can read
# cookiebot.settings back off the live site. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("cookiebot.settings")
    ->set("cookiebot_cbid", "abcdabcd-1234-5678-9abc-abcdef012345")
    ->set("exclude_admin_theme", TRUE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: cookiebot_cbid=abcdabcd-1234-5678-9abc-abcdef012345 exclude_admin_theme=TRUE"

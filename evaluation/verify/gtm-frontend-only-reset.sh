#!/usr/bin/env bash
# Execution RESET for "fire GTM on the front end only and exclude the superuser". Forces a
# known WRONG baseline so verify FAILS until the agent fixes it: GTM enabled with a container
# ID, but firing on admin pages (admin-pages=1) and NOT excluding uid 1 (admin-disable=0).
# The agent must set admin-pages=0 and admin-disable=1 (keeping it enabled with an ID).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("gtm.settings")
    ->set("enable", 1)
    ->set("google-tag", "GTM-RESET00")
    ->set("admin-pages", 1)
    ->set("admin-disable", 0)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: admin-pages=1, admin-disable=0 (wrong) — agent must make it front-end only and exclude uid 1"
